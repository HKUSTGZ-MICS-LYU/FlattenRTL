import re
import sys
from collections import deque

# Verilog 保留关键字集合
VERILOG_KEYWORDS = {
    "generate", "endgenerate", "if", "else", "case", "endcase", "begin", "end",
    "for", "while", "always", "assign", "endmodule", "module", "wire", "reg",
    "input", "output", "parameter", "localparam"
}

def remove_comments(verilog_code):
    """
    去除 Verilog 代码中的注释（单行和多行注释）。
    """
    # 去除单行注释 //
    no_single_line_comments = re.sub(r'//.*', '', verilog_code)
    # 去除多行注释 /* ... */
    no_comments = re.sub(r'/\*.*?\*/', '', no_single_line_comments, flags=re.S)
    return no_comments


def extract_module_definitions(verilog_code):
    """
    提取 Verilog 文件中的模块定义及其参数。
    返回一个字典：{模块名: (模块代码字符串, 参数字典)}。
    """
    module_pattern = re.compile(r'module\s+([a-zA-Z_][a-zA-Z0-9_]*)\s*(#\s*\((.*?)\))?\s*\(.*?\);', re.S)
    parameter_pattern = re.compile(r'(parameter|localparam)\s+(?:\[.*?\]\s+)?([a-zA-Z_][a-zA-Z0-9_]*)\s*=\s*(.*?);', re.S)

    modules = {}
    for module_match in module_pattern.finditer(verilog_code):
        module_name = module_match.group(1)
        module_body = verilog_code[module_match.end():verilog_code.find("endmodule", module_match.start())]
        
        # 提取模块内的 parameter 和 localparam
        params = {}
        for param_match in parameter_pattern.finditer(module_body):
            param_name = param_match.group(2)
            param_value = param_match.group(3).strip()
            params[param_name] = param_value

        modules[module_name] = (module_body, params)

    return modules


def extract_private_modules(module_body):
    """
    提取 `generate` 块中的私有模块及其参数。
    返回一个列表：[(私有模块名, 参数字典)]。
    """
    private_modules = []
    generate_pattern = re.compile(r'generate\s+(.*?)\s+endgenerate', re.S)
    localparam_pattern = re.compile(r'localparam\s+(?:\[.*?\]\s+)?([a-zA-Z_][a-zA-Z0-9_]*)\s*=\s*(.*?);', re.S)

    for generate_block in generate_pattern.finditer(module_body):
        block_body = generate_block.group(1)

        # 提取 `if` 块中的私有模块
        if_pattern = re.compile(r'if\s+\(.*?\)\s+begin\s*:\s*([a-zA-Z_][a-zA-Z0-9_]*)\s+(.*?)end', re.S)
        for if_match in if_pattern.finditer(block_body):
            private_name = if_match.group(1)
            private_body = if_match.group(2)

            # 提取私有模块中的 `localparam`
            localparams = {}
            for param_match in localparam_pattern.finditer(private_body):
                param_name = param_match.group(1)
                param_value = param_match.group(2).strip()
                localparams[param_name] = param_value

            private_modules.append((private_name, localparams))

    return private_modules


def evaluate_expression(expression, resolved_params):
    """
    使用 Python 的 eval 函数解析 Verilog 表达式。
    """
    # 替换参数名为其值
    for param_name, param_value in resolved_params.items():
        expression = re.sub(rf'\b{param_name}\b', str(param_value), expression)
    # 替换 Verilog 运算符为 Python 运算符
    expression = expression.replace(">>", ">>").replace("<<", "<<")
    expression = expression.replace("&", "&").replace("|", "|").replace("~", "~")
    try:
        return eval(expression)
    except Exception:
        return expression  # 如果解析失败，返回原始表达式


def resolve_param_value(param_name, param_value, resolved_params, parent_params):
    """
    递归解析参数值。
    """
    # 如果是数字，直接返回
    if param_value.isdigit():
        return int(param_value)
    # 如果引用已经解析过的参数
    if param_value in resolved_params:
        return resolved_params[param_value]
    # 如果引用父级参数
    if param_value in parent_params:
        resolved_params[param_value] = resolve_param_value(
            param_value, parent_params[param_value], resolved_params, parent_params
        )
        return resolved_params[param_value]
    # 如果是表达式，尝试计算
    return evaluate_expression(param_value, resolved_params)


def resolve_module_params(module_name, module_params, parent_params):
    """
    解析模块的所有参数，计算出最终值。
    """
    resolved_params = {}
    for param_name, param_value in module_params.items():
        resolved_params[param_name] = resolve_param_value(param_name, param_value, resolved_params, parent_params)
    return resolved_params

def extract_instance_params(module_body):
    """
    提取模块实例化及其传递的参数（支持有参数化和无参数化的实例化）。
    返回一个列表：[(模块名, 实例名, {参数名: 参数值})]。
    """
    # 匹配有参数化的实例化
    param_instance_pattern = re.compile(
        r'([a-zA-Z_][a-zA-Z0-9_]*)\s*#\s*\((.*?)\)\s+([a-zA-Z_][a-zA-Z0-9_]*)\s*\(', re.S
    )
    # 匹配无参数化的实例化
    no_param_instance_pattern = re.compile(
        r'([a-zA-Z_][a-zA-Z0-9_]*)\s+([a-zA-Z_][a-zA-Z0-9_]*)\s*\(', re.S
    )
    # 提取模块实例化
    instances = []

    # 解析有参数化的实例化
    for instance_match in param_instance_pattern.finditer(module_body):
        module_name = instance_match.group(1)
        param_block = instance_match.group(2)
        instance_name = instance_match.group(3)

        # 提取参数传递
        params = {}
        param_assign_pattern = re.compile(r'\.([a-zA-Z_][a-zA-Z0-9_]*)\((.*?)\)')
        for param_assign_match in param_assign_pattern.finditer(param_block):
            param_name = param_assign_match.group(1)
            param_value = param_assign_match.group(2).strip()
            params[param_name] = param_value

        instances.append((module_name, instance_name, params))

    # 解析无参数化的实例化
    for instance_match in no_param_instance_pattern.finditer(module_body):
        module_name = instance_match.group(1)
        instance_name = instance_match.group(2)
        instances.append((module_name, instance_name, {}))  # 无参数传递，使用默认参数

    # 过滤掉 Verilog 关键字
    instances = [
        (module_name, instance_name, params)
        for module_name, instance_name, params in instances
        if module_name not in VERILOG_KEYWORDS
    ]

    return instances


def resolve_instance_params(top_module, modules, parsed_instances=None):
    """
    从指定的顶层模块开始，递归解析所有实例化的参数。
    返回一个字典：{实例名: {参数名: 参数值}}。
    """
    if parsed_instances is None:
        parsed_instances = {}

    queue = deque([(top_module, {}, None)])  # (模块名, 父级参数, 实例名)

    while queue:
        current_module, parent_params, instance_name = queue.popleft()

        if current_module not in modules:
            print(f"无法解析的模块: {current_module}")
            continue

        module_body, module_params = modules[current_module]

        # 解析当前模块的参数
        resolved_params = resolve_module_params(current_module, module_params, parent_params)
        if instance_name:
            parsed_instances[instance_name] = resolved_params

        # 打印当前模块解析结果
        print(f"解析模块: {current_module}，实例: {instance_name}")
        for param_name, param_value in resolved_params.items():
            print(f"  参数: {param_name} = {param_value}")

        # 提取并解析私有模块
        private_modules = extract_private_modules(module_body)
        for private_name, private_params in private_modules:
            print(f"  私有模块: {private_name}")
            for param_name, param_value in private_params.items():
                resolved_value = resolve_param_value(param_name, param_value, resolved_params, parent_params)
                print(f"    参数: {param_name} = {resolved_value}")
        
        # 等待用户按回车键继续解析下一个模块
        input("按回车键继续解析下一个模块...")

        # 提取当前模块的实例化
        instances = extract_instance_params(module_body)
        for sub_module, sub_instance, sub_params in instances:
            # 用实例化时的参数覆盖模块的默认参数
            sub_parent_params = resolved_params.copy()
            sub_parent_params.update(sub_params)
            queue.append((sub_module, sub_parent_params, sub_instance))

    return parsed_instances


def main(input_file, top_module):
    # 读取输入 Verilog 文件
    with open(input_file, 'r') as f:
        verilog_code = f.read()

    # 去除注释的代码
    verilog_code = remove_comments(verilog_code)

    # 提取模块定义
    modules = extract_module_definitions(verilog_code)

    if top_module not in modules:
        print(f"指定的顶层模块 {top_module} 不存在！")
        return

    print(f"使用指定的顶层模块: {top_module}")

    # 解析实例化参数
    resolved_instances = resolve_instance_params(top_module, modules)

    # 打印解析结果
    print("解析的实例化参数：")
    if not resolved_instances:
        print("未找到任何实例化模块。")
    for instance_name, params in resolved_instances.items():
        print(f"实例: {instance_name}")
        for param_name, param_value in params.items():
            print(f"  参数: {param_name} = {param_value}")
        print()


if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("用法: python script.py 输入文件 顶层模块")
    else:
        input_file = sys.argv[1]
        top_module = sys.argv[2]
        main(input_file, top_module)