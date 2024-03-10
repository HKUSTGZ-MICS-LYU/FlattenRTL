from antlr4_verilog import InputStream, CommonTokenStream, ParseTreeWalker
from antlr4_verilog.verilog import VerilogLexer, VerilogParser, VerilogParserListener, VerilogParserVisitor
import antlr4
from io import StringIO
import os
import re
import copy

res_index = 0

def pyflattenverilog(design:str, top_module:str, output_file:str, debug_mode:bool):
  global res_index

  # output file handler
  output_file = output_file.split('.')[0] + '_' + str(res_index)+'.v'
  if debug_mode:
    res_index += 1
  print("[Processing] %s"%(output_file))
  of_handler = open(output_file,'w')

  def Parameter2Tree(Design):
    lexer = VerilogLexer(InputStream(Design))
    stream = CommonTokenStream(lexer)
    parser = VerilogParser(stream)
    tree = parser.module_parameter_port_list()
    return tree

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
      self.module_param = []
      self.name_of_module_instances = []
      self.list_of_ports_rhs = []
      self.list_of_ports_rhs_width = []
      self.dict_of_parameters = {}

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

          if ctx.parameter_value_assignment() is not None:
            list_of_parameter_assignments = ctx.parameter_value_assignment().list_of_parameter_assignments()

            for child in list_of_parameter_assignments.getChildren():
              if isinstance(child, antlr4.tree.Tree.TerminalNodeImpl):
                pass
              else:
                if self.dict_of_parameters.get(self.name_of_module_instances[-1]) is None:
                   self.dict_of_parameters[self.name_of_module_instances[-1]] = {}
                self.dict_of_parameters[self.name_of_module_instances[-1]][self.name_of_module_instances[-1]+'_'+child.parameter_identifier().getText()] = child.mintypmax_expression().getText()
              

              
  visitor = MyModuleInstantiationVisitor()
  visitor.visit(top_node_tree)
  cur_module_identifier = visitor.module_identifier
  cur_name_of_module_instances = visitor.name_of_module_instances
  cur_prefixs = cur_name_of_module_instances
  cur_list_of_ports_rhs = visitor.list_of_ports_rhs
  cur_dict_of_parameters = visitor.dict_of_parameters

  

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


  # 5. TODO: Get the start and stop index of the instance module
  class InstModuleVisitor(VerilogParserVisitor):
    def __init__(self):
        super().__init__()
        self.inst_module_node = None
        self.inst_module_design = None
        self.start = None
        self.stop = None
        self.indent = 2
        
        self.parameter_start = None
        self.parameter_stop = None
        self.ports_param_str = None

        

    class myParamVisitor(VerilogParserVisitor):
       def __init__(self):
          pass
       # assign to cur_dict_of_parameters
       def visitParam_assignment(self, ctx: VerilogParser.Param_assignmentContext):
          if ctx.getChildCount() == 3:
            param_name = ctx.getChild(0).getText().replace(" ","")
            param_value = ctx.getChild(2).getText().replace(" ","")
            for item in cur_prefixs:
              if cur_dict_of_parameters.get(item) is None:
                cur_dict_of_parameters[item] = {}
              if cur_dict_of_parameters[item].get(item+'_'+param_name) is None:
                cur_dict_of_parameters[item][item+'_'+param_name] = param_value

    class myMoudleParameterPortVisitor(VerilogParserVisitor):
       def __init__(self):
          self.start = None
          self.stop = None
          self.ports_parameter = None

       def _modify_port_parameter(self,ctx: VerilogParser.Module_parameter_port_listContext):
          ports_parameter = design[self.start:self.stop+1]
          for item in cur_prefixs:
            if cur_dict_of_parameters.get(item) is None:
              continue
            else:
              # find index of the last ")" of str ports_parameter
              index = ports_parameter.rfind(')')
              index = index - len(ports_parameter)
              for key in cur_dict_of_parameters[item]:
                ports_parameter = ports_parameter[:index]+",\nparameter "+key+"="+cur_dict_of_parameters[item][key]+ports_parameter[index:]
          # remove the final ","
          self.ports_parameter = ports_parameter

       def visitModule_parameter_port_list(self, ctx: VerilogParser.Module_parameter_port_listContext):
          self.start = ctx.start.start
          self.stop = ctx.stop.stop
          if self.start!=self.stop:
            self._modify_port_parameter(ctx)
            # ctx.parentCtx.children[2] = Parameter2Tree(self.ports_parameter)

        


    def visitModule_declaration(self, ctx: VerilogParser.Module_declarationContext):
        module_name = ctx.module_identifier().getText()
        if module_name == cur_module_identifier:
          self.start = ctx.start.start
          self.stop = ctx.stop.stop
          self.inst_module_node = ctx  
          myParamVisitor = self.myParamVisitor()
          myParamVisitor.visit(ctx)
        if self.start != None:
          if module_name == top_module:
            myMoudleParameterPortVisitor = self.myMoudleParameterPortVisitor()
            myMoudleParameterPortVisitor.visit(ctx)
            self.ports_param_str = myMoudleParameterPortVisitor.ports_parameter
            self.parameter_start = myMoudleParameterPortVisitor.start
            self.parameter_stop = myMoudleParameterPortVisitor.stop
          

  visitor = InstModuleVisitor()
  # Get the start and stop index and dict of param of the instance module
  visitor.visit(tree)
  inst_module_design = design[visitor.start:visitor.stop+1]
  # Visit the parameter and port list of top module
  if cur_dict_of_parameters != {}:
    visitor.visit(tree)
    # This can be optimized
    design = design[:visitor.parameter_start]+visitor.ports_param_str+design[visitor.parameter_stop+1:]
    tree = Design2Tree(design)
    visitor = MyTopModuleVisitor()
    visitor.visit(tree)
    top_node_tree = visitor.top_module_node

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
        self.is_no_port_parameter = False
        self.port_parameter_flag = False
        
    
    def is_parents_parameter_port_list(self,ctx):
      if ctx is None:
        return False

      if not isinstance(ctx, VerilogParser.Module_parameter_port_listContext):
        return self.is_parents_parameter_port_list(ctx.parentCtx)
      else:
        return True
      
    # remove all text in the context and its children
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

    "This function is used to traverse the tree and change the name of the instance"
    def _traverse_children(self,ctx):  
      if self.is_parents_parameter_port_list(ctx):
        try:
          ctx.start.text = ''
          ctx.stop.text = ''
        except:
          ctx.symbol.text = ''
          pass
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
              elif isinstance(child.parentCtx.parentCtx, VerilogParser.Param_assignmentContext):
                  pass
              else:
                  child.start.text = ' ' + cur_prefixs[self.cur_prefixs_index] + '_' + child.start.text + ' '
          self._traverse_children(child)
    
    # def _traverse_param_assignment(self,ctx):
    #   if isinstance(ctx, antlr4.tree.Tree.TerminalNodeImpl):
    #     pass
    #   else:
    #     for child in ctx.getChildren():
    #       if isinstance(child, VerilogParser.Param_assignmentContext):
    #         if child.getChildCount() == 3:
    #           param_name = child.getChild(0).getText().replace(" ","")
    #           param_value = child.getChild(2).getText().replace(" ","")
    #           # if the self.cur_prefixs_index+'_'+ para_name is in the cur_dict_of_parameters
    #           if cur_dict_of_parameters[cur_prefixs[self.cur_prefixs_index]].get(cur_prefixs[self.cur_prefixs_index]+'_'+param_name) is not None:
    #             self.empty_all_text(child.getChild(2))
    #             child.getChild(2).start.text = cur_dict_of_parameters[cur_prefixs[self.cur_prefixs_index]][cur_prefixs[self.cur_prefixs_index]+'_'+param_name]
    #           child.getChild(0).start.text = ' ' + cur_prefixs[self.cur_prefixs_index] + '_' + param_name + ' '
    #       self._traverse_param_assignment(child)
              
              

    def visitModule_declaration(self, ctx: VerilogParser.Module_declarationContext):
        module_name = ctx.module_identifier().getText()
        if module_name == cur_module_identifier:
          self.start = ctx.start.start
          self.stop = ctx.stop.stop
          self.inst_module_node = ctx        
          self._traverse_children(self.inst_module_node)
          # if self.is_no_port_parameter:
          #   self._traverse_param_assignment(self.inst_module_node)
          # This is used to handle special case that the parameter is not in the port list
          # For example, Adder adder #(.E(1)) 
          # module Adder(input a, input b, output c);
          # parameter E = 0;

  inst_module_design_trees = []
  inst_module_nodes = []
  no_port_parameter = False
  for k in range(0,len(cur_prefixs)):
     tmp_inst_module_design = Design2Tree(inst_module_design)
     visitor = InstModuleVisitor(k)
     visitor.visit(tmp_inst_module_design)
     inst_module_design_trees.append(tmp_inst_module_design)
     inst_module_nodes.append(visitor.inst_module_node)
     no_port_parameter = visitor.is_no_port_parameter


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

            # Get parameter default value from the InstModule
            if isinstance(child, VerilogParser.Param_assignmentContext):
              if child.getChildCount() == 3:
                param_name = child.getChild(0).getText().replace(" ","")
                param_value = child.getChild(2).getText().replace(" ","")
              # Append param_name and param_value to cur_dict_of_parameters
                for i in range(0,len(cur_prefixs)):
                  if cur_dict_of_parameters.get(cur_prefixs[i]) is None:
                    cur_dict_of_parameters[cur_prefixs[i]] = {}
                  if cur_dict_of_parameters[cur_prefixs[i]].get(param_name) is None and param_name.startswith(cur_prefixs[i]):
                    cur_dict_of_parameters[cur_prefixs[i]][param_name] = param_value
                  
            self._traverse_children(child)

    def visitModule_declaration(self, ctx: VerilogParser.Module_declarationContext):
        module_name = ctx.module_identifier().getText()
        if module_name == cur_module_identifier:
          if self.is_first_instantiation_module == False:
            self.is_first_instantiation_module = True
            self.inst_module_node = ctx
            self._traverse_children(self.inst_module_node)

  cur_list_of_ports_lhs = []
  cur_list_of_ports_lhs_width = []
  cur_list_of_ports_width = []
  cur_list_of_ports_direction = []
  cur_list_of_ports_type = []
  cur_list_of_data_type = []

  for i in range(0,len(inst_module_design_trees)):
    visitor = InstModulePortVisitor()
    visitor.visit(inst_module_design_trees[i])
    # append the list of ports to the list
    cur_list_of_ports_lhs = cur_list_of_ports_lhs + visitor.list_of_ports_lhs
    cur_list_of_ports_lhs_width = cur_list_of_ports_lhs_width + visitor.list_of_ports_width
    cur_list_of_ports_width = cur_list_of_ports_width + visitor.list_of_ports_width
    cur_list_of_ports_direction = cur_list_of_ports_direction + visitor.list_of_ports_direction
    cur_list_of_ports_type = cur_list_of_ports_type + visitor.list_of_ports_type
    cur_list_of_data_type = cur_list_of_data_type + visitor.list_of_data_type


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
    # try:
    # do the whole word match and replacement based on cur_dict_of_parameters
    ports_lhs_width = copy.deepcopy(cur_list_of_ports_lhs_width)
    # if cur_dict_of_parameters.get(cur_prefixs[k]) is not None and not no_port_parameter:
    #   for i in range(0,len(ports_lhs_width)):
    #     for key in cur_dict_of_parameters[cur_prefixs[k]]:
    #       pattern = r'\b{}\b'.format(key)
    #       ports_lhs_width[i] = re.sub(pattern,cur_dict_of_parameters[cur_prefixs[k]][key],ports_lhs_width[i])
          # ports_lhs_width[i] = ports_lhs_width[i].replace(key,cur_dict_of_parameters[cur_prefixs[k]][key])
    # cur_list_of_ports_lhs_width = ports_lhs_width
       
    for i in range(0,len_instance_port):
      if cur_list_of_data_type[k*len_instance_port+i] != '':
        cur_new_variable.append(cur_list_of_data_type[k*len_instance_port+i]  + ports_lhs_width[k*len_instance_port+i] + ' '+cur_prefixs[k] + '_' + cur_list_of_ports_lhs[k*len_instance_port+i] + ';')
      elif cur_list_of_ports_type[k*len_instance_port+i] == 'reg':
        cur_new_variable.append('reg '  + ports_lhs_width[k*len_instance_port+i] + ' '+cur_prefixs[k] + '_' + cur_list_of_ports_lhs[k*len_instance_port+i] + ';')
      else:
        cur_new_variable.append('wire '  + ports_lhs_width[k*len_instance_port+i] + ' '+cur_prefixs[k] + '_' + cur_list_of_ports_lhs[k*len_instance_port+i] + ';')
      if cur_list_of_ports_direction[k*len_instance_port+i] == 'input': 
        # if cur_list_of_ports_type[i] == 'reg' :
        #   cur_new_assign.append('always @(*)' + ' ' + cur_prefixs[k] + '_' + cur_list_of_ports_lhs[i] + ' = '+ cur_list_of_ports_rhs[i] + ';')
        # else:
        cur_new_assign.append('assign ' + cur_prefixs[k] + '_' + cur_list_of_ports_lhs[k*len_instance_port+i] + ' = '+ cur_list_of_ports_rhs[k*len_instance_port+i] + ';')
      else:
        # if cur_list_of_ports_type[i] == 'reg' :
        #   cur_new_assign.append('always @(*) ' + ' ' + cur_list_of_ports_rhs[i] + ' = '+ cur_prefixs[k] + '_' + cur_list_of_ports_lhs[i] + ';')
        # else:
          cur_new_assign.append('assign ' +  cur_list_of_ports_rhs[k*len_instance_port+i] + ' = '+ cur_prefixs[k] + '_' + cur_list_of_ports_lhs[k*len_instance_port+i] + ';')


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
            if char == chr(31):
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
             child.start.text = chr(31) + ' ' * indent + child.start.text + ' '
          #Parameter defination
          if isinstance(child, VerilogParser.Parameter_declarationContext):
            child.start.text = chr(31) + ' ' * indent + child.start.text 
          #Reg defination
          if isinstance(child, VerilogParser.Reg_declarationContext):
            child.start.text = chr(31) + ' ' * indent + child.start.text
          #Wire defination
          if isinstance(child, VerilogParser.Net_declarationContext):
            child.start.text = chr(31) + ' ' * indent + child.start.text
          #Integer defination
          if isinstance(child, VerilogParser.Integer_declarationContext):
            child.start.text = chr(31) + ' ' * indent + child.start.text
          # Assign block
          if isinstance(child, VerilogParser.Continuous_assignContext):
            child.start.text = chr(31) + ' ' * indent + child.start.text + ' '
          # Always block
          if isinstance(child, VerilogParser.Always_constructContext):
            child.start.text = chr(31) + ' ' * indent + child.start.text + ' '
            child.stop.text = child.stop.text + chr(31)
          if isinstance(child, VerilogParser.Event_expressionContext):
            child.start.text = ' ' + child.start.text + ' '
          # if isinstance(child, VerilogParser.Event_expressionContext) and child.getText() == 'negedge':
          #   child.symbol.text = ' ' + child.symbol.text + ' '
          # if isinstance(child, VerilogParser.Event_expressionContext) and child.getText() == 'posedge':
          #   child.symbol.text = ' ' + child.symbol.text + ' '
          # Case block
          if isinstance(child, VerilogParser.Case_statementContext):
            child.start.text = chr(31) + ' ' * indent + child.start.text + ' '
            child.stop.text = chr(31) + ' ' * indent + child.stop.text + ' '

          if isinstance(child, VerilogParser.Case_itemContext):
            child.start.text = chr(31) + ' ' * indent + child.start.text + ' '

          # If block
          if isinstance(child, VerilogParser.Conditional_statementContext):
            child.start.text = chr(31) + ' ' * indent + child.start.text + ' '
            # child.stop.text = chr(31) + ' ' * indent + child.stop.text + ' '
          if isinstance(child, antlr4.tree.Tree.TerminalNodeImpl) and (child.symbol.text == 'else'):
            child.symbol.text = chr(31) + ' ' * indent + child.symbol.text + ' '
          elif isinstance(child, antlr4.tree.Tree.TerminalNodeImpl) and (child.symbol.text == 'or'):
             child.symbol.text = ' ' * indent + child.symbol.text + ' '
          # if isinstance(child, VerilogParser.List_of_variable_identifiersContext) \
          #   or isinstance(child, VerilogParser.List_of_net_identifiersContext)\
          #     or isinstance(child, VerilogParser.net_identifiersContext):
          #   child.start.text = ' '+ child.start.text + ' '
          # Simple identifier
          if isinstance(child, VerilogParser.Simple_identifierContext):
            child.start.text = ' ' + child.start.text + ' '
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
          # Instance block
          if isinstance(child, VerilogParser.Module_instantiationContext):
            child.start.text = chr(31) + ' ' * indent + child.start.text + ' '
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