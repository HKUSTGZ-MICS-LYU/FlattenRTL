from antlr4.tree.Tree import TerminalNodeImpl
from antlr4_verilog.verilog import VerilogParser, VerilogParserVisitor

from design_parser import *

class ParameterVisitor(VerilogParserVisitor):
   def __init__(self):
      self.parameter = []
      
   def visitParameter_declaration(self, ctx: VerilogParser.Parameter_declarationContext):
      if isinstance(ctx.parentCtx, VerilogParser.Module_parameter_port_listContext):
         return
      for i in range(0,len(ctx.list_of_param_assignments().param_assignment())):
         param_assign = ctx.list_of_param_assignments().param_assignment()[i]
         self.parameter.append([param_assign.getChild(0).getText(), param_assign.getChild(2).getText()])
      self.__empty_all_text(ctx.parentCtx)
   
   def __empty_all_text(self,ctx):
      if isinstance(ctx, TerminalNodeImpl):
         try:
            ctx.start.text = ''
            ctx.stop.text = ''
         except:
            ctx.symbol.text = ''
            pass
      else:
         for child in ctx.getChildren():
            self.__empty_all_text(child)

"This function is used to get the port list of the module"
class ModuleVisitor(VerilogParserVisitor):
   def __init__(self):
      self.module_port = {}
      self.block_port = {}
      self.block_parameter = []
      self.module = None
      self.non_port_parameter = []

   def visitModule_declaration(self, ctx:VerilogParser.Module_declarationContext):
      # Get the all parameter assignment, we assume the parameter assignment is all port definition or block definition
      parameter_visitor = ParameterVisitor()
      parameter_visitor.visit(ctx)
      self.non_port_parameter = parameter_visitor.parameter
      self.module = ctx
      self.__visit_module_declaration(ctx)
      
   # visit module declaration
   def __visit_module_declaration(self, ctx:VerilogParser.Module_declarationContext):  
      if isinstance(ctx, TerminalNodeImpl):
         return 
      for child in ctx.getChildren():
         if isinstance(child, VerilogParser.List_of_port_declarationsContext):
            self.__visit_port_list(child)
         if isinstance(child, VerilogParser.Module_itemContext):
            self.__visit_port_declaration(child)

   # visit port declaration
   def __visit_port_declaration(self, ctx):
      if isinstance(ctx, TerminalNodeImpl):
         return
      for child in ctx.getChildren():
         if isinstance(child, VerilogParser.Port_declarationContext):
            if isinstance(child.getChild(0), VerilogParser.Input_declarationContext):
               self.__visit_input_declaration(child.getChild(0))

         if isinstance(child.getChild(0), VerilogParser.Output_declarationContext):
            self.__visit_output_declaration(child.getChild(0))
         
         if isinstance(child.getChild(0), VerilogParser.Inout_declarationContext):
            self.__visit_inout_declaration(child.getChild(0))

         if isinstance(child, VerilogParser.Reg_declarationContext):
            self.__visit_reg_declaration(child)

         if isinstance(child, VerilogParser.Integer_declarationContext):
            self.__visit_integer_declaration(child)

         if isinstance(child, VerilogParser.Block_nameContext):
            index_of_child = child.parentCtx.children.index(child)

         if isinstance(child, VerilogParser.Block_item_declarationContext):
            self.__visit_block_declaration(child)

         # Delete duplicate wire
         if isinstance(child, VerilogParser.Net_declarationContext):
            if child.list_of_net_identifiers() is not None:
               for i in range(0,child.list_of_net_identifiers().getChildCount()):
                  is_multiple_identifier = child.list_of_net_identifiers().getChildCount() > 1
                  name = child.list_of_net_identifiers().getChild(i).getText()
                  if self.module_port.get(name) is not None:
                     if not is_multiple_identifier:
                        child.parentCtx.start.text = '//'+child.parentCtx.start.text
                     else:
                        print("[WARNING Multi-wire Definition Module]:",self.module.module_identifier().getText())
                        print("[Problematic Line]:",child.list_of_net_identifiers().getChild(i).start.line)
                        print("[WARNING Possible duplicate wire with port]: ",name)
                        # del child.parentCtx.children[index_of_child]
                        # if index_of_child == 0 and child.list_of_net_identifiers().getChildCount()!=1:
                        #    del child.parentCtx.children[index_of_child+1]
                        # elif index_of_child != 0:
                        #    del child.parentCtx.children[index_of_child-1]
                  
      self.__visit_port_declaration(child)

   # visit integer declaration
   def __visit_integer_declaration(self, ctx: VerilogParser.Integer_declarationContext):
      for name in ctx.list_of_variable_identifiers().getText().split(','):
         if name in self.module_port:
            self.module_port[name]['port_type'] = 'integer'

   # visit reg declaration
   def __visit_reg_declaration(self, ctx: VerilogParser.Reg_declarationContext):
      for name in ctx.list_of_variable_identifiers().getText().split(','):
         if name in self.module_port:
            self.module_port[name]['port_type'] = 'reg'
   
   # visit input declaration
   def __visit_input_declaration(self, ctx: VerilogParser.Input_declarationContext):
      for name in ctx.list_of_port_identifiers().getText().split(','):
         if name in self.module_port:
            self.module_port[name]['port_direction'] = 'input'
         if ctx.range_() != None:
            self.module_port[name]['port_width'] = ctx.range_().getText()
         if ctx.SIGNED() != None:
            self.module_port[name]['data_type'] = ctx.SIGNED().getText()
      
   # visit output declaration
   def __visit_output_declaration(self, ctx: VerilogParser.Output_declarationContext):
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
   def __visit_inout_declaration(self, ctx: VerilogParser.Inout_declarationContext):
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
   def __visit_port_list(self,ctx):
      if isinstance(ctx, TerminalNodeImpl):
         return
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
         self.__visit_port_list(child)

   # visit block declaration
   def __visit_block_declaration(self, ctx: VerilogParser.Block_item_declarationContext):
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


class ModuleItemModifier(VerilogParserVisitor):
   def __init__(self):
      pass
   
   def __modify_net_declaration(self, ctx:VerilogParser.Net_declarationContext):
      before_identifier = ""
      if ctx.list_of_net_identifiers() is None:
         return
      if ctx.list_of_net_identifiers().getChildCount()!=1:
         for i in range(0,ctx.getChildCount()-2):
            before_identifier += ctx.getChild(i).getText() + ' '
         new_net_declaration = []
         for i in range(0,ctx.list_of_net_identifiers().getChildCount()):
            if isinstance(ctx.list_of_net_identifiers().getChild(i),VerilogParser.Net_idContext):
               new_net_declaration.append(before_identifier + ctx.list_of_net_identifiers().getChild(i).getText() + ';')

         index_of_child = ctx.parentCtx.children.index(ctx)
         del ctx.parentCtx.children[index_of_child]

         for i in range(0,len(new_net_declaration)):
            ctx.parentCtx.children.insert(index_of_child + i, parse_net_declare_to_tree(new_net_declaration[i]))


   def __modify_reg_declaration(self, ctx:VerilogParser.Reg_declarationContext):
      before_identifier = ""
      if ctx.list_of_variable_identifiers().getChildCount()==1:
         return 
      for i in range(0,ctx.getChildCount()-2):
         before_identifier += ctx.getChild(i).getText() + ' '
      new_reg_declaration = []
      for i in range(0,ctx.list_of_variable_identifiers().getChildCount()):
         if isinstance(ctx.list_of_variable_identifiers().getChild(i),VerilogParser.Variable_typeContext):
            new_reg_declaration.append(before_identifier + ctx.list_of_variable_identifiers().getChild(i).getText() + ';')

      index_of_child = ctx.parentCtx.children.index(ctx)
      del ctx.parentCtx.children[index_of_child]

      for i in range(0,len(new_reg_declaration)):
         ctx.parentCtx.children.insert(index_of_child + i, parse_reg_declare_to_tree(new_reg_declaration[i]))

   def __modify_module_instantiation(self, ctx:VerilogParser.Module_instantiationContext):
      before_identifier = ""
      if len(ctx.module_instance())<=1:
         return
      for i in range(0,ctx.getChildCount()-1):
         if isinstance(ctx.getChild(i), VerilogParser.Module_instanceContext):
            break
         before_identifier += ctx.getChild(i).getText() + ' '
      new_module_instantiation = []
      for item in ctx.module_instance():
         new_module_instantiation.append(before_identifier+design[item.start.start:item.stop.stop+1] + ';')

      index_of_child = ctx.parentCtx.children.index(ctx)
      del ctx.parentCtx.children[index_of_child]

      for i in range(0,len(new_module_instantiation)):
         ctx.parentCtx.children.insert(index_of_child + i, parse_mod_ins_to_tree(new_module_instantiation[i]))

   def __traverse_children(self,ctx):
      if isinstance(ctx, TerminalNodeImpl):
         return
      for child in ctx.getChildren():
         if isinstance(child, VerilogParser.Net_declarationContext):
            self.__modify_net_declaration(child)
         elif isinstance(child, VerilogParser.Reg_declarationContext):
            self.__modify_reg_declaration(child)
         elif isinstance(child, VerilogParser.Module_instantiationContext):
            self.__modify_module_instantiation(child)

         self.__traverse_children(child)

   def visitModule_item(self, ctx: VerilogParser.Module_itemContext):
      self.__traverse_children(ctx)

"This function is used to remove the port and define the port in the list"
class PortModifyVisitor(VerilogParserVisitor):
   def __init__(self, non_port_parameter, module_port, remove_port_list, block_port, block_parameter):
      self.module = None
      self.non_port_parameter = non_port_parameter
      self.module_port = module_port
      self.remove_port_list = remove_port_list
      self.block_port = block_port
      self.block_parameter = block_parameter
   
   def is_implicit_port_definition(self, ctx:VerilogParser.Module_declarationContext):
      return ctx.list_of_port_declarations().port_declaration() == []
   
   def __insert_parameter(self, ctx:VerilogParser.Module_declarationContext):
      parameter = '#(\n'
      if self.non_port_parameter != []:
         for i , item in enumerate(self.non_port_parameter):
            parameter += "parameter  "+item[0] + '=' + item[1]
            if i == len(self.non_port_parameter) - 1:
               parameter += '\n'
            else:
               parameter += ',\n'
         parameter += '\n);\n'
         ctx.children.insert(2, parse_parameter_to_tree(parameter))
   def modifyModule_declaration(self, ctx:VerilogParser.Module_declarationContext):
      self.__insert_parameter(ctx)
      self.__modify_module_declaration(ctx)
      self.__remove_signal_declaration(ctx)
      # self._add_block_content(ctx)
      self.__remove_block_content(ctx)
      # if self.is_implicit_port_definition(ctx):
      self.module = ctx
   
   def __modify_module_declaration(self,ctx:VerilogParser.Module_declarationContext):  
      if isinstance(ctx, TerminalNodeImpl):
         pass
      else:
         for child in ctx.getChildren():
            if isinstance(child, VerilogParser.List_of_port_declarationsContext):
               new_child = self.__modify_port_list(child)
               index_of_child = child.parentCtx.children.index(child)
               child.parentCtx.children[index_of_child] = new_child

   def __modify_port_list(self, ctx):
      port_defination = '('
      for index, (key, value) in enumerate(self.module_port.items()):
         if index == len(self.module_port) - 1:
            if value['port_type'] == 'wire':
               port_defination += '\n' + value['port_direction']  + ' ' + value['data_type'] + ' ' + value['port_width'] + ' ' + key + ');' + '\n'
            else:
               port_defination += '\n' + value['port_direction'] + ' ' + value['port_type'] + ' ' + value['data_type'] + ' ' + value['port_width'] + ' ' + key + ');' + '\n'
         else:
            if value['port_type'] == 'wire':
               port_defination += '\n' + value['port_direction']  + ' ' + value['data_type'] + ' ' + value['port_width'] + ' ' + key + ','
            else:
               port_defination += '\n' + value['port_direction'] + ' ' + value['port_type'] + ' ' + value['data_type'] + ' ' + value['port_width'] + ' ' + key + ','
         
      ctx = parse_port_to_tree(port_defination)
      return ctx
   
   def __remove_signal_declaration(self, ctx):
      if isinstance(ctx, TerminalNodeImpl):
         pass
      else:
         for child in list(ctx.children):
            sig_name = None
            find_sig = False
            if isinstance(child, VerilogParser.Module_itemContext):
               index_of_child = child.parentCtx.children.index(child)
               find_sig = self.__find_port_declaration(child)
               if find_sig:
                     sig_name = self.__get_simple_identifier(child)
               if sig_name in self.remove_port_list:
                     del child.parentCtx.children[index_of_child]
               

   def __find_port_declaration(self, ctx):
      result = False
      if isinstance(ctx, TerminalNodeImpl):
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
                  result = self.__find_port_declaration(child)
               if result:
                  break
      return result

   def __get_simple_identifier(self, ctx: VerilogParser.Module_itemContext):
      sig_name = None
      if isinstance(ctx, TerminalNodeImpl):
         pass
      else:
         for child in ctx.getChildren():
               if isinstance(child, VerilogParser.Simple_identifierContext):
                  sig_name = child.getText()
               elif isinstance(child, VerilogParser.Range_Context):
                  pass
               else:
                  sig_name = self.__get_simple_identifier(child)
               if sig_name is not None:
                  break
      return sig_name
   
   def __add_block_content(self, ctx):
      for child in ctx.getChildren():
         if isinstance(child, TerminalNodeImpl) and child.symbol.text == ';':
            index = ctx.children.index(child)
            # for i , item in enumerate(block_parameter):
            #    parameter = item
            #    ctx.children.insert(index + i + 1, Parameter2Tree(parameter))
            for key, value in self.block_port.items():
               defination = value['port_type'] + ' ' + value['data_type'] + ' ' + value['port_width'] + ' ' + key + ';'
               ctx.children.insert(index + len(self.block_parameter) + 1, parse_module_to_tree(defination))

   def __remove_block_content(self, ctx):
      if isinstance(ctx, TerminalNodeImpl):
         pass
      else:
         if ctx.children is not None:
            for child in list(ctx.children):
               if isinstance(child, VerilogParser.Block_item_declarationContext):
                  index_of_child = child.parentCtx.children.index(child)
                  del child.parentCtx.children[index_of_child]
               else:
                  self.__remove_block_content(child)

class FormatVisitor(VerilogParserVisitor):
   def __init__(self):
      super().__init__()
      self.module_node = None
      self.module_design = None
      self.text = ""

   def formatProcess(self,ctx):
      self.__traverse_children(ctx)
      # if ctx.getChildCount() == 0:
      #    return ""
      for child in ctx.getChildren():  
         self.text += child.getText()+' '
      self.text = self.text.replace(chr(31), '\n')
            
   def __traverse_children(self,ctx,indent = 0):  
      if isinstance(ctx, VerilogParser.Module_declarationContext):
         ctx.stop.text = chr(31) + ctx.stop.text + chr(31)
      if isinstance(ctx, TerminalNodeImpl):
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
                     if isinstance(item, TerminalNodeImpl):
                        item.symbol.text = ' ' + item.symbol.text + ' '
                     else:
                        item.start.text = ' ' + item.start.text

            
            #Reg defination
            if isinstance(child, VerilogParser.Reg_declarationContext):
               for i, item in enumerate(child.getChildren()):
                  if i == 0:
                     if isinstance(item, TerminalNodeImpl):
                        item.symbol.text = chr(31) + ' ' * indent + item.symbol.text
                     else: 
                        item.start.text = chr(31) + ' ' * indent + item.start.text
                  else:
                     if isinstance(item, TerminalNodeImpl):
                        item.symbol.text = ' ' + item.symbol.text + ' '
                     else:
                        item.start.text = ' ' + item.start.text

            #Wire defination
            if isinstance(child, VerilogParser.Net_declarationContext):
               for i, item in enumerate(child.getChildren()):
                  if i == 0:
                     if isinstance(item, TerminalNodeImpl):
                        item.symbol.text = chr(31) + ' ' * indent + item.symbol.text
                     else: 
                        item.start.text = chr(31) + ' ' * indent + item.start.text
                  else:
                     if isinstance(item, TerminalNodeImpl):
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
                     if isinstance(item, TerminalNodeImpl):
                        item.symbol.text = chr(31) + ' ' * indent + item.symbol.text
                     else: 
                        item.start.text = chr(31) + ' ' * indent + item.start.text
                  else:
                     if isinstance(item, TerminalNodeImpl):
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
                     if isinstance(item, TerminalNodeImpl):
                        item.symbol.text = ' ' + item.symbol.text 
                     else:
                        item.start.text = ' ' + item.start.text
                  else:
                     if isinstance(item, TerminalNodeImpl):
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
            if isinstance(child, TerminalNodeImpl) and child.symbol.text == 'else':
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
                     if isinstance(item, TerminalNodeImpl):
                        item.symbol.text = chr(31) + ' ' * indent + item.symbol.text 
                     else:
                        item.start.text = chr(31) + ' ' * indent + item.start.text
                  else:
                     if isinstance(item, TerminalNodeImpl):
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
   

            self.__traverse_children(child,indent+1)

   def visitModule_declaration(self, ctx: VerilogParser.Module_declarationContext):
      self.module_node = ctx
      self.formatProcess(self.module_node)



class DesignVisitor(VerilogParserVisitor):
   def __init__(self):
      self.module = None
      self.output = ''

   def __format_design(self, tree):  
      # 1. Module Declaration Visitor
      visitor = ModuleVisitor()
      visitor.visitModule_declaration(tree)
      module_port = visitor.module_port
      remove_port_list = module_port.copy()
      block_parameter = visitor.block_parameter
      block_port = visitor.block_port
      non_port_parameter = visitor.non_port_parameter
         
      # 2. Visitor for module item
      visitor = ModuleItemModifier()
      visitor.visitModule_item(tree)

      # 3. Port Modify Visitor
      visitor = PortModifyVisitor(non_port_parameter, module_port, remove_port_list, block_port, block_parameter)
      visitor.modifyModule_declaration(tree)
      module = visitor.module

      # 4. Format Visitor
      visitor = FormatVisitor()
      visitor.visit(module)
      module_design = visitor.text
      self.output += module_design + '\n'

   def visitModule_declaration(self, ctx: VerilogParser.Module_declarationContext):
      self.module = ctx
      print('[INFO] Formatting the module {}'.format(self.module.module_identifier().getText()))
      self.__format_design(self.module)

def format_file(design):
   design = parse_design_to_tree(design)
   visitor = DesignVisitor()
   visitor.visit(design)
   return visitor.output


      