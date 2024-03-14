from antlr4_verilog import InputStream, CommonTokenStream, ParseTreeWalker
from antlr4_verilog.verilog import VerilogLexer, VerilogParser, VerilogParserListener, VerilogParserVisitor
import antlr4
from io import StringIO
import os

def Parse(Design):
   lexer = VerilogLexer(InputStream(Design))
   stream = CommonTokenStream(lexer)
   parser = VerilogParser(stream)
   return parser

"This function is used to convert the verilog to a tree"
def Design2Tree(Design):
   parser = Parse(Design)
   tree = parser.source_text()
   return tree

def Port2Tree(Design):
   parser = Parse(Design)
   tree = parser.list_of_port_declarations()
   return tree

def Parameter2Tree(Design):
   parser = Parse(Design)
   tree = parser.module_parameter_port_list()
   return tree

def Module2Tree(Design):
   parser = Parse(Design)
   tree = parser.module_item()
   return tree

def NetDeclare2Tree(Design):
   parser = Parse(Design)
   tree = parser.net_declaration()
   return tree

def RegDeclare2Tree(Design):
   parser = Parse(Design)
   tree = parser.reg_declaration()
   return tree

def ModIns2Tree(Design):
   parser = Parse(Design)
   tree = parser.module_instantiation()
   return tree

def formatter_file(design, outputpath):
   def formatter_design(tree):  

      
      "This function is used to get the port list of the module"
      class MyModuleVisitor(VerilogParserVisitor):
         class myParameterVisitor(VerilogParserVisitor):
            def __init__(self):
               self.parameter = []

            def empty_all_text(self,ctx):
               if isinstance(ctx, antlr4.tree.Tree.TerminalNodeImpl):
                  try:
                     ctx.start.text = ''
                     ctx.stop.text = ''
                  except:
                     ctx.symbol.text = ''
                     pass
               else:
                  for child in ctx.getChildren():
                     self.empty_all_text(child)

               
            def visitParameter_declaration(self, ctx: VerilogParser.Parameter_declarationContext):
               if isinstance(ctx.parentCtx, VerilogParser.Module_declarationContext):
                  pass
               else:
                  for i in range(0,len(ctx.list_of_param_assignments().param_assignment())):
                     param_assign = ctx.list_of_param_assignments().param_assignment()[i]
                     self.parameter.append([param_assign.getChild(0).getText(), param_assign.getChild(2).getText()])
                  self.empty_all_text(ctx.parentCtx)

         def __init__(self):
            self.module_port = {}
            self.block_port = {}
            self.block_parameter = []
            self.module = None
            self.non_port_parameter = []

         def visitModule_declaration(self, ctx:VerilogParser.Module_declarationContext):
            # 1. Get the all parameter assignment, we assume the parameter assignment is all port definition or block definition
            parameter_visitor = self.myParameterVisitor()
            parameter_visitor.visit(ctx)
            self.non_port_parameter = parameter_visitor.parameter

            self._visit_module_declaration(ctx)
            self.module = ctx
               
         # visit module declaration
         def _visit_module_declaration(self,ctx:VerilogParser.Module_declarationContext):  
            if isinstance(ctx, antlr4.tree.Tree.TerminalNodeImpl):
               pass
            else:
               for child in ctx.getChildren():
                  if isinstance(child, VerilogParser.List_of_port_declarationsContext):
                     self._visit_port_list(child)
                  if isinstance(child, VerilogParser.Module_itemContext):
                     self._visit_port_declaration(child)

         # visit port declaration
         def _visit_port_declaration(self, ctx):
            if isinstance(ctx, antlr4.tree.Tree.TerminalNodeImpl):
               pass
            else:
               for child in ctx.getChildren():
                  if isinstance(child, VerilogParser.Port_declarationContext):
                     if isinstance(child.getChild(0), VerilogParser.Input_declarationContext):
                        self._visit_input_declaration(child.getChild(0))

                  if isinstance(child.getChild(0), VerilogParser.Output_declarationContext):
                     self._visit_output_declaration(child.getChild(0))
                  
                  if isinstance(child.getChild(0), VerilogParser.Inout_declarationContext):
                     self._visit_inout_declaration(child.getChild(0))

                  if isinstance(child, VerilogParser.Reg_declarationContext):
                     self._visit_reg_declaration(child)

                  if isinstance(child, VerilogParser.Integer_declarationContext):
                     self._visit_integer_declaration(child)

                  if isinstance(child, VerilogParser.Block_nameContext):
                     index_of_child = child.parentCtx.children.index(child)

                  if isinstance(child, VerilogParser.Block_item_declarationContext):
                     self._visit_block_declaration(child)

                  # Delete duplicate wire
                  if isinstance(child, VerilogParser.Net_declarationContext):
                     for i in range(0,child.list_of_net_identifiers().getChildCount()):
                        name = child.list_of_net_identifiers().getChild(i).getText()
                        index_of_child = child.parentCtx.children.index(child)
                        if self.module_port.get(name) != None:
                           del child.parentCtx.children[index_of_child]
                           if index_of_child == 0 and child.list_of_net_identifiers().getChildCount()!=1:
                              del child.parentCtx.children[index_of_child+1]
                           elif index_of_child != 0:
                              del child.parentCtx.children[index_of_child-1]
                           
               self._visit_port_declaration(child)

         # visit integer declaration
         def _visit_integer_declaration(self, ctx: VerilogParser.Integer_declarationContext):
            for name in ctx.list_of_variable_identifiers().getText().split(','):
               if name in self.module_port:
                  self.module_port[name]['port_type'] = 'integer'

         # visit reg declaration
         def _visit_reg_declaration(self, ctx: VerilogParser.Reg_declarationContext):
            for name in ctx.list_of_variable_identifiers().getText().split(','):
               if name in self.module_port:
                  self.module_port[name]['port_type'] = 'reg'
         
         # visit input declaration
         def _visit_input_declaration(self, ctx: VerilogParser.Input_declarationContext):
            for name in ctx.list_of_port_identifiers().getText().split(','):
               if name in self.module_port:
                  self.module_port[name]['port_direction'] = 'input'
               if ctx.range_() != None:
                  self.module_port[name]['port_width'] = ctx.range_().getText()
               if ctx.SIGNED() != None:
                  self.module_port[name]['data_type'] = ctx.SIGNED().getText()
            
         # visit output declaration
         def _visit_output_declaration(self, ctx: VerilogParser.Output_declarationContext):
            if ctx.list_of_port_identifiers() != None:
               for name in ctx.list_of_port_identifiers().getText().split(','):
                  if name in self.module_port:
                     self.module_port[name]['port_direction'] = 'output'
                  if ctx.range_() != None:
                     self.module_port[name]['port_width'] = ctx.range_().getText()
                  if ctx.SIGNED() != None:
                     self.module_port[name]['data_type'] = ctx.SIGNED().getText()
            else:
               for name in ctx.list_of_variable_port_identifiers().getText().split(','):
                  if name in self.module_port:
                     self.module_port[name]['port_direction'] = 'output'
                  if ctx.REG() != None:
                     self.module_port[name]['port_type'] = ctx.REG().getText()
                  if ctx.range_() != None:
                     self.module_port[name]['port_width'] = ctx.range_().getText()
                  if ctx.SIGNED() != None:
                     self.module_port[name]['data_type'] = ctx.SIGNED().getText()

         # visit inout declaration
         def _visit_inout_declaration(self, ctx: VerilogParser.Inout_declarationContext):
            for name in ctx.list_of_port_identifiers().getText().split(','):
               if name in self.module_port:
                  self.module_port[name]['port_direction'] = 'inout'
               if ctx.range_() != None:
                  self.module_port[name]['port_width'] = ctx.range_().getText()
               if ctx.SIGNED() != None:
                  self.module_port[name]['data_type'] = ctx.SIGNED().getText()

         def is_parent_implicit_port(self,ctx):
            if ctx == None:
               return False
            
            if isinstance(ctx,VerilogParser.Port_implicitContext):
               return True
            else:
               return self.is_parent_implicit_port(ctx.parentCtx)

         # visit port list
         def _visit_port_list(self,ctx):
            if isinstance(ctx, antlr4.tree.Tree.TerminalNodeImpl):
               pass
            else:
               for child in ctx.getChildren():
                  if isinstance(child, VerilogParser.Port_identifierContext):
                     port_name = child.getText()
                     self.module_port[port_name] = {'data_type': '','port_type':'wire','port_width':'','port_direction':''}
                     if not self.is_parent_implicit_port(child):
                        self.module_port[port_name]['port_direction'] = child.parentCtx.parentCtx.getChild(0).getText()
                        if child.parentCtx.parentCtx.range_() !=None:
                           self.module_port[port_name]['port_width'] = child.parentCtx.parentCtx.range_().getText()
                        if child.parentCtx.parentCtx.SIGNED() !=None:
                           self.module_port[port_name]['data_type'] = ctx.SIGNED().getText()
                        continue
                  self._visit_port_list(child)

         # visit block declaration
         def _visit_block_declaration(self, ctx: VerilogParser.Block_item_declarationContext):
            if ctx.parameter_declaration() != None:
               self.block_parameter.append(ctx.parameter_declaration().PARAMETER().getText() + ' ' + ctx.parameter_declaration().list_of_param_assignments().getText()+';')
            if ctx.REG() != None:
               self.block_port[ctx.list_of_block_variable_identifiers().getText()] = {'port_type': '','data_type': '','port_width': ''}
               self.block_port[ctx.list_of_block_variable_identifiers().getText()]['port_type'] = ctx.REG().getText()
               if ctx.range_() != None:
                  self.block_port[ctx.list_of_block_variable_identifiers().getText()]['port_width'] = ctx.range_().getText()
               if ctx.SIGNED() != None:
                  self.block_port[ctx.list_of_block_variable_identifiers().getText()]['data_type'] = ctx.SIGNED().getText()
            if ctx.INTEGER() != None:
               self.block_port[ctx.list_of_block_variable_identifiers().getText()] = {'port_type': '','data_type': '','port_width': ''}
               self.block_port[ctx.list_of_block_variable_identifiers().getText()]['port_type'] = ctx.INTEGER().getText()
               if ctx.range_() != None:
                  self.block_port[ctx.list_of_block_variable_identifiers().getText()]['port_width'] = ctx.range_().getText()
               if ctx.SIGNED() != None:
                  self.block_port[ctx.list_of_block_variable_identifiers().getText()]['data_type'] = ctx.SIGNED().getText()


      
      # 2. Module Declaration Visitor
      visitor = MyModuleVisitor()
      visitor.visitModule_declaration(tree)
      module_port = visitor.module_port
      remove_port_list = module_port.copy()
      block_parameter = visitor.block_parameter
      block_port = visitor.block_port
      non_port_parameter = visitor.non_port_parameter


      # 3. Module Item Modifier
      # wire a,b;
      # To:
      # wire a;
      # wire b;
      #
      # A a(x,y), b(x,y);
      # To
      # A a(x,y);
      # A b(x,y);

      class MyModuleItemModifier(VerilogParserVisitor):
         def __init__(self):
            pass
         
         def _modify_net_declaration(self, ctx:VerilogParser.Net_declarationContext):
            _before_identifier = ""
            if ctx.list_of_net_identifiers().getChildCount()!=1:
               for i in range(0,ctx.getChildCount()-2):
                  _before_identifier += ctx.getChild(i).getText() + ' '
               new_net_declaration = []
               for i in range(0,ctx.list_of_net_identifiers().getChildCount()):
                  if isinstance(ctx.list_of_net_identifiers().getChild(i),VerilogParser.Net_idContext):
                     new_net_declaration.append(_before_identifier + ctx.list_of_net_identifiers().getChild(i).getText() + ';')

               index_of_child = ctx.parentCtx.children.index(ctx)
               del ctx.parentCtx.children[index_of_child]

               for i in range(0,len(new_net_declaration)):
                  ctx.parentCtx.children.insert(index_of_child + i, NetDeclare2Tree(new_net_declaration[i]))
            else:
               pass

         def _modify_reg_declaration(self, ctx:VerilogParser.Reg_declarationContext):
            _before_identifier = ""
            if ctx.list_of_variable_identifiers().getChildCount()!=1:
               for i in range(0,ctx.getChildCount()-2):
                  _before_identifier += ctx.getChild(i).getText() + ' '
               new_reg_declaration = []
               for i in range(0,ctx.list_of_variable_identifiers().getChildCount()):
                  if isinstance(ctx.list_of_variable_identifiers().getChild(i),VerilogParser.Variable_typeContext):
                     new_reg_declaration.append(_before_identifier + ctx.list_of_variable_identifiers().getChild(i).getText() + ';')

               index_of_child = ctx.parentCtx.children.index(ctx)
               del ctx.parentCtx.children[index_of_child]

               for i in range(0,len(new_reg_declaration)):
                  ctx.parentCtx.children.insert(index_of_child + i, RegDeclare2Tree(new_reg_declaration[i]))
            else:
               pass
         
         def _modify_module_instantiation(self, ctx:VerilogParser.Module_instantiationContext):
            _before_identifier = ""
            if len(ctx.module_instance())>1:
               for i in range(0,ctx.getChildCount()-1):
                  if isinstance(ctx.getChild(i), VerilogParser.Module_instanceContext):
                     break
                  _before_identifier += ctx.getChild(i).getText() + ' '
               new_module_instantiation = []
               for item in ctx.module_instance():
                  new_module_instantiation.append(_before_identifier+design[item.start.start:item.stop.stop+1] + ';')

               index_of_child = ctx.parentCtx.children.index(ctx)
               del ctx.parentCtx.children[index_of_child]

               for i in range(0,len(new_module_instantiation)):
                  ctx.parentCtx.children.insert(index_of_child + i, ModIns2Tree(new_module_instantiation[i]))
            else:
               pass
         
         def _traverse_children(self,ctx):
            if isinstance(ctx, antlr4.tree.Tree.TerminalNodeImpl):
               pass
            else:
               for child in ctx.getChildren():
                  if isinstance(child, VerilogParser.Net_declarationContext):
                     self._modify_net_declaration(child)
                  elif isinstance(child, VerilogParser.Reg_declarationContext):
                     self._modify_reg_declaration(child)
                  elif isinstance(child, VerilogParser.Module_instantiationContext):
                     self._modify_module_instantiation(child)

                  self._traverse_children(child)

         def visitModule_item(self, ctx: VerilogParser.Module_itemContext):
            self._traverse_children(ctx)
         
      visitor = MyModuleItemModifier()
      visitor.visitModule_item(tree)



      "This function is used to remove the port and define the port in the list"
      class PortModifyVisitor(VerilogParserVisitor):
         def __init__(self):
            self.module = None
         
         # def is_implicit_port_definition(self, ctx:VerilogParser.Module_declarationContext):
         #    return ctx.list_of_port_declarations().port_declaration() == []
         
         def _insert_parameter(self, ctx:VerilogParser.Module_declarationContext):
            parameter = '#(\n\t'
            if non_port_parameter != []:
               for i , item in enumerate(non_port_parameter):
                  parameter += "parameter  "+item[0] + '=' + item[1]
                  if i == len(non_port_parameter) - 1:
                     parameter += '\n'
                  else:
                     parameter += ',\n'
               parameter += '\n);\n'
               ctx.children.insert(2, Parameter2Tree(parameter))
         def modifyModule_declaration(self, ctx:VerilogParser.Module_declarationContext):
            self._insert_parameter(ctx)
            self._modify_module_declaration(ctx)
            self._remove_signal_declaration(ctx)
            self._add_block_content(ctx)
            self._remove_block_content(ctx)
            # if self.is_implicit_port_definition(ctx):
            self.module = ctx
         
         def _modify_module_declaration(self,ctx:VerilogParser.Module_declarationContext):  
            if isinstance(ctx, antlr4.tree.Tree.TerminalNodeImpl):
               pass
            else:
               for child in ctx.getChildren():
                  if isinstance(child, VerilogParser.List_of_port_declarationsContext):
                     new_child = self._modify_port_list(child)
                     index_of_child = child.parentCtx.children.index(child)
                     child.parentCtx.children[index_of_child] = new_child

         def _modify_port_list(self, ctx):
            port_defination = '('
            for index, (key, value) in enumerate(module_port.items()):
               if index == len(module_port) - 1:
                  if value['port_type'] == 'wire':
                     port_defination += '\n' + value['port_direction']  + ' ' + value['data_type'] + ' ' + value['port_width'] + ' ' + key + ');' + '\n'
                  else:
                     port_defination += '\n' + value['port_direction'] + ' ' + value['port_type'] + ' ' + value['data_type'] + ' ' + value['port_width'] + ' ' + key + ');' + '\n'
               else:
                  if value['port_type'] == 'wire':
                     port_defination += '\n' + value['port_direction']  + ' ' + value['data_type'] + ' ' + value['port_width'] + ' ' + key + ','
                  else:
                     port_defination += '\n' + value['port_direction'] + ' ' + value['port_type'] + ' ' + value['data_type'] + ' ' + value['port_width'] + ' ' + key + ','
               
            ctx = Port2Tree(port_defination)
            return ctx
         
         def _remove_signal_declaration(self, ctx):
            if isinstance(ctx, antlr4.tree.Tree.TerminalNodeImpl):
               pass
            else:
               for child in list(ctx.children):
                  sig_name = None
                  find_sig = False
                  if isinstance(child, VerilogParser.Module_itemContext):
                     index_of_child = child.parentCtx.children.index(child)
                     find_sig = self._find_port_declaration(child)
                     if find_sig:
                           sig_name = self._get_simple_identifier(child)
                     if sig_name in remove_port_list:
                           del child.parentCtx.children[index_of_child]
                     

         def _find_port_declaration(self, ctx):
            result = False
            if isinstance(ctx, antlr4.tree.Tree.TerminalNodeImpl):
               pass
            else:
               for child in ctx.getChildren():
                     if isinstance(child, VerilogParser.Port_declarationContext):
                        result = True
                     elif isinstance(child, VerilogParser.Reg_declarationContext):
                        result = True
                     elif isinstance(child, VerilogParser.Integer_declarationContext):
                        result = True
                     else:
                        result = self._find_port_declaration(child)
                     if result:
                        break
            return result

         def _get_simple_identifier(self, ctx: VerilogParser.Module_itemContext):
            sig_name = None
            if isinstance(ctx, antlr4.tree.Tree.TerminalNodeImpl):
               pass
            else:
               for child in ctx.getChildren():
                     if isinstance(child, VerilogParser.Simple_identifierContext):
                        sig_name = child.getText()
                     elif isinstance(child, VerilogParser.Range_Context):
                        pass
                     else:
                        sig_name = self._get_simple_identifier(child)
                     if sig_name is not None:
                        break
            return sig_name
         
         def _add_block_content(self, ctx):
            for child in ctx.getChildren():
               if isinstance(child, antlr4.tree.Tree.TerminalNodeImpl) and child.symbol.text == ';':
                  index = ctx.children.index(child)
                  for i , item in enumerate(block_parameter):
                     parameter = item
                     ctx.children.insert(index + i + 1, Parameter2Tree(parameter))
                  for key, value in block_port.items():
                     defination = value['port_type'] + ' ' + value['data_type'] + ' ' + value['port_width'] + ' ' + key + ';'
                     ctx.children.insert(index + len(block_parameter) + 1, Module2Tree(defination))

         def _remove_block_content(self, ctx):
            if isinstance(ctx, antlr4.tree.Tree.TerminalNodeImpl):
               pass
            else:
               for child in list(ctx.children):
                  if isinstance(child, VerilogParser.Block_item_declarationContext):
                     index_of_child = child.parentCtx.children.index(child)
                     del child.parentCtx.children[index_of_child]
                  else:
                     self._remove_block_content(child)


      visitor = PortModifyVisitor()
      visitor.modifyModule_declaration(tree)
      module = visitor.module


      class FormatVisitor(VerilogParserVisitor):
         def __init__(self):
            super().__init__()
            self.module_node = None
            self.module_design = None
            self.text = ""

         def formatProcess(self,ctx):
            self._traverse_children(ctx)
            if ctx.getChildCount() == 0:
               return ""
            builder = StringIO()
            for child in ctx.getChildren():  
                  builder.write(child.getText()+' ')
            temp = builder.getvalue()
            builder.close()
            for line in temp.splitlines():
               for char in line: 
                  if char == chr(31):
                     self.text += '\n'
                  else:
                     self.text += char
                  
         def _traverse_children(self,ctx,indent = 0):  
            if isinstance(ctx, VerilogParser.Module_declarationContext):
               ctx.stop.text = chr(31) + ctx.stop.text + chr(31)
            if isinstance(ctx, antlr4.tree.Tree.TerminalNodeImpl):
               pass
            else:
               for child in ctx.getChildren():
               # Adjust the indent
               # Port defination
                  if isinstance(child, VerilogParser.Input_declarationContext) or isinstance(child, VerilogParser.Output_declarationContext) or isinstance(child, VerilogParser.Inout_declarationContext):
                     for i, item in enumerate(child.getChildren()):
                        if i == 0:
                           item.symbol.text = chr(31) + ' ' * indent + item.symbol.text
                        else:
                           if isinstance(item, antlr4.tree.Tree.TerminalNodeImpl):
                              item.symbol.text = ' ' + item.symbol.text + ' '
                           else:
                              item.start.text = ' ' + item.start.text

                  
                  #Reg defination
                  if isinstance(child, VerilogParser.Reg_declarationContext):
                     for i, item in enumerate(child.getChildren()):
                        if i == 0:
                           if isinstance(item, antlr4.tree.Tree.TerminalNodeImpl):
                              item.symbol.text = chr(31) + ' ' * indent + item.symbol.text
                           else: 
                              item.start.text = chr(31) + ' ' * indent + item.start.text
                        else:
                           if isinstance(item, antlr4.tree.Tree.TerminalNodeImpl):
                              item.symbol.text = ' ' + item.symbol.text + ' '
                           else:
                              item.start.text = ' ' + item.start.text

                  #Wire defination
                  if isinstance(child, VerilogParser.Net_declarationContext):
                     for i, item in enumerate(child.getChildren()):
                        if i == 0:
                           if isinstance(item, antlr4.tree.Tree.TerminalNodeImpl):
                              item.symbol.text = chr(31) + ' ' * indent + item.symbol.text
                           else: 
                              item.start.text = chr(31) + ' ' * indent + item.start.text
                        else:
                           if isinstance(item, antlr4.tree.Tree.TerminalNodeImpl):
                              item.symbol.text = ' ' + item.symbol.text + ' '
                           else:
                              item.start.text = ' ' + item.start.text
                              
                  #Parameter defination
                  if isinstance(child, VerilogParser.Parameter_declarationContext):
                     child.start.text = chr(31) + ' ' * indent + child.start.text 
                  #Integer defination
                  if isinstance(child, VerilogParser.Integer_declarationContext):
                     for i, item in enumerate(child.getChildren()):
                        if i == 0:
                           if isinstance(item, antlr4.tree.Tree.TerminalNodeImpl):
                              item.symbol.text = chr(31) + ' ' * indent + item.symbol.text
                           else: 
                              item.start.text = chr(31) + ' ' * indent + item.start.text
                        else:
                           if isinstance(item, antlr4.tree.Tree.TerminalNodeImpl):
                              item.symbol.text = ' ' + item.symbol.text + ' '
                           else:
                              item.start.text = ' ' + item.start.text

                  # module item 
                  if isinstance(child, VerilogParser.Module_itemContext):
                     child.start.text = ' ' * indent + child.start.text

                  # Assign block
                  if isinstance(child, VerilogParser.Continuous_assignContext):
                     child.start.text = chr(31) + ' ' * indent + child.start.text + ' '
                  # Always block
                  if isinstance(child, VerilogParser.Always_constructContext):
                     child.start.text = chr(31) + ' ' * indent + child.start.text + ' '
                     child.stop.text = child.stop.text + chr(31)
                  if isinstance(child, VerilogParser.Event_expressionContext):
                     for i, item in enumerate(child.getChildren()):
                        if i == 0:
                           if isinstance(item, antlr4.tree.Tree.TerminalNodeImpl):
                              item.symbol.text = ' ' + item.symbol.text 
                           else:
                              item.start.text = ' ' + item.start.text
                        else:
                           if isinstance(item, antlr4.tree.Tree.TerminalNodeImpl):
                              item.symbol.text = ' ' + item.symbol.text 
                           else:
                              item.start.text = ' ' + item.start.text
                  # Case block
                  if isinstance(child, VerilogParser.Case_statementContext):
                     child.start.text = chr(31) + ' ' * indent + child.start.text + ' '
                     child.stop.text = chr(31) + ' ' * indent + child.stop.text + ' '

                  if isinstance(child, VerilogParser.Case_itemContext):
                     child.start.text = chr(31) + ' ' * indent + child.start.text + ' '

                  # If block
                  if isinstance(child, VerilogParser.Conditional_statementContext):
                     child.start.text = chr(31) + ' ' * indent + child.start.text + ' '
                  if isinstance(child, antlr4.tree.Tree.TerminalNodeImpl) and child.symbol.text == 'else':
                     child.symbol.text = chr(31) + ' ' * indent + child.symbol.text + ' '

                  # Nonblocking assignment
                  if isinstance(child, VerilogParser.Nonblocking_assignmentContext):
                     child.start.text = chr(31) + ' ' * indent + child.start.text + ' '

                  # Seqblocking assignment
                  if isinstance(child, VerilogParser.Seq_blockContext):
                     child.start.text = chr(31) + ' ' * indent + child.start.text + ' '
                     child.stop.text = chr(31) + ' ' * indent + child.stop.text + ' '

                  # Blocking assignment
                  if isinstance(child, VerilogParser.Blocking_assignmentContext):
                     child.start.text = chr(31) + ' ' * indent + child.start.text + ' '
                  if isinstance(child, VerilogParser.Block_item_declarationContext):
                     for i, item in enumerate(child.getChildren()):
                        if i == 0:
                           if isinstance(item, antlr4.tree.Tree.TerminalNodeImpl):
                              item.symbol.text = chr(31) + ' ' * indent + item.symbol.text 
                           else:
                              item.start.text = chr(31) + ' ' * indent + item.start.text
                        else:
                           if isinstance(item, antlr4.tree.Tree.TerminalNodeImpl):
                              item.symbol.text = ' ' + item.symbol.text 
                           else:
                              item.start.text = ' ' + item.start.text
                  if isinstance(child, VerilogParser.List_of_param_assignmentsContext):
                     child.start.text = ' '  + child.start.text + ' '
                  # Instance block
                  if isinstance(child, VerilogParser.Module_instantiationContext):
                     child.start.text = chr(31) + ' ' * indent + child.start.text + ' '
                  # Module declaration
                  if isinstance(child, VerilogParser.Module_declarationContext):
                     child.start.text = chr(31) + ' ' * indent + child.start.text 
                  if child.getText()=='?':
                     child.symbol.text = ' '+ child.symbol.text + ' '
         

                  self._traverse_children(child,indent+1)

         def visitModule_declaration(self, ctx: VerilogParser.Module_declarationContext):
            self.module_node = ctx
            self.formatProcess(self.module_node)

      visitor = FormatVisitor()
      visitor.visit(module)
      module_design = visitor.text
      with open(outputpath, 'a+') as f:
         f.write(module_design)
         f.write('\n')

   # 1. Visit all module
   class visitModule(VerilogParserVisitor):
      def __init__(self):
         self.module = None
      def visitModule_declaration(self, ctx: VerilogParser.Module_declarationContext):
         self.module = ctx
         print(self.module.module_identifier().getText())
         formatter_design(self.module)


   # 1. Visit all module
   _design = Design2Tree(design)
   visitor = visitModule()
   visitor.visit(_design)


      