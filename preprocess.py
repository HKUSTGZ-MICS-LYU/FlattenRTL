from antlr4_verilog import InputStream, CommonTokenStream, ParseTreeWalker
from antlr4_verilog.verilog import VerilogLexer, VerilogParser, VerilogParserListener, VerilogParserVisitor
import antlr4
from io import StringIO
import os


"This function is used to convert the verilog to a tree"
def Design2Tree(Design):
   lexer = VerilogLexer(InputStream(Design))
   stream = CommonTokenStream(lexer)
   parser = VerilogParser(stream)
   tree = parser.source_text()
   return tree

def Port2Tree(Design):
   lexer = VerilogLexer(InputStream(Design))
   stream = CommonTokenStream(lexer)
   parser = VerilogParser(stream)
   tree = parser.list_of_port_declarations()
   return tree

def Paramter2Tree(Design):
   lexer = VerilogLexer(InputStream(Design))
   stream = CommonTokenStream(lexer)
   parser = VerilogParser(stream)
   tree = parser.module_item()
   return tree

def Module2Tree(Design):
   lexer = VerilogLexer(InputStream(Design))
   stream = CommonTokenStream(lexer)
   parser = VerilogParser(stream)
   tree = parser.module_item()
   return tree


def formatter_file(design, outputpath):
   def formatter_design(tree):  

      "This function is used to get the port list of the module"
      class MyModuleVisitor(VerilogParserVisitor):
         def __init__(self):
            self.module_port = {}
            self.block_port = {}
            self.block_parameter = []
            self.module = None

         def visitModule_declaration(self, ctx:VerilogParser.Module_declarationContext):
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
                  # print(type(child))  # Debugging: Print out the type of each child
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
                     # del child.parentCtx.children[index_of_child]

                  if isinstance(child, VerilogParser.Block_item_declarationContext):
                     self._visit_block_declaration(child)
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

         # visit port list
         def _visit_port_list(self,ctx):
            if isinstance(ctx, antlr4.tree.Tree.TerminalNodeImpl):
               pass
            else:
               for child in ctx.getChildren():
                  if isinstance(child, VerilogParser.Simple_identifierContext):
                     port_name = child.getText()
                     self.module_port[port_name] = {'data_type': '','port_type':'wire','port_width':'','port_direction':''}
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


      visitor = MyModuleVisitor()
      visitor.visitModule_declaration(tree)
      module_port = visitor.module_port
      remove_port_list = module_port.copy()
      block_parameter = visitor.block_parameter
      block_port = visitor.block_port

      "This function is used to remove the port and define the port in the list"
      class PortModifyVisitor(VerilogParserVisitor):
         def __init__(self):
            self.module = None
         

         def modifyModule_declaration(self, ctx:VerilogParser.Module_declarationContext):
            self._modify_module_declaration(ctx)
            self._remove_signal_declaration(ctx)
            self._add_block_content(ctx)
            self._remove_block_content(ctx)
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
                     paramter = item
                     ctx.children.insert(index + i + 1, Paramter2Tree(paramter))
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
                  if char == '#':
                     self.text += '\n'
                  else:
                     self.text += char
                  
         def _traverse_children(self,ctx,indent = 0):  
            if isinstance(ctx, VerilogParser.Module_declarationContext):
               ctx.stop.text = '#' + ctx.stop.text + '#'
            if isinstance(ctx, antlr4.tree.Tree.TerminalNodeImpl):
               pass
            else:
               for child in ctx.getChildren():
               # Adjust the indent
               # Port defination
                  if isinstance(child, VerilogParser.Input_declarationContext) or isinstance(child, VerilogParser.Output_declarationContext) or isinstance(child, VerilogParser.Inout_declarationContext):
                     for i, item in enumerate(child.getChildren()):
                        if i == 0:
                           item.symbol.text = '#' + ' ' * indent + item.symbol.text
                        else:
                           if isinstance(item, antlr4.tree.Tree.TerminalNodeImpl):
                              item.symbol.text = ' ' + item.symbol.text + ' '
                           else:
                              item.start.text = ' ' + item.start.text

                  #Parameter defination
                  if isinstance(child, VerilogParser.Parameter_declarationContext):
                     child.start.text = '#' + ' ' * indent + child.start.text 
                  #Reg defination
                  if isinstance(child, VerilogParser.Reg_declarationContext):
                     for i, item in enumerate(child.getChildren()):
                        if i == 0:
                           if isinstance(item, antlr4.tree.Tree.TerminalNodeImpl):
                              item.symbol.text = '#' + ' ' * indent + item.symbol.text
                           else: 
                              item.start.text = '#' + ' ' * indent + item.start.text
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
                              item.symbol.text = '#' + ' ' * indent + item.symbol.text
                           else: 
                              item.start.text = '#' + ' ' * indent + item.start.text
                        else:
                           if isinstance(item, antlr4.tree.Tree.TerminalNodeImpl):
                              item.symbol.text = ' ' + item.symbol.text + ' '
                           else:
                              item.start.text = ' ' + item.start.text
                     
                  #Integer defination
                  if isinstance(child, VerilogParser.Integer_declarationContext):
                     for i, item in enumerate(child.getChildren()):
                        if i == 0:
                           if isinstance(item, antlr4.tree.Tree.TerminalNodeImpl):
                              item.symbol.text = '#' + ' ' * indent + item.symbol.text
                           else: 
                              item.start.text = '#' + ' ' * indent + item.start.text
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
                     child.start.text = '#' + ' ' * indent + child.start.text + ' '
                  # Always block
                  if isinstance(child, VerilogParser.Always_constructContext):
                     child.start.text = '#' + ' ' * indent + child.start.text + ' '
                     child.stop.text = child.stop.text + '#'
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
                     child.start.text = '#' + ' ' * indent + child.start.text + ' '
                     child.stop.text = '#' + ' ' * indent + child.stop.text + ' '

                  if isinstance(child, VerilogParser.Case_itemContext):
                     child.start.text = '#' + ' ' * indent + child.start.text + ' '

                  # If block
                  if isinstance(child, VerilogParser.Conditional_statementContext):
                     child.start.text = '#' + ' ' * indent + child.start.text + ' '
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
                  if isinstance(child, VerilogParser.Block_item_declarationContext):
                     for i, item in enumerate(child.getChildren()):
                        if i == 0:
                           if isinstance(item, antlr4.tree.Tree.TerminalNodeImpl):
                              item.symbol.text = '#' + ' ' * indent + item.symbol.text 
                           else:
                              item.start.text = '#' + ' ' * indent + item.start.text
                        else:
                           if isinstance(item, antlr4.tree.Tree.TerminalNodeImpl):
                              item.symbol.text = ' ' + item.symbol.text 
                           else:
                              item.start.text = ' ' + item.start.text
                  if isinstance(child, VerilogParser.List_of_param_assignmentsContext):
                     child.start.text = ' '  + child.start.text + ' '
                  # Instance block
                  if isinstance(child, VerilogParser.Module_instantiationContext):
                     child.start.text = '#' + ' ' * indent + child.start.text + ' '
                  # Module declaration
                  if isinstance(child, VerilogParser.Module_declarationContext):
                     child.start.text = '#' + ' ' * indent + child.start.text 
         

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

   class visitModule(VerilogParserVisitor):
      def __init__(self):
         self.module = None
      def visitModule_declaration(self, ctx: VerilogParser.Module_declarationContext):
         self.module = ctx
         print(self.module.module_identifier().getText())
         formatter_design(self.module)

   design = Design2Tree(design)
   visitor = visitModule()
   visitor.visit(design)


      