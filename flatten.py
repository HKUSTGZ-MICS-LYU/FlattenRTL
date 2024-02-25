from antlr4_verilog import InputStream, CommonTokenStream, ParseTreeWalker
from antlr4_verilog.verilog import VerilogLexer, VerilogParser, VerilogParserListener, VerilogParserVisitor
import antlr4
from io import StringIO
import os

res_index = 0

def pyflattenverilog(design:str, top_module:str, output_file:str, debug_mode:bool):
  global res_index

  # output file handler
  output_file = output_file.split('.')[0] + '_' + str(res_index)+'.v'
  if debug_mode:
    res_index += 1
  print("[Processing] %s"%(output_file))
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
  # According to module_identifier, we will get multiple name_of_module_instances
  class MyModuleInstantiationVisitor(VerilogParserVisitor):
    def __init__(self):
      self.is_first_instantiation_module = False
      self.module_identifier = ""
      self.name_of_module_instances = []
      self.list_of_ports_rhs = []
      self.list_of_ports_rhs_width = []

    def visitModule_instantiation(self, ctx: VerilogParser.Module_instantiationContext):
      if self.is_first_instantiation_module == False or self.module_identifier==ctx.module_identifier().getText():
          self.is_first_instantiation_module = True
          self.first_instantiation = ctx
          self.module_identifier = ctx.module_identifier().getText()
          self.name_of_module_instances.append(ctx.module_instance()[0].name_of_module_instance().getText())
          # get ports connections
          ports_connections = ctx.module_instance()[0].list_of_port_connections()
          for child in ports_connections.getChildren():
              if isinstance(child, antlr4.tree.Tree.TerminalNodeImpl):
                pass
              else:
                self.list_of_ports_rhs.append(child.expression().getText())

              
  visitor = MyModuleInstantiationVisitor()
  visitor.visit(top_node_tree)
  cur_module_identifier = visitor.module_identifier
  cur_name_of_module_instances = visitor.name_of_module_instances
  cur_prefixs = cur_name_of_module_instances
  cur_list_of_ports_rhs = visitor.list_of_ports_rhs

  if cur_module_identifier == '':
     of_handler.close()
     os.remove(output_file)
     flatten_path = '/'.join(output_file.split('/')[:-2])+'/flatten_'
     orig_file_name = '_'.join(output_file.split('/')[-1].split('_')[:-1])+'.v'
     flatten_path = flatten_path + orig_file_name
     of_handler = open(flatten_path,'w')
     print(design[top_node_tree.start.start:top_node_tree.stop.stop+1],file=of_handler)
     of_handler.close()
     os.system("bin/iStyle -n --style=ansi " + flatten_path)
     return -1
  else:
    print("[Processing] MODULE: %s\tNAME:%s"%(cur_module_identifier,cur_name_of_module_instances))


  class InstModulePortVisitor(VerilogParserVisitor):
    def __init__(self):
        self.inst_module_node = None
        self.is_first_instantiation_module = False
        self.list_of_ports_width = []
        self.list_of_ports_direction = []
        self.list_of_ports_type = []
        self.list_of_data_type = []
        self.list_of_ports_lhs = []


    def _traverse_children(self,ctx):  
        if isinstance(ctx, antlr4.tree.Tree.TerminalNodeImpl):
          pass
        else:
          for child in ctx.getChildren():
            if isinstance(child, VerilogParser.Input_declarationContext):
              self.list_of_ports_direction.append(child.INPUT().getText())
              self.list_of_ports_lhs.append(child.list_of_port_identifiers().getText())
              self.list_of_ports_type.append('wire')
              if child.range_() is not None:
                self.list_of_ports_width.append(child.range_().getText())  
              else:
                 self.list_of_ports_width.append('')

              if child.SIGNED() is not None:
                self.list_of_data_type.append(child.SIGNED().getText())
              else:
                self.list_of_data_type.append('')

            if isinstance(child, VerilogParser.Output_declarationContext):
              self.list_of_ports_direction.append(child.OUTPUT().getText())

              if child.REG() is not None:
                self.list_of_ports_type.append(child.REG().getText())
              else:
                self.list_of_ports_type.append('wire')

              
              if child.list_of_port_identifiers() is not None:
                self.list_of_ports_lhs.append(child.list_of_port_identifiers().getText())
              else:
                self.list_of_ports_lhs.append(child.list_of_variable_port_identifiers().getText())

              if child.range_() is not None:
                self.list_of_ports_width.append(child.range_().getText())  
              else:
                 self.list_of_ports_width.append('')

              if child.output_variable_type() is not None:
                self.list_of_data_type.append(child.output_variable_type().getText())
              else:
                self.list_of_data_type.append('')
                
            if isinstance(child, VerilogParser.Inout_declarationContext):
              self.list_of_ports_direction.append(child.INOUT().getText())
              self.list_of_ports_lhs.append(child.list_of_port_identifiers().getText())
              self.list_of_ports_type.append('wire')
              if child.range_() is not None:
                self.list_of_ports_width.append(child.range_().getText())  
              else:
                 self.list_of_ports_width.append('')

              if child.SIGNED() is not None:
                self.list_of_data_type.append(child.SIGNED().getText())
              else:
                self.list_of_data_type.append('')

              
            self._traverse_children(child)

    def visitModule_declaration(self, ctx: VerilogParser.Module_declarationContext):
        module_name = ctx.module_identifier().getText()
        if module_name == cur_module_identifier:
          if self.is_first_instantiation_module == False:
            self.is_first_instantiation_module = True
            self.inst_module_node = ctx
            self._traverse_children(self.inst_module_node)

  visitor = InstModulePortVisitor()
  visitor.visit(tree)
  cur_list_of_ports_lhs = visitor.list_of_ports_lhs
  cur_list_of_ports_lhs_width = visitor.list_of_ports_width
  cur_list_of_ports_direction = visitor.list_of_ports_direction
  cur_list_of_ports_type = visitor.list_of_ports_type
  cur_list_of_data_type = visitor.list_of_data_type


  # 4. Obtain new assignment with 'prefix', lhs and rhs and define the port as wire type
  # Implementation: define the lhs variable with new name in "assign field" and connect with rhs variable
  # e.g. variable 'a' in 'add_high in 'adder_32bit', It should be adder_32bit_add_high_a, first define it as wire type
  # i.g. 'wire adder_32bit_add_high_a;' 
  # i.e.`assign adder_32bit_add_high_a = a[31:16]` 
  cur_new_variable = []
  cur_new_assign = []

  for k in range(0,len(cur_prefixs)):
    # In case of the dismatch of port and definition, we define the length of port as len(cur_list_of_ports_rhs)/len(cur_prefix)
    len_instance_port = int(len(cur_list_of_ports_rhs)/len(cur_prefixs))
    try:
      for i in range(0,len_instance_port):
        if cur_list_of_data_type[i] != '':
          cur_new_variable.append(cur_list_of_data_type[i]  + cur_list_of_ports_lhs_width[i] + ' '+cur_prefixs[k] + '_' + cur_list_of_ports_lhs[i] + ';')
        elif cur_list_of_ports_type[i] == 'reg':
          cur_new_variable.append('reg '  + cur_list_of_ports_lhs_width[i] + ' '+cur_prefixs[k] + '_' + cur_list_of_ports_lhs[i] + ';')
        else:
          cur_new_variable.append('wire '  + cur_list_of_ports_lhs_width[i] + ' '+cur_prefixs[k] + '_' + cur_list_of_ports_lhs[i] + ';')
      
        if cur_list_of_ports_direction[i] == 'input': 
          # if cur_list_of_ports_type[i] == 'reg' :
          #   cur_new_assign.append('always @(*)' + ' ' + cur_prefixs[k] + '_' + cur_list_of_ports_lhs[i] + ' = '+ cur_list_of_ports_rhs[i] + ';')
          # else:
          cur_new_assign.append('assign ' + cur_prefixs[k] + '_' + cur_list_of_ports_lhs[i] + ' = '+ cur_list_of_ports_rhs[k*len_instance_port+i] + ';')
        else:
          # if cur_list_of_ports_type[i] == 'reg' :
          #   cur_new_assign.append('always @(*) ' + ' ' + cur_list_of_ports_rhs[i] + ' = '+ cur_prefixs[k] + '_' + cur_list_of_ports_lhs[i] + ';')
          # else:
            cur_new_assign.append('assign ' +  cur_list_of_ports_rhs[k*len_instance_port+i] + ' = '+ cur_prefixs[k] + '_' + cur_list_of_ports_lhs[i] + ';')
    except:
      print("Error: Potential the number of port and definition is not matched!")


  # 5. TODO: Get the start and stop index of the instance module
  class InstModuleVisitor(VerilogParserVisitor):
    def __init__(self):
        super().__init__()
        self.inst_module_node = None
        self.inst_module_design = None
        self.start = None
        self.stop = None
        self.indent = 2

    def visitModule_declaration(self, ctx: VerilogParser.Module_declarationContext):
        module_name = ctx.module_identifier().getText()
        if module_name == cur_module_identifier:
          self.start = ctx.start.start
          self.stop = ctx.stop.stop
          self.inst_module_node = ctx        
        

  visitor = InstModuleVisitor()
  visitor.visit(tree)
  inst_module_design = design[visitor.start:visitor.stop+1]

  # 6. TODO: Rename all variable in the instance module
  # replace the corresponding variables with `cur_prefixs`
  class InstModuleVisitor(VerilogParserVisitor):
    def __init__(self, cur_prefixs_index):
        super().__init__()
        self.inst_module_node = None
        self.inst_module_design = None
        self.start = None
        self.stop = None
        self.indent = 2
        self.cur_prefixs_index = cur_prefixs_index

    "This function is used to traverse the tree and change the name of the instance"
    def _traverse_children(self,ctx):  
      if isinstance(ctx, antlr4.tree.Tree.TerminalNodeImpl):
        pass
      else:
        for child in ctx.getChildren():
          # Rename the variables
          if isinstance(child, VerilogParser.Simple_identifierContext):
              if isinstance(child.parentCtx.parentCtx, VerilogParser.Module_identifierContext):
                  pass
              elif isinstance(child.parentCtx.parentCtx, VerilogParser.Port_identifierContext):
                  pass
              else:
                  child.start.text = ' ' + cur_prefixs[self.cur_prefixs_index] + '_' + child.start.text + ' '
          self._traverse_children(child)

    def visitModule_declaration(self, ctx: VerilogParser.Module_declarationContext):
        module_name = ctx.module_identifier().getText()
        if module_name == cur_module_identifier:
          self.start = ctx.start.start
          self.stop = ctx.stop.stop
          self.inst_module_node = ctx        
          self._traverse_children(self.inst_module_node)

  inst_module_design_trees = []
  inst_module_nodes = []
  for k in range(0,len(cur_prefixs)):
     tmp_inst_module_design = Design2Tree(inst_module_design)
     visitor = InstModuleVisitor(k)
     visitor.visit(tmp_inst_module_design)
     inst_module_design_trees.append(tmp_inst_module_design)
     inst_module_nodes.append(visitor.inst_module_node)


  # 5. TODO: Get the instance body
  # '''
  # The original instance body:
  # // 16 bit adder
  # module adder_16bit (
  #   input [15:0] a,
  #   input [15:0] b,
  #   output [15:0] sum  
  # );

  #   // high 8 bit adder
  #   adder_8bit add_high (
  #     .a(a[15:8]),
  #     .b(b[15:8]), 
  #     .sum(sum[15:8])
  #   );

  #   // low 8 bit adder
  #   adder_8bit add_low (
  #     .a(a[7:0]),
  #     .b(b[7:0]),
  #     .sum(sum[7:0]) 
  #   );

  # endmodule 

  # The output instance body:

  # adder_8bit  add_high_add_high (.a( add_high_a [15:8]),.b( add_high_b [15:8]),.sum( add_high_sum [15:8])); 
  # adder_8bit  add_high_add_low (.a( add_high_a [7:0]),.b( add_high_b [7:0]),.sum( add_high_sum [7:0]));

  # '''
  # inst_body_list = []
  # if inst_module_node.getChildCount() >= 5:
  #   for i in range(4, inst_module_node.getChildCount()-1):
  #     inst_body_list.append(inst_module_node.getChild(i))
  # else:
  #   print("Instance body is empty!")

  # print to check the instance body
  # for i in range(0,len(inst_body_list)):
  #    print(inst_body_list[i].getText())

  # 8. TODO: Process the format of the instance body
  class InstBodyVisitor(VerilogParserVisitor):
    def __init__(self):
      super().__init__()
      self.inst_module_node = None
      self.inst_module_design = None
      self.text = ""

    def formatProcess(self,ctx):
      self._traverse_children(ctx)
      if ctx.getChildCount() == 0:
        return ""
      
      with StringIO() as builder:
        for child in ctx.getChildren():  
                builder.write(child.getText()+' ')

        temp = builder.getvalue()
      for line in temp.splitlines():
          for char in line: 
            if char == '#':
               self.text += '\n'
            else:
              self.text += char
              
    def _traverse_children(self,ctx,indent = 0):  
      if isinstance(ctx, antlr4.tree.Tree.TerminalNodeImpl):
        pass
      else:
        for child in ctx.getChildren():
          # Adjust the indent
          #Port defination
          if isinstance(child, VerilogParser.Port_declarationContext):
             child.start.text = '#' + ' ' * indent + child.start.text + ' '
          #Parameter defination
          if isinstance(child, VerilogParser.Parameter_declarationContext):
            child.start.text = '#' + ' ' * indent + child.start.text 
          #Reg defination
          if isinstance(child, VerilogParser.Reg_declarationContext):
            child.start.text = '#' + ' ' * indent + child.start.text
          #Wire defination
          if isinstance(child, VerilogParser.Net_declarationContext):
            child.start.text = '#' + ' ' * indent + child.start.text
          #Integer defination
          if isinstance(child, VerilogParser.Integer_declarationContext):
            child.start.text = '#' + ' ' * indent + child.start.text
          # Assign block
          if isinstance(child, VerilogParser.Continuous_assignContext):
            child.start.text = '#' + ' ' * indent + child.start.text + ' '
          # Always block
          if isinstance(child, VerilogParser.Always_constructContext):
            child.start.text = '#' + ' ' * indent + child.start.text + ' '
            child.stop.text = child.stop.text + '#'
          if isinstance(child, VerilogParser.Event_expressionContext):
            child.start.text = ' ' + child.start.text + ' '
          # if isinstance(child, VerilogParser.Event_expressionContext) and child.getText() == 'negedge':
          #   child.symbol.text = ' ' + child.symbol.text + ' '
          # Case block
          if isinstance(child, VerilogParser.Case_statementContext):
            child.start.text = '#' + ' ' * indent + child.start.text + ' '
            child.stop.text = '#' + ' ' * indent + child.stop.text + ' '

          if isinstance(child, VerilogParser.Case_itemContext):
            child.start.text = '#' + ' ' * indent + child.start.text + ' '

          # If block
          if isinstance(child, VerilogParser.Conditional_statementContext):
            child.start.text = '#' + ' ' * indent + child.start.text + ' '
            # child.stop.text = '#' + ' ' * indent + child.stop.text + ' '
          if isinstance(child, antlr4.tree.Tree.TerminalNodeImpl) and child.symbol.text == 'else':
            child.symbol.text = '#' + ' ' * indent + child.symbol.text + ' '

          # Nonblocking assignment
          if isinstance(child, VerilogParser.Nonblocking_assignmentContext):
            child.start.text = '#' + ' ' * indent + child.start.text + ' '
  
          # Seqblocking assignment
          if isinstance(child, VerilogParser.Seq_blockContext):
            child.start.text = '#' + ' ' * indent + child.start.text + ' '
            child.stop.text = '#' + ' ' * indent + child.stop.text + ' '

          # Blocking assignment
          if isinstance(child, VerilogParser.Blocking_assignmentContext):
            child.start.text = '#' + ' ' * indent + child.start.text + ' '
          # Instance block
          if isinstance(child, VerilogParser.Module_instantiationContext):
            child.start.text = '#' + ' ' * indent + child.start.text + ' '
          self._traverse_children(child,indent+1)
    def visitModule_declaration(self, ctx: VerilogParser.Module_declarationContext):
      self.inst_module_node = ctx
      self.formatProcess(self.inst_module_node)
      self.inst_module_node = Design2Tree(self.text)

  inst_module_designs = []
  for k in range(0,len(cur_prefixs)):
     visitor = InstBodyVisitor()
     visitor.visit(inst_module_nodes[k])
     inst_module_nodes[k] = visitor.inst_module_node
     inst_module_designs.append(visitor.text)

  # 7. TODO: Get the instance body
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

  insert_parts = []
  for k in range(0,len(cur_prefixs)):
    visitor = InstBodyVisitor()
    visitor.visit(inst_module_nodes[k])
    insert_parts.append(inst_module_designs[k][visitor.start:visitor.stop])


  # 8. Replace the instance with new assignment and add instance body in the top module
  class VerilogIdentifierVisitor(VerilogParserVisitor):
      def __init__(self):
          super().__init__()
          self.start = []
          self.stop = []
      def _traverse_children(self,ctx):
          if isinstance(ctx, antlr4.tree.Tree.TerminalNodeImpl):
              pass
          else:
              for child in ctx.getChildren():
                if isinstance(child, VerilogParser.Module_instantiationContext):
                  for cur_name in cur_name_of_module_instances:
                    if child.module_instance()[0].name_of_module_instance().getText() == cur_name:
                      self.start.append(child.start.start)
                      self.stop.append(child.stop.stop)
                self._traverse_children(child)
      def visitModule_declaration(self, ctx: VerilogParser.Module_declarationContext):
          if ctx.module_identifier().getText() == top_module:
                self._traverse_children(ctx)
                print(design[:self.start[0]],file=of_handler)
                for wire in cur_new_variable:
                    print(wire,file=of_handler)
                print(insert_parts[0],file=of_handler)
                for i in range(1, len(self.start)):
                    print(design[self.stop[i-1]+1:self.start[i]],file=of_handler)
                    print(insert_parts[i],file=of_handler)
                for assign in cur_new_assign:
                    print(assign,file=of_handler)
                print(design[self.stop[-1]+1:],file=of_handler)
              
              
  # Create a visitor instance and visit the top module node
  visitor = VerilogIdentifierVisitor()
  visitor.visit(top_node_tree)
  

  of_handler.close()
  of_handler = open(output_file,'r')
  tmp_flatten_design = of_handler.read()
  return tmp_flatten_design