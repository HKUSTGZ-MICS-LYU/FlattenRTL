import re, copy

from antlr4.tree.Tree import TerminalNodeImpl
from antlr4_systemverilog.systemverilog import SystemVerilogParser, SystemVerilogParserVisitor

from design_parser import parse_design_to_tree, extract_module, replace_module

class TopModuleNodeFinder(SystemVerilogParserVisitor):
    def __init__(self, top_module):
        self.top_module_node= None
        self.top_module = top_module   
        
    def visitModule_declaration(self, ctx: SystemVerilogParser.Module_declarationContext):
        module_name = ctx.module_header().module_identifier().getText()
        if module_name == self.top_module:
            self.top_module_node = ctx
            
class MyModuleInstantiationVisitor(SystemVerilogParserVisitor):
    def __init__(self, exclude_module):
        self.is_first_instantiation_module = False
        self.module_identifier = ""
        self.module_param = []
        self.name_of_module_instances = []
        self.list_of_ports_rhs = []
        self.dict_of_lhs_to_rhs = {}
        self.list_of_ports_rhs_width = []
        self.dict_of_parameters = {}
        
        self.exclude_module = exclude_module

    def visitModule_program_interface_instantiation(
        self, ctx : SystemVerilogParser.Module_program_interface_instantiationContext
    ):
        if (
            ctx.instance_identifier().getText() not in self.exclude_module 
            and self.is_first_instantiation_module == False
            or self.module_identifier == ctx.instance_identifier().getText()
            
        ):
            self.is_first_instantiation_module = True
            self.first_instantiation = ctx
            self.module_identifier = ctx.instance_identifier().getText()
            for i in range(0,len(ctx.hierarchical_instance())):
                self.name_of_module_instances.append(
                    ctx.hierarchical_instance()[i].name_of_instance().getText()
                )
                # get ports_connnections
                ports_connections = ctx.hierarchical_instance()[i].list_of_port_connections()
            
                for child in ports_connections.getChildren():
                    if child in ports_connections.getChildren():
                        if isinstance(child, TerminalNodeImpl):
                            pass
                        else:
                            if hasattr(child,"port_assign") and child.port_assign().expression() is not None:
                                self.list_of_ports_rhs.append(child.port_assign().expression().getText())
                            elif isinstance(child,SystemVerilogParser.Ordered_port_connectionContext):
                                self.list_of_ports_rhs.append(child.getText())
                            else:
                                self.list_of_ports_rhs.append("")
                            if isinstance(child, SystemVerilogParser.Ordered_port_connectionContext):
                                if (self.dict_of_lhs_to_rhs.get(self.name_of_module_instances[-1]) is None):
                                    self.dict_of_lhs_to_rhs[self.name_of_module_instances[-1]] = []
                                self.dict_of_lhs_to_rhs[self.name_of_module_instances[-1]].append(child.getText())
                                
                            elif (isinstance(child, SystemVerilogParser.Named_port_connectionContext) is not None):
                                if (self.dict_of_lhs_to_rhs.get(self.name_of_module_instances[-1])is None):
                                    self.dict_of_lhs_to_rhs[self.name_of_module_instances[-1]] = {}
                                if child.port_assign() is not None:
                                    if child.port_assign().expression() is not None:
                                        self.dict_of_lhs_to_rhs[self.name_of_module_instances[-1]][child.port_identifier().getText()] = child.port_assign().expression().getText()
                                        self.dict_of_lhs_to_rhs[self.name_of_module_instances[-1]][child.port_identifier().getText()] = \
                                            self.dict_of_lhs_to_rhs[self.name_of_module_instances[-1]][child.port_identifier().getText()].replace("?", " ? ")
                                    else:
                                        self.dict_of_lhs_to_rhs[self.name_of_module_instances[-1]][child.port_identifier().getText()] = ""
                                else:
                                    self.dict_of_lhs_to_rhs[self.name_of_module_instances[-1]][child.port_identifier().getText()] = ""
                            if ctx.parameter_value_assignment() is not None:
                                list_of_parameter_assignments = ctx.parameter_value_assignment().list_of_parameter_assignments()
                                for child in list_of_parameter_assignments.getChildren():
                                    if isinstance(child, TerminalNodeImpl):
                                        pass
                                    else:
                                        if isinstance(child, SystemVerilogParser.Named_parameter_assignmentContext):
                                            if (self.dict_of_parameters.get(self.name_of_module_instances[-1]) is None):
                                                self.dict_of_parameters[self.name_of_module_instances[-1]] = {}
                                            self.dict_of_parameters[self.name_of_module_instances[-1]][
                                                self.name_of_module_instances[-1]
                                                + "__"
                                                + child.parameter_identifier().getText()
                                            ] = child.param_expression().getText()
                                        elif isinstance(child, SystemVerilogParser.Ordered_parameter_assignmentContext):
                                            if (self.dict_of_parameters.get(self.name_of_module_instances[-1])is None):
                                                self.dict_of_parameters[self.name_of_module_instances[-1]] = {}
                                            self.dict_of_parameters[self.name_of_module_instances[-1]][
                                                int(list_of_parameter_assignments.children.index(child)/2)
                                            ] = child.getText()

class ParamVisitor(SystemVerilogParserVisitor):
    def __init__(self, cur_dict_of_parameters, cur_prefixs):
        self.counter = 0
        self.cur_prefixs = cur_prefixs
        self.cur_dict_of_parameters = cur_dict_of_parameters
    
    def is_parents_parameter_port_list(self,ctx):
        if ctx is None:
            return False
        if not isinstance(ctx,SystemVerilogParser.Parameter_port_listContext):
            return self.is_parents_parameter_port_list(ctx.parentCtx)
        else:
            return True

    # A very special case:
    # "Parameter A = 3"
    # "Parameter B = A;"
    # After flatten, it should be
    # Parameter B = [cur_prefix]_A;
    # Can even handle complicated case like:
    # Parameter C = A + B;
    def find_and_repalce_param_in_param_value(self,  param_value, prefix, cur_dict_of_parameter):
        item = cur_dict_of_parameter[prefix]
        for _key in item.keys():
            if isinstance(_key,int):
                continue 
            tmp_item = _key[len(prefix) + 1 :]
            # Find whole word 'item' in param_value
            pattern = r"\b{}\b".format(tmp_item)
            if re.search(pattern, param_value):
                if prefix + '_' + tmp_item in item:
                    param_value = re.sub(pattern, _key, param_value)
        return param_value

    # assign to cur_dict_of_parameters
    def visitParam_assignment(self, ctx: SystemVerilogParser.Param_assignmentContext):
        # Whether current parameter assignment is under module header, if not, we should not collect it
        # module xxx();
        # parameter xxx; <- would not affect the header
        if not self.is_parents_parameter_port_list(ctx):
            return 
        if ctx.getChildCount() == 3:
            param_name = ctx.getChild(0).getText().replace(" ", "")
            param_value = ctx.getChild(2).getText().replace(" ", "")
            
            for item in self.cur_prefixs:
                if self.cur_dict_of_parameters.get(item) is None:
                    self.cur_dict_of_parameters[item] = {}
                if (self.cur_dict_of_parameters[item].get(item + "__" + param_name)is None):
                    # Handle the ordered parameter
                    if (self.cur_dict_of_parameters[item].get(self.counter)is not None):
                        self.cur_dict_of_parameters[item][item + "__" + param_name] = self.cur_dict_of_parameters[item].get(self.counter)
                    else:
                        param_value = self.find_and_repalce_param_in_param_value(
                            param_value, item, self.cur_dict_of_parameters
                        )
                        self.cur_dict_of_parameters[item][item + "__" + param_name] = param_value
            self.counter += 1
            
class OrderedModulePortVisitor(SystemVerilogParserVisitor):
    def __init__(self, dict_of_lhs_to_rhs, instance_name, cur_lhs):
        self.instance_name = instance_name
        self.dict_of_lhs_to_rhs = dict_of_lhs_to_rhs
        self.port_var_list = dict_of_lhs_to_rhs[instance_name]
        self.dict_of_lhs_to_rhs[self.instance_name] = {}
        self.index = 0
        self.cur_lhs = cur_lhs

    def visitList_of_port_declarations(self, ctx:SystemVerilogParser.List_of_port_declarationsContext):
        for item in ctx.port_decl():
            self.dict_of_lhs_to_rhs[self.instance_name][item.ansi_port_declaration().port_identifier().getText()] = self.port_var_list[self.index]
            self.cur_lhs.append(item.ansi_port_declaration().port_identifier().getText())
            self.index += 1

    # def visitPort_declaration(self, ctx:SystemVerilogParser.Port_declarationContext):
    #     if ctx.input_declaration() is not None:
    #         for i in range(0, len(ctx.input_declaration().list_of_port_identifiers().port_id())):
    #             self.dict_of_lhs_to_rhs[self.instance_name][ctx.input_declaration().list_of_port_identifiers().port_id()[i].getText()] = \
    #                 self.port_var_list[self.index]
    #             self.cur_lhs.append(ctx.input_declaration().list_of_port_identifiers().port_id()[i].getText())
    #             self.index += 1
    #     elif ctx.output_declaration() is not None:
    #         if ctx.output_declaration().list_of_port_identifiers() is not None:
    #             for i in range(0, len(ctx.output_declaration().list_of_port_identifiers().port_id())):
    #                 self.dict_of_lhs_to_rhs[self.instance_name][ctx.output_declaration().list_of_port_identifiers().port_id()[i].getText()] = \
    #                     self.port_var_list[self.index]
    #                 self.cur_lhs.append(ctx.output_declaration().list_of_port_identifiers().port_id()[i].getText())
    #                 self.index += 1
    #         elif ctx.output_declaration().list_of_variable_port_identifiers() is not None:
    #             for i in range(0, len(ctx.output_declaration().list_of_variable_port_identifiers().var_port_id())):
    #                 self.dict_of_lhs_to_rhs[self.instance_name][ctx.output_declaration().list_of_variable_port_identifiers().var_port_id()[i].getText()] = \
    #                     self.port_var_list[self.index]
    #                 self.cur_lhs.append(ctx.output_declaration().list_of_variable_port_identifiers().var_port_id()[i].getText())
    #                 self.index += 1


        


class MoudleParameterPortVisitor(SystemVerilogParserVisitor):
    def __init__(self, design, cur_prefixs, cur_dict_of_parameter, top_module):
        self.start = None
        self.stop = None
        self.ports_parameter = None
        self.design = design
        self.cur_prefixs = cur_prefixs
        self.cur_dict_of_parameters = cur_dict_of_parameter
        self.top_module = top_module
        
        
    def _modify_port_parameter(self):
        ports_parameter = self.design[self.start:self.stop+1]
        for item in self.cur_prefixs:
            if self.cur_dict_of_parameters.get(item) is None:
                continue
            else:
                # find index of the last ")" of str ports_parameter
                index = ports_parameter.rfind(')')
                index = index - len(ports_parameter)
                for key in self.cur_dict_of_parameters[item]:
                    # ignore the key with int type
                    if isinstance(key,int):
                        continue
                    ports_parameter = ports_parameter[:index]+",\nparameter "+key+"="+self.cur_dict_of_parameters[item][key]+ports_parameter[index:]
            self.ports_parameter = ports_parameter

    def _add_port_parameter(self):
        ports_parameter = " #()"
        for item in self.cur_prefixs:
            if self.cur_dict_of_parameters.get(item) is None:
                continue
            else:
                # find index of the last ")" of str ports_parameter
                index = ports_parameter.rfind(")")
                index = index - len(ports_parameter)
                for key in self.cur_dict_of_parameters[item]:
                    # ignore the key with int type
                    if isinstance(key, int):
                        continue
                    ports_parameter = (
                        ports_parameter[:index]
                        + "\n    parameter "
                        + key
                        + "="
                        + self.cur_dict_of_parameters[item][key]
                        + ","
                        + ports_parameter[index:]
                    )

        ports_parameter = (
            ports_parameter[:ports_parameter.rfind(",")]
            + ports_parameter[ports_parameter.rfind(",") + 1 :]
        )
        self.ports_parameter = ports_parameter

    def visitModule_declaration(
        self, ctx: SystemVerilogParser.Module_declarationContext
    ):
        if ctx.module_header().parameter_port_list() is not None:
            self.start = ctx.module_header().parameter_port_list().start.start
            self.stop = ctx.module_header().parameter_port_list().stop.stop
            # If the submodule have parameters, we should generate new parameters from the submodule
            if self.start != self.stop:
                self._modify_port_parameter()
        else:
            self.start = ctx.module_header().module_identifier().stop.stop + 1
            self.stop = ctx.module_header().module_identifier().stop.stop
            self._add_port_parameter()
    

class InstModuleVisitor(SystemVerilogParserVisitor):
    def __init__(self, design, cur_module_identifier, cur_dict_of_parameters, cur_prefixs, top_module, dict_of_lhs_to_rhs, cur_lhs):
        self.inst_module_node = None
        self.inst_module_design = None
        self.start = None   
        self.stop = None 
        self.indent = 2
        self.cur_module_identifier = cur_module_identifier
        self.cur_dict_of_parameters = cur_dict_of_parameters
        self.cur_prefixs = cur_prefixs
        self.top_module = top_module
        self.dict_of_lhs_to_rhs = dict_of_lhs_to_rhs
        self.cur_lhs = cur_lhs

        self.parameter_strat = None
        self.parameter_stop = None
        self.ports_param_str = None
        
        self.design = design
        
    def visitModule_declaration(self, ctx: SystemVerilogParser.Module_declarationContext):
        module_name = ctx.module_header().module_identifier().getText()
        if module_name == self.cur_module_identifier:
            self.start = ctx.start.start
            self.stop = ctx.stop.stop
            self.inst_module_node = ctx
            self.inst_module_design = self.design
            paramVisitor = ParamVisitor(self.cur_dict_of_parameters, self.cur_prefixs)
            paramVisitor.visit(ctx)
            # Ordered port assign
            for key in self.dict_of_lhs_to_rhs.keys():
                if type(self.dict_of_lhs_to_rhs[key])==list:
                    ordered_port_visitor = OrderedModulePortVisitor(self.dict_of_lhs_to_rhs, key, self.cur_lhs)
                    ordered_port_visitor.visit(ctx)
                
        if self.start != None and self.cur_dict_of_parameters != {}:
            if module_name == self.top_module:
                moduleParameterPortVisitor = MoudleParameterPortVisitor(self.inst_module_design, self.cur_prefixs, self.cur_dict_of_parameters, self.top_module)
                moduleParameterPortVisitor.visit(ctx)
                self.ports_param_str = moduleParameterPortVisitor.ports_parameter
                self.parameter_start = moduleParameterPortVisitor.start
                self.parameter_stop = moduleParameterPortVisitor.stop
                
            
            

class RenameModuleVisitor(SystemVerilogParserVisitor):
    def __init__(self,cur_prefixs_index,cur_prefixs,cur_module_identifier, cur_dict_lhs_to_rhs):
        self.inst_module_node = None
        self.inst_module_design = None
        self.start = None
        self.stop = None
        self.indent = 2
        self.cur_prefixs_index = cur_prefixs_index
        self.is_no_port_parameter = False
        self.port_parameter_flag = False
        self.cur_prefixs =cur_prefixs
        self.cur_module_identifier = cur_module_identifier
        self.cur_dict_lhs_to_rhs = cur_dict_lhs_to_rhs

        self.repeat_declr = set()
        
    
    def is_parents_parameter_port_list(self,ctx):
        if ctx is None:
            return False
        if not isinstance(ctx,SystemVerilogParser.Parameter_port_listContext):
            return self.is_parents_parameter_port_list(ctx.parentCtx)
        else:
            return True

    
    def is_parents_function_declaration(self,ctx):
        if ctx is None:
            return False
        if not isinstance(ctx, SystemVerilogParser.Function_declarationContext):
            return self.is_parents_function_declaration(ctx.parentCtx)
        else:
            return True
        
        "This function is used to traverse the tree and change the name of the instance"
    
    def _traverse_children(self,ctx):
        if self.is_parents_parameter_port_list(ctx):
            try:
                ctx.start.text = ""
                ctx.stop.text = ""
            except:
                ctx.symbol.text = ""
                pass
        if isinstance(ctx,TerminalNodeImpl):
            if ctx.symbol.text == "?":
                ctx.symbol.text = " ? "
        else:
            for child in ctx.getChildren():
                if isinstance(child,SystemVerilogParser.Simple_identifierContext):
                    if isinstance(
                        child.parentCtx.parentCtx,
                        SystemVerilogParser.Module_identifierContext,
                    ):
                        pass
                    elif isinstance(
                        child.parentCtx.parentCtx.parentCtx,
                        SystemVerilogParser.Module_program_interface_instantiationContext,
                    ):
                        pass
                    elif isinstance(
                        child.parentCtx.parentCtx,
                        SystemVerilogParser.Port_identifierContext,
                    ):
                        if self.is_parents_function_declaration(child):
                            child.start.text = (
                                ""
                                + self.cur_prefixs[self.cur_prefixs_index]
                                + "__"
                                + child.start.text
                                + ""
                            )
                        else:
                            pass
                    elif isinstance(
                        child.parentCtx.parentCtx,
                        SystemVerilogParser.Param_assignmentContext,
                    ) or isinstance(
                        child.parentCtx.parentCtx.parentCtx,
                        SystemVerilogParser.Named_parameter_assignmentContext,
                    ):
                        pass
                    elif isinstance(
                        child.parentCtx.parentCtx.parentCtx,
                        SystemVerilogParser.Net_decl_assignmentContext
                    ) or isinstance(
                        child.parentCtx.parentCtx.parentCtx,
                        SystemVerilogParser.Variable_decl_assignmentContext):
                        if child.start.text in self.cur_dict_lhs_to_rhs:
                            self.repeat_declr.add(child.start.text)
                        child.start.text = (
                            ""
                            + self.cur_prefixs[self.cur_prefixs_index]
                            + "__"
                            +child.start.text
                            + ""
                        )
                    else:
                        child.start.text = (
                            ""
                            + self.cur_prefixs[self.cur_prefixs_index]
                            + "__"
                            +child.start.text
                            + ""
                        )
                self._traverse_children(child)
                            
                            
                            
    
    def visitModule_declaration(self,ctx:SystemVerilogParser.Module_declarationContext):
        module_name = ctx.module_header().module_identifier().getText()
        if module_name == self.cur_module_identifier:
            self.start = ctx.start.start
            self.stop = ctx.stop.stop
            self.inst_module_node = ctx 
            self._traverse_children(self.inst_module_node)    


class InstModulePortVisitor(SystemVerilogParserVisitor):
    def __init__(self,cur_module_identifier, cur_prefixs, cur_dict_of_parameters):
        self.inst_module_node = None
        self.is_first_instantiation_module = False
        self.list_of_ports_width = []
        self.list_of_ports_direction = []
        self.list_of_ports_type = []
        self.list_of_data_type = []
        self.list_of_ports_lhs = []
        self.cur_module_identifier = cur_module_identifier
        self.cur_prefixs = cur_prefixs
        self.cur_dict_of_parameters = cur_dict_of_parameters
        
    def _traverse_children_in_header(self,ctx):
        if isinstance(ctx, TerminalNodeImpl):
            if ctx.symbol.text == "?":
                ctx.symbol.text = " ? "
        else:
            for child in ctx.getChildren():
                if isinstance(child, SystemVerilogParser.Port_directionContext) \
                    and child.getText()=='input':
                    self.list_of_ports_direction.append(child.INPUT().getText())
                    self.list_of_ports_lhs.append(
                        child.parentCtx.port_identifier().getText()
                    )
                    self.list_of_ports_type.append("wire")
                    if child.parentCtx.implicit_data_type() is not None:
                        if child.parentCtx.implicit_data_type().packed_dimension() is not None:
                            self.list_of_ports_width.append(child.parentCtx.implicit_data_type().packed_dimension()[0].getText())
                        else:
                            self.list_of_ports_width.append("")
                        if child.parentCtx.implicit_data_type().signing() is not None:
                            self.list_of_data_type.append(child.parentCtx.implicit_data_type().signing().getText())
                        else:
                            self.list_of_data_type.append("")
                    else:
                        self.list_of_ports_width.append("")
                        self.list_of_data_type.append("")
                        
                    # TODO: data_type() is not none
                        
                    
                if isinstance(child, SystemVerilogParser.Port_directionContext) \
                        and child.getText()=='output':
                    self.list_of_ports_direction.append(child.getText())
                    
                    if child.parentCtx.data_type() is not None:
                        self.list_of_ports_type.append(child.parentCtx.data_type().integer_vector_type().getText())
                    else:
                        self.list_of_ports_type.append("wire")
                        
                    if child.parentCtx.port_identifier() is not None:
                        self.list_of_ports_lhs.append(
                            child.parentCtx.port_identifier().getText()
                        )
                    else:
                        self.list_of_ports_lhs.append(
                            child.list_of_variable_port_identifiers().getText()
                        )
                    if child.parentCtx.implicit_data_type():
                        if child.parentCtx.implicit_data_type().packed_dimension() is not None:
                            # TODO: Incorrect for multiple packed
                            self.list_of_ports_width.append(child.parentCtx.implicit_data_type().packed_dimension()[0].getText())
                        else:
                            self.list_of_ports_width.append("")
                            
                        if child.parentCtx.implicit_data_type().signing() is not None :
                            self.list_of_data_type.append(
                                child.parentCtx.implicit_data_type().signing().getText()
                            )
                        else:
                            self.list_of_data_type.append("")
                    else:
                        self.list_of_ports_width.append("")
                        self.list_of_data_type.append("")
                    # TODO: data_type() is not none
                    
                if isinstance(child, SystemVerilogParser.Inout_declarationContext) \
                        and child.getText()=='inout':
                    self.list_of_ports_direction.append(child.getText())
                    self.list_of_ports_lhs.append(
                        child.list_of_port_identifiers().getText()
                    )
                    self.list_of_ports_type.append("wire")
                    if child.implicit_data_type() is not None:
                        if child.implicit_data_type().packed_dimension() is not None:
                            self.list_of_ports_width.append(child.implicit_data_type().packed_dimension()[0].getText())
                        else:
                            self.list_of_ports_width.append("")
                        if child.implicit_data_type().signing() is not None:
                            self.list_of_data_type.append(child.implicit_data_type().signing().getText())
                        else:
                            self.list_of_data_type.append("")
                    else:
                        self.list_of_ports_width.append("")
                        self.list_of_data_type.append("")
                        
                        
                if isinstance(child, SystemVerilogParser.Port_declContext) \
                    and child.ansi_port_declaration().port_direction() is None:
                        self.list_of_ports_direction.append(self.list_of_ports_direction[-1])
                        self.list_of_ports_lhs.append(
                            child.ansi_port_declaration().port_identifier().getText()
                        )
                        self.list_of_ports_type.append(self.list_of_ports_type[-1])
                        self.list_of_ports_width.append(self.list_of_ports_width[-1])
                        self.list_of_data_type.append(self.list_of_data_type[-1])
                        
                self._traverse_children_in_header(child)    
    
    def _traverse_children_in_module_item(self,ctx):
        if isinstance(ctx, TerminalNodeImpl):
            if ctx.symbol.text == "?":
                ctx.symbol.text = " ? "
        else:
            for child in ctx.getChildren():
                if isinstance(child, SystemVerilogParser.Input_declarationContext) \
                    and child.getChild(0).getText()=='input':
                    for item in child.list_of_port_identifiers().port_id():
                        self.list_of_ports_direction.append('input')
                        self.list_of_ports_lhs.append(
                            item.getText()
                        )
                        self.list_of_ports_type.append("wire")
                        if child.implicit_data_type() is not None:
                            if child.implicit_data_type().packed_dimension() is not None:
                                self.list_of_ports_width.append(child.implicit_data_type().packed_dimension()[0].getText())
                            else:
                                self.list_of_ports_width.append("")
                            if child.implicit_data_type().signing() is not None:
                                self.list_of_data_type.append(child.implicit_data_type().signing().getText())
                            else:
                                self.list_of_data_type.append("")
                        else:
                            self.list_of_ports_width.append("")
                            self.list_of_data_type.append("")
                        
                if isinstance(child, SystemVerilogParser.Output_declarationContext) \
                    and child.getChild(0).getText()=='output':
                    if child.list_of_port_identifiers():
                        for item in child.list_of_port_identifiers().port_id():
                            self.list_of_ports_direction.append('output')
                            self.list_of_ports_lhs.append(
                                item.getText()
                            )
                            self.list_of_ports_type.append("wire")
                            if child.implicit_data_type() is not None:
                                if child.implicit_data_type().packed_dimension() is not None:
                                    self.list_of_ports_width.append(child.implicit_data_type().packed_dimension()[0].getText())
                                else:
                                    self.list_of_ports_width.append("")
                                if child.implicit_data_type().signing() is not None:
                                    self.list_of_data_type.append(child.implicit_data_type().signing().getText())
                                else:
                                    self.list_of_data_type.append("")
                            else:
                                self.list_of_ports_width.append("")
                                self.list_of_data_type.append("")
                    elif child.list_of_variable_port_identifiers():
                        for item in child.list_of_variable_port_identifiers().var_port_id():
                            self.list_of_ports_direction.append('output')
                            self.list_of_ports_lhs.append(
                                item.getText()
                            )
                            self.list_of_ports_type.append("reg")
                            if child.data_type() is not None:
                                if child.data_type().packed_dimension() != []:
                                    self.list_of_ports_width.append(child.data_type().packed_dimension()[0].getText())
                                else:
                                    self.list_of_ports_width.append("")
                                if child.data_type().signing() is not None:
                                    self.list_of_data_type.append(child.data_type().signing().getText())
                                else:
                                    self.list_of_data_type.append("")
                            else:
                                self.list_of_ports_width.append("")
                                self.list_of_data_type.append("")
                    
                # TODO: inout
                if isinstance(child, SystemVerilogParser.Inout_declarationContext) \
                    and child.getChild(0).getText()=='inout':
                    for item in child.list_of_port_identifiers().port_id():
                        self.list_of_ports_direction.append('inout')
                        self.list_of_ports_lhs.append(
                            item.getText()
                        )
                        self.list_of_ports_type.append("wire")
                        if child.implicit_data_type() is not None:
                            if child.implicit_data_type().packed_dimension() is not None:
                                self.list_of_ports_width.append(child.implicit_data_type().packed_dimension()[0].getText())
                            else:
                                self.list_of_ports_width.append("")
                            if child.implicit_data_type().signing() is not None:
                                self.list_of_data_type.append(child.implicit_data_type().signing().getText())
                            else:
                                self.list_of_data_type.append("")
                        else:
                            self.list_of_ports_width.append("")
                            self.list_of_data_type.append("")
                            
                if isinstance(child, SystemVerilogParser.Param_assignmentContext):
                    if child.getChildCount() == 3:
                        param_name = child.getChild(0).getText().replace(" ", "")
                        param_value = child.getChild(2).getText().replace(" ", "")
                        # Append param_name and param_value to cur_dict_of_parameters
                        for i in range(0, len(self.cur_prefixs)):
                            if self.cur_dict_of_parameters.get(self.cur_prefixs[i]) is None:
                                self.cur_dict_of_parameters[self.cur_prefixs[i]] = {}
                            if self.cur_dict_of_parameters[self.cur_prefixs[i]].get(
                                param_name
                            ) is None and param_name.startswith(self.cur_prefixs[i]):
                                self.cur_dict_of_parameters[self.cur_prefixs[i]][
                                    param_name
                                ] = param_value
                                
                self._traverse_children_in_module_item(child)
    
    def visitModule_declaration(self, ctx:SystemVerilogParser.Module_declarationContext):
        
        def is_port_direction_under_module_header(ctx):
            module_header = ctx.module_header()
            list_of_port_declarations = module_header.list_of_port_declarations()
            if list_of_port_declarations is None:
                raise ValueError("No port declaration under module header")
            
            if list_of_port_declarations.port_decl() != [] and \
                list_of_port_declarations.port_decl()[0].ansi_port_declaration().port_direction() is not None:
                    return True
            return False
        
        module_name = ctx.module_header().module_identifier().getText()
        if module_name == self.cur_module_identifier:
            self.start = ctx.start.start
            self.stop = ctx.stop.stop
            self.inst_module_node = ctx
            # Whether the port direction under the module header
            if is_port_direction_under_module_header(ctx):
                self._traverse_children_in_header(self.inst_module_node) 
            else:
                self._traverse_children_in_module_item(self.inst_module_node)
                                
class InstBodyVisitor(SystemVerilogParserVisitor):
    def __init__(self):
        super().__init__()
        self.inst_module_node = None
        self.inst_module_design = None
        self.text = ""
    def formatProcess(self,ctx):
        self._traverse_children(ctx,2)
        if ctx.getChildCount() == 0:
            return ""
        
        temp = ""
        for child in ctx.getChildren():
            temp += child.getText() + " "
            
        for line in temp.splitlines():
            for char in line:
                if char == chr(31):
                    self.text += "\n"
                else:
                    self.text += char
    def _traverse_children(self,ctx,indent=2):
        if isinstance(ctx, TerminalNodeImpl):
            pass
        else:
            for child in ctx.getChildren():
                if isinstance(child,SystemVerilogParser.List_of_port_declarationsContext):
                    child.start.text = (
                        chr(31) + " " * (indent - 2) + child.start.text + " "
                    )
                if isinstance(child, SystemVerilogParser.Data_declarationContext):
                    if child.data_type().getText()=="reg":
                        child.start.text = chr(31) + " " * (indent - 2) +child.start.text
                    elif child.data_type().getText()=="integer":
                        child.start.text = chr(31) + " " * (indent - 2) +child.start.text
                if isinstance(child, SystemVerilogParser.Net_declarationContext):
                    child.start.text = chr(31) + " " * (indent - 2) +child.start.text
                if isinstance(child,SystemVerilogParser.Continuous_assignContext):
                    child.start.text = (
                        chr(31) + " " * (indent - 2) +child.start.text + " "
                    )
                if isinstance(child,SystemVerilogParser.Always_constructContext):
                    child.start.text = (
                        chr(31) + " " *(indent - 2) + child.start.text + " "
                    )
                    child.stop.text = child.stop.text + chr(31)
                if isinstance(child,SystemVerilogParser.Event_expressionContext):
                    child.start.text = " " + child.start.text + " "
                if isinstance(child,SystemVerilogParser.Case_statementContext):
                    child.start.text = (
                        chr(31) + " " * (indent - 2) + child.start.text + " "
                    )
                    child.stop.texxt = chr(31) + " " *(indent - 2) + child.stop.text + " "
                if isinstance(child,SystemVerilogParser.Case_itemContext):
                    child.start.text = (
                        chr(31) + " " * (indent - 2) + child.start.text + " "
                    )
                if isinstance(child,SystemVerilogParser.Conditional_statementContext):
                    child.start.text = (
                        chr(31) + " " * (indent - 2) + child.start.text + " "
                    )
                if isinstance(child, TerminalNodeImpl) and (
                    child.symbol.text == "else"
                ):
                    child.symbol.text = (
                        chr(31) + " " * (indent - 2) + child.symbol.text + " "
                    )
                elif isinstance(child, TerminalNodeImpl) and (
                    child.symbol.text == "or"
                ):
                    child.symbol.text = " " * (indent - 2) + child.symbol.text + " "
                if isinstance(child,SystemVerilogParser.Simple_identifierContext):
                    child.start.text = " " + child.start.text + " "
                if isinstance(child,SystemVerilogParser.Nonblocking_assignmentContext):
                    child.start.text = (
                        chr(31) + " " * (indent - 2) +child.start.text + " "
                    )
                if isinstance(child,SystemVerilogParser.Seq_blockContext):
                    child.start.text = (
                        chr(31) + " " * (indent - 2) +child.start.text + " "
                    )
                    child.stop.text = chr(31) + " " * (indent - 2) + child.stop.text + " "
                if isinstance(child,SystemVerilogParser.Blocking_assignmentContext):
                    child.start.text = (
                        chr(31) + " " *(indent - 2) + child.start.text + " "
                    )
                if isinstance(child,SystemVerilogParser.Module_program_interface_instantiationContext):
                    child.start.text = (
                        chr(31) + " " *indent + child.start.text + " "
                    )
                self._traverse_children(child, indent+1)
        
    def visitModule_declaration(self, ctx:SystemVerilogParser.Module_declarationContext):
        self.inst_module_node = ctx 
        self.formatProcess(self.inst_module_node)
        self.inst_module_node = parse_design_to_tree(self.text)

class InstBodyVisitor2(SystemVerilogParserVisitor):
    def __init__(self):
        self.start = None
        self.stop = None
        self.firstTerminal = False
        
    def ExtractStartAndStop(self,ctx):
        def is_port_direction_under_module_header(ctx):
            module_header = ctx.module_header()
            list_of_port_declarations = module_header.list_of_port_declarations()
            if list_of_port_declarations is None:
                raise ValueError("No port declaration under module header")
            
            if list_of_port_declarations.port_decl() != [] and \
                list_of_port_declarations.port_decl()[0].ansi_port_declaration().port_direction() is not None:
                    return True
            return False
        
        self.stop = ctx.ENDMODULE().getSymbol().start - 1
        if is_port_direction_under_module_header(ctx):
            for child in ctx.module_header().getChildren():
                if isinstance(child,TerminalNodeImpl):
                    if self.firstTerminal == False:
                        self.start = child.symbol.stop + 1
                        self.firstTerminal = True
        else:
            for child in ctx.module_item():
                if child.getText().startswith("input") or child.getText().startswith("output") or child.getText().startswith("inout"):
                    pass
                else:
                    self.start = child.start.start
                    break
        
    def visitModule_declaration(self,ctx:SystemVerilogParser.Module_declarationContext):
        self.ExtractStartAndStop(ctx)
                    
class IdentifierVisitor(SystemVerilogParserVisitor):
    def __init__(self,cur_name_of_module_instance,top_module,design,cur_new_variable,insert_parts,cur_new_assign):
        self.start = []
        self.stop = []
        self.tmp_design = ''
        self.cur_name_of_module_instance = cur_name_of_module_instance
        self.top_module = top_module
        self.design = design
        self.cur_new_variable = cur_new_variable
        self.insert_parts = insert_parts
        self.cur_new_assign = cur_new_assign
    
    def _traverse_children(self,ctx):
        if isinstance(ctx, TerminalNodeImpl):
            pass
        else:
            for child in ctx.getChildren():
                if isinstance(child, SystemVerilogParser.Module_program_interface_instantiationContext):
                    FIRST_HIER_INST = True
                    for cur_name in self.cur_name_of_module_instance:
                        # Handle multiple instance in one declaration
                        for i in range(0, len(child.children)):
                            if isinstance(child.getChild(i), SystemVerilogParser.Hierarchical_instanceContext):
                                if (child.getChild(i).name_of_instance().getText()== cur_name):
                                    if FIRST_HIER_INST:
                                        self.start.append(child.getChild(0).start.start)
                                        FIRST_HIER_INST = False
                                    else:
                                        self.start.append(child.getChild(i).start.start)
                                    self.stop.append(child.getChild(i+1).symbol.stop)
                self._traverse_children(child)
    
    
    def visitModule_declaration(self,ctx:SystemVerilogParser.Module_declarationContext):
        def remove_leading_whitespace(input_string):
            cleaned_string = re.sub(r'^\s*\n', '', input_string, flags=re.MULTILINE).lstrip()
            return cleaned_string 
        if ctx.module_header().module_identifier().getText() == self.top_module:
            self._traverse_children(ctx)
            self.tmp_design += self.design[ : self.start[0]]
            for i in range(0,len(self.cur_new_variable)):
                if i == 0:
                    if not self.tmp_design[-3:].isspace():
                        self.tmp_design += 4*" "+ self.cur_new_variable[i] + '\n'
                    else:
                        self.tmp_design += self.cur_new_variable[i] + '\n'
                else:
                    self.tmp_design += 4*" "+self.cur_new_variable[i] + '\n'
            self.tmp_design += '\n' + 4*" "+ remove_leading_whitespace(self.insert_parts[0]) + '\n'
            for i in range(1,len(self.start)):
                substring = " "*4+self.design[self.stop[i-1] + 1 : self.start[i]] + '\n'
                if not substring.isspace():
                    self.tmp_design += substring
                self.tmp_design += 4*" " + remove_leading_whitespace(self.insert_parts[i])+ '\n'
            for assign in self.cur_new_assign:
                self.tmp_design += " "*4+assign +'\n'
            self.tmp_design += " "*4+self.design[self.stop[-1] + 1 :] + '\n'
                                          
         


def pyflattenverilog(design: str, top_module: str, exlude_module : set):
    
    top_design_str = extract_module(design, top_module)
    
    tree = parse_design_to_tree(top_design_str)
    
    # Step 1. 找到顶层模块节点
    top_finder= TopModuleNodeFinder(top_module)
    top_finder.visit(tree)
    top_node_tree = top_finder.top_module_node 
    
    # Step 2. 收集Top节点实例化的信息
    visitor = MyModuleInstantiationVisitor(exlude_module)
    visitor.visit(top_node_tree)
    cur_module_identifier =visitor.module_identifier
    cur_name_of_module_instances = visitor.name_of_module_instances
    cur_prefixs = cur_name_of_module_instances
    cur_list_of_ports_rhs = visitor.list_of_ports_rhs
    cur_dict_of_parameters = visitor.dict_of_parameters
    dict_of_lhs_to_rhs = visitor.dict_of_lhs_to_rhs
    
    
    if cur_module_identifier == "":
        return True, top_design_str
    else:
        print(  
            "[Processing] MODULE: %s\tNAME:%s"
            % (cur_module_identifier, cur_name_of_module_instances)
        )
        
    # Step 3. 改名及替换实例化部分
    instance_design_str = extract_module(design,cur_module_identifier)
    top_instance_str = top_design_str + '\n' + instance_design_str
    tree = parse_design_to_tree(top_instance_str)
    visitor = InstModuleVisitor(cur_module_identifier=cur_module_identifier, cur_dict_of_parameters=cur_dict_of_parameters, \
        cur_prefixs=cur_prefixs, top_module=top_module, design=top_instance_str, dict_of_lhs_to_rhs=dict_of_lhs_to_rhs, cur_lhs=[])
    visitor.visit(tree)
    inst_module_design = top_instance_str[visitor.start : visitor.stop + 1]
    # cur_list_of_ports_rhs = visitor.cur_rhs
      
    # Step 3.1. 替换模块变量
    inst_module_design_trees = []
    inst_module_nodes = []
    if cur_dict_of_parameters != {}:
        visitor.visit(tree)
        # This can be optimized
        top_instance_str = (
            top_instance_str[: visitor.parameter_start]
            + visitor.ports_param_str
            + top_instance_str[visitor.parameter_stop+1:]
        )
        tree = parse_design_to_tree(top_instance_str)
        visitor = TopModuleNodeFinder(top_module)
        visitor.visit(tree)
        top_node_tree = visitor.top_module_node

    # We should identify repeat decleration
    repeat_decl_dict = {}
    for k in range(0,len(cur_prefixs)):
        tmp_inst_module_design = parse_design_to_tree(inst_module_design)
        visitor = RenameModuleVisitor(k,cur_prefixs,cur_module_identifier, dict_of_lhs_to_rhs[cur_prefixs[k]])
        visitor.visit(tmp_inst_module_design)
        inst_module_design_trees.append(tmp_inst_module_design)
        inst_module_nodes.append(visitor.inst_module_node)
        repeat_decl_dict[cur_prefixs[k]] = visitor.repeat_declr
        
    # Step 3.2. 进一步收集信息
    cur_list_of_ports_lhs = []
    cur_list_of_ports_lhs_width = []
    cur_list_of_ports_width = []
    cur_list_of_ports_direction = []
    cur_list_of_ports_type = []
    cur_list_of_data_type = []
    cur_dict_of_ports = {}

    for i in range(0, len(inst_module_design_trees)):
        visitor = InstModulePortVisitor(cur_module_identifier, cur_prefixs, cur_dict_of_parameters)
        visitor.visit(inst_module_design_trees[i])
        cur_list_of_ports_lhs = cur_list_of_ports_lhs + visitor.list_of_ports_lhs
        cur_list_of_ports_lhs_width = (
            cur_list_of_ports_lhs_width + visitor.list_of_ports_width
        )
        cur_list_of_ports_width = cur_list_of_ports_width + visitor.list_of_ports_width
        cur_list_of_ports_direction = (
            cur_list_of_ports_direction + visitor.list_of_ports_direction
        )
        cur_list_of_ports_type = cur_list_of_ports_type + visitor.list_of_ports_type
        cur_list_of_data_type = cur_list_of_data_type + visitor.list_of_data_type
        
    for i in range(0,len(cur_list_of_ports_lhs)):
        cur_dict_of_ports[cur_list_of_ports_lhs[i]] = {
            "width": cur_list_of_ports_lhs_width[i],
            "direction": cur_list_of_ports_direction[i],
            "type":cur_list_of_ports_type[i],
        }   
        
    # Step 3.3 组合需要替换的素材
    cur_new_variable = []
    cur_new_assign = []
    
    for k in range(0,len(cur_prefixs)):
        len_instance_port = int(len(cur_list_of_ports_lhs)/len(cur_prefixs))
        ports_lhs_width = copy.deepcopy(cur_list_of_ports_lhs_width)
        for i in range(0,len_instance_port):
            if cur_list_of_data_type[k * len_instance_port + i]!= "":
                cur_new_variable.append(
                    cur_list_of_data_type[k * len_instance_port + i]
                    + ports_lhs_width[k * len_instance_port + i]
                    + " "
                    + cur_prefixs[k]
                    + "__"
                    + cur_list_of_ports_lhs[k * len_instance_port +i]
                    +";"
                )
            elif cur_list_of_ports_type[k * len_instance_port + i] == "reg":
                if cur_list_of_ports_lhs[k * len_instance_port + i] not in repeat_decl_dict[cur_prefixs[k]]:
                    cur_new_variable.append(
                        "reg"
                        + ports_lhs_width[k * len_instance_port +i]
                        + " "
                        + cur_prefixs[k]
                        + "__"
                        + cur_list_of_ports_lhs[k * len_instance_port + i]
                        + ";"
                    )
            else:
                if cur_list_of_ports_lhs[k * len_instance_port +i] not in repeat_decl_dict[cur_prefixs[k]]:
                    cur_new_variable.append(
                        "wire"
                        + ports_lhs_width[k *len_instance_port +i]
                        + " "
                        +cur_prefixs[k]
                        + "__"
                        + cur_list_of_ports_lhs[k * len_instance_port +i]
                        + ";"
                    )
            if cur_list_of_ports_direction[k * len_instance_port + i] == "input":
                rhs = dict_of_lhs_to_rhs[cur_prefixs[k]].get(
                    cur_list_of_ports_lhs[k * len_instance_port + i]
                )
                if rhs is None:
                    if len(cur_list_of_ports_rhs) <= k * len_instance_port + i:
                        continue
                    else:
                        rhs = cur_list_of_ports_rhs[k* len_instance_port +i] # DANGEROUS: Maybe bug here
                if rhs == "" or rhs.strip()=="":
                    continue
                cur_new_assign.append(
                    "assign "
                    + cur_prefixs[k]
                    + "__" 
                    + cur_list_of_ports_lhs[k * len_instance_port +i]
                    + " = "
                    + rhs
                    + ";"
                )
            else:
                rhs = dict_of_lhs_to_rhs[cur_prefixs[k]].get(
                    cur_list_of_ports_lhs[k * len_instance_port + i]
                )
                if rhs is None:
                    if len(cur_list_of_ports_rhs) <= k * len_instance_port + i:
                        continue
                    else:
                        rhs = cur_list_of_ports_rhs[k * len_instance_port + i] # DANGEROUS: Maybe bug here
                if rhs == "" or rhs.strip()=="":
                    continue
                cur_new_assign.append(
                    "assign "
                    + rhs
                    + " = "
                    + cur_prefixs[k]
                    + "__"
                    + cur_list_of_ports_lhs[k * len_instance_port + i]
                    + ";"
                )

    inst_module_designs = []
    for k in range(0,len(cur_prefixs)):
        visitor = InstBodyVisitor()
        visitor.visit(inst_module_nodes[k])
        inst_module_nodes[k]= visitor.inst_module_node
        inst_module_designs.append(visitor.text)
        
    # 3.4 拼接所获得素材，获得最终数据
    insert_parts = []
    for k in range (0,len(cur_prefixs)):
        visitor = InstBodyVisitor2()
        visitor.visit(inst_module_nodes[k])
        insert_parts.append(inst_module_designs[k][visitor.start : visitor.stop])
        
    visitor = IdentifierVisitor(cur_name_of_module_instance=cur_name_of_module_instances,design=top_instance_str,
                                top_module = top_module, cur_new_variable=cur_new_variable,insert_parts = insert_parts,cur_new_assign=cur_new_assign)
    visitor.visit(top_node_tree)

    
    flatten_design = replace_module(design, top_module, visitor.tmp_design)

    return False, flatten_design