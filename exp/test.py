from antlr4_verilog import InputStream, CommonTokenStream, ParseTreeWalker
from antlr4_verilog.verilog import VerilogLexer, VerilogParser, VerilogParserListener, VerilogParserVisitor
import antlr4
from io import StringIO
import os

res_index = 0

def pyflattenverilog(design:str, top_module:str, output_file:str):
  global res_index

  # output file handler
  output_file = output_file.split('.')[0] + '_' + str(res_index)+'.v'
  res_index += 1
  of_handler = open(output_file,'w')

  "This function is used to convert the verilog to a tree"
  def Design2Tree(Design):
      lexer = VerilogLexer(InputStream(Design))
      stream = CommonTokenStream(lexer)
      parser = VerilogParser(stream)
      tree = parser.source_text()
      return tree

  def Wire2Tree(Wire):
      lexer = VerilogLexer(InputStream(Wire))
      stream = CommonTokenStream(lexer)
      parser = VerilogParser(stream)
      tree = parser.net_declaration()
      return tree

  def Assign2Tree(Assign):
      lexer = VerilogLexer(InputStream(Assign))
      stream = CommonTokenStream(lexer)
      parser = VerilogParser(stream)
      tree = parser.continuous_assign()
      return tree

  # 1. TODO: Specify the top module and convert the design to a tree
  tree = Design2Tree(design)
  # top_module = 'adder_32bit'

  # 2. TODO: Get the top module node
  class MyTopModuleVisitor(VerilogParserVisitor):
    def __init__(self):
        self.top_module_node = ""
    def visitModule_declaration(self, ctx:VerilogParser.Module_declarationContext):
        module_name = ctx.module_identifier().getText()
        if module_name == top_module:
          self.top_module_node = ctx

  visitor = MyTopModuleVisitor()
  visitor.visit(tree)
  top_node_tree = visitor.top_module_node

  # Print the design of top module
  # print(design[top_node_tree.start.start:top_node_tree.stop.stop+1])

  # 3. TODO: Walk to the first node with initialization
  class MyModuleInstantiationVisitor(VerilogParserVisitor):
    def __init__(self):
      self.is_first_instantiation_module = False
      self.module_identifier = ""
      self.name_of_module_instance = ""
      self.list_of_ports_lhs = []
      self.list_of_ports_rhs = []
      self.list_of_ports_rhs_width = []

    def visitModule_instantiation(self, ctx: VerilogParser.Module_instantiationContext):
      if self.is_first_instantiation_module == False:
          self.is_first_instantiation_module = True
          self.first_instantiation = ctx
          self.module_identifier = ctx.module_identifier().getText()
          self.name_of_module_instance = ctx.module_instance()[0].name_of_module_instance().getText()
          # get ports connections
          ports_connections = ctx.module_instance()[0].list_of_port_connections()
          index = 0
          for child in ports_connections.getChildren():
            if index % 2 == 0:
              self.list_of_ports_rhs.append(child.expression().getText())
              self.list_of_ports_lhs.append(child.port_identifier().getText())
            index = index + 1
              
  visitor = MyModuleInstantiationVisitor()
  visitor.visit(top_node_tree)
  cur_module_identifier = visitor.module_identifier
  cur_name_of_module_instance = visitor.name_of_module_instance
  cur_prefix = cur_name_of_module_instance
  cur_list_of_ports_lhs = visitor.list_of_ports_lhs
  cur_list_of_ports_rhs = visitor.list_of_ports_rhs

  if cur_module_identifier == '':
     of_handler.close()
     os.remove(output_file)
     of_handler = open('/'.join(output_file.split('/')[:-1])+'/res.v','w')
     print(design[top_node_tree.start.start:top_node_tree.stop.stop+1],file=of_handler)
     of_handler.close()
     return -1


  class InstModulePortVisitor(VerilogParserVisitor):
    def __init__(self):
        self.inst_module_node = None
        self.list_of_ports_width = []
        self.list_of_ports_direction = []


    def _traverse_children(self,ctx):  
        if isinstance(ctx, antlr4.tree.Tree.TerminalNodeImpl):
          pass
        else:
          for child in ctx.getChildren():
            if isinstance(child, VerilogParser.Input_declarationContext):
              self.list_of_ports_direction.append('input')
              if isinstance(child.getChild(1), VerilogParser.Range_Context):
                self.list_of_ports_width.append(child.getChild(1).getText())
              else:
                self.list_of_ports_width.append('')
            if isinstance(child, VerilogParser.Output_declarationContext):
              self.list_of_ports_direction.append('output')
              if isinstance(child.getChild(1), VerilogParser.Range_Context):
                self.list_of_ports_width.append(child.getChild(1).getText())
              else:
                self.list_of_ports_width.append('')
            self._traverse_children(child)

    def visitModule_declaration(self, ctx: VerilogParser.Module_declarationContext):
        module_name = ctx.module_identifier().getText()
        if module_name == cur_module_identifier:
          self.inst_module_node = ctx
          self._traverse_children(self.inst_module_node)

  visitor = InstModulePortVisitor()
  visitor.visit(tree)
  cur_list_of_ports_lhs_width = visitor.list_of_ports_width
  cur_list_of_ports_direction = visitor.list_of_ports_direction


  # 4. Obtain new assignment with 'prefix', lhs and rhs and define the port as wire type
  # Implementation: define the lhs variable with new name in "assign field" and connect with rhs variable
  # e.g. variable 'a' in 'add_high in 'adder_32bit', It should be adder_32bit_add_high_a, first define it as wire type
  # i.g. 'wire adder_32bit_add_high_a;' 
  # i.e.`assign adder_32bit_add_high_a = a[31:16]` 
  cur_new_wire = []
  cur_new_assign = []
  for i in range(0,len(cur_list_of_ports_lhs)):
    cur_new_wire.append('wire ' + cur_list_of_ports_lhs_width[i] + ' '+cur_prefix + '_' + cur_list_of_ports_lhs[i] + ';')
    if cur_list_of_ports_direction[i] == 'input': 
      cur_new_assign.append('assign ' + cur_prefix + '_' + cur_list_of_ports_lhs[i] + ' = '+ cur_list_of_ports_rhs[i] + ';')
    else:
      cur_new_assign.append('assign ' + cur_list_of_ports_rhs[i] + ' = '+ cur_prefix + '_' + cur_list_of_ports_lhs[i] + ';')

  # 5. TODO: Rename all variable
  def getTokenText(ctx: VerilogParser.Module_declarationContext):
    ctx.getText()
    text = ""
    if ctx.getChildCount() == 0:
      return ""
    with StringIO() as builder:
      for child in ctx.getChildren():
            if isinstance(child, antlr4.tree.Tree.TerminalNodeImpl):
              builder.write(child.getText()+' ')
            else:   
              builder.write(child.getText()+' ')
      temp = builder.getvalue()
    for line in temp.splitlines():
        for char in line: 
          if char == ',' or char == ';'  :
            text += char + '\n'
          elif char == '\r\n':
            text += '\r\n'
          else:
            text += char
    return text
  
  # replace the corresponding variables with `cur_prefix`
  class InstModuleVisitor(VerilogParserVisitor):
    def __init__(self):
        super().__init__()
        self.inst_module_node = None
        self.inst_module_design = None
        self.start = None
        self.stop = None
        self.indent = 2

    "This function is used to traverse the tree and change the name of the instance"
    def _traverse_children(self,ctx,level=0):  
      if isinstance(ctx, antlr4.tree.Tree.TerminalNodeImpl):
        ctx.symbol.text = ctx.symbol.text + '\n'
      else:
        for child in ctx.getChildren():
          # Rename the variables
          if isinstance(child, VerilogParser.Simple_identifierContext):
              if isinstance(child.parentCtx.parentCtx, VerilogParser.Module_identifierContext):
                  pass
              elif isinstance(child.parentCtx.parentCtx, VerilogParser.Port_identifierContext):
                  pass
              else:
                  child.start.text = ' ' + cur_prefix + '_' + child.start.text

          # Adjust the indent
          # Assign block
          if isinstance(child, VerilogParser.Continuous_assignContext):
            child.start.text = '\n' + ' ' * level + child.start.text + ' '
            child.stop.text = child.stop.text +  '\n'
          
          # Always block
          if isinstance(child, VerilogParser.Always_constructContext):
            child.start.text = '\n' + ' ' * level + child.start.text + ' '
            child.stop.text = child.stop.text +  '\n'

          # Case block
          if isinstance(child, VerilogParser.Case_statementContext):
            child.start.text = '\n' + ' ' * level + child.start.text + ' '
            child.stop.text = child.stop.text +  '\n'
          self._traverse_children(child, level+1)

          # If block
          if isinstance(child, VerilogParser.Conditional_statementContext):
            child.start.text = '\n' + ' ' * level + child.start.text + ' '
            child.stop.text = child.stop.text +  '\n'
             
    def visitModule_declaration(self, ctx: VerilogParser.Module_declarationContext):
        module_name = ctx.module_identifier().getText()
        if module_name == cur_module_identifier:
          self.inst_module_node = ctx        
          self._traverse_children(self.inst_module_node)
          self.inst_module_design = getTokenText(self.inst_module_node)
          self.inst_module_node = Design2Tree(self.inst_module_design)

  visitor = InstModuleVisitor()
  visitor.visit(tree)
  inst_module_node = visitor.inst_module_node
  inst_module_design = visitor.inst_module_design
  print(inst_module_design)


  # 6. TODO: Get the instance body
  class InstBodyVisitor(VerilogParserVisitor):
    def __init__(self):
      super().__init__()
      self.start = None
      self.stop = None
      self.firstTerminal = False

    def ExtractStartAndStop(self,ctx):
      self.stop = ctx.ENDMODULE().getSymbol().start-1
      for child in ctx.getChildren():
         if isinstance(child, antlr4.tree.Tree.TerminalNodeImpl):
            if self.firstTerminal == False:
              self.start = child.symbol.stop+1
              self.firstTerminal = True
      
      
          
    def visitModule_declaration(self, ctx: VerilogParser.Module_declarationContext):
      self.ExtractStartAndStop(ctx)

  visitor = InstBodyVisitor()
  visitor.visit(inst_module_node)
  inst_body_start = visitor.start
  inst_body_stop = visitor.stop
  insert_part = inst_module_design[inst_body_start:inst_body_stop+1]
  print(insert_part,file=of_handler)

  # # 7. Replace the instance with new assignment and add instance body in the top module
  # class VerilogIdentifierVisitor(VerilogParserVisitor):
  #     def __init__(self):
  #         super().__init__()

  #     def visitModule_declaration(self, ctx: VerilogParser.Module_declarationContext):
  #         cur_start = None
  #         cur_stop = None
  #         if ctx.module_identifier().getText() == top_module:
  #             for child in ctx.getChildren():
  #                 if isinstance(child, VerilogParser.Non_port_module_itemContext) and isinstance(child.getChild(0).getChild(0), VerilogParser.Module_instantiationContext):
  #                     inst_name = child.getChild(0).getChild(0).getChild(1).getChild(0).getText()
  #                     if inst_name == cur_name_of_module_instance:
  #                         cur_start = child.start.start
  #                         cur_stop = child.stop.stop
  #                         print(design[:cur_start],file=of_handler)
  #                         for wire in cur_new_wire:
  #                             print(wire,file=of_handler)
  #                         for assign in cur_new_assign:
  #                             print(assign,file=of_handler)
  #                         print(insert_part,file=of_handler)
  #                         # print(design[cur_stop+1:],file=of_handler)
              
              
  # # Create a visitor instance and visit the top module node
  # visitor = VerilogIdentifierVisitor()
  # visitor.visit(top_node_tree)

  of_handler.close()
  of_handler = open(output_file,'r')
  tmp_flatten_design = of_handler.read()
  return tmp_flatten_design                