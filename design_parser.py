from antlr4_systemverilog import InputStream, CommonTokenStream
from antlr4_systemverilog.systemverilog import SystemVerilogLexer, SystemVerilogParser, SystemVerilogPreParser
from antlr4.ListTokenSource import ListTokenSource
import re

def parse(Design):
   lexer = SystemVerilogLexer(InputStream(Design))
   token_stream = CommonTokenStream(lexer)

   # 填充Token流
   token_stream.fill()

   # 创建一个空列表来存储DIRECTIVES通道的Tokens
   directive_tokens = []

   # 遍历token_stream中的所有Tokens
   for token in token_stream.tokens:
      # 检查token的通道是否是DIRECTIVES
      if token.channel != 2:
         # 如果是，将token添加到directive_tokens列表中
         directive_tokens.append(token)


   # 如果没有找到DIRECTIVES通道的Tokens，直接返回EOF
   if not directive_tokens:
      print("No DIRECTIVES tokens found")
      return None

   # 创建新的TokenStream仅包含DIRECTIVES通道的Tokens
   directive_token_source = ListTokenSource(directive_tokens)
   filtered_token_stream = CommonTokenStream(directive_token_source)

   # 创建Parser并解析
   parser = SystemVerilogParser(filtered_token_stream)
   return parser

"This function is used to convert the systemverilog to a tree"
def parse_design_to_tree(Design):
   parser = parse(Design)
   tree = parser.source_text()
   return tree

def parse_port_to_tree(Design):
   parser = parse(Design)
   tree = parser.list_of_port_declarations()
   return tree

def parse_parameter_to_tree(Design):
   parser = parse(Design)
   tree = parser.module_parameter_port_list()
   return tree

def parse_module_to_tree(Design):
   parser = parse(Design)
   tree = parser.module_item()
   return tree

def parse_net_declare_to_tree(Design):
   parser = parse(Design)
   tree = parser.net_declaration()
   return tree

def parse_reg_declare_to_tree(Design):
   parser = parse(Design)
   tree = parser.reg_declaration()
   return tree

def parse_mod_ins_to_tree(Design):
   parser = parse(Design)
   tree = parser.module_instantiation()
   return tree

def extract_module(verilog_code: str, module_name: str) -> str:
    """
    从Verilog代码中提取指定模块的定义。

    :param verilog_code: 包含整个设计的Verilog代码字符串
    :param module_name: 要提取的模块名称
    :return: 提取出的模块字符串
    """
    
    # 使用正则表达式匹配模块开头和结尾
    # 这个正则表达式匹配 "module module_name" 到 "endmodule" 之间的内容
    module_pattern = re.compile(rf'module\s+{module_name}\s*.*?endmodule', re.S)
    
    # 搜索模块
    match = module_pattern.search(verilog_code)
    
    if match:
        # 返回匹配到的模块字符串
        return match.group(0)
    else:
        # 如果没有找到对应模块，返回空字符串或者提示
        return f"Error: Module '{module_name}' not found."
     
def replace_module(verilog_code: str, module_name: str, new_module_code: str) -> str:
    """
    替换Verilog代码中的指定模块为新的模块定义，并手动处理特殊字符。

    :param verilog_code: 包含整个芯片设计的Verilog代码字符串
    :param module_name: 要替换的模块名称
    :param new_module_code: 新的模块定义字符串
    :return: 返回替换后的完整Verilog代码
    """
    
    # 正则表达式匹配目标模块
    module_pattern = re.compile(rf'module\s+{module_name}\s*.*?endmodule', re.S)

    # 手动转义替换字符串中的百分号和反斜杠
    safe_new_module_code = new_module_code.replace('\\', '\\\\')

    # 使用 re.sub() 进行替换
    updated_verilog_code = re.sub(module_pattern, safe_new_module_code, verilog_code)

    return updated_verilog_code