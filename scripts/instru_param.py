import re

def instrument_verilog_with_nested_generate(file_path, output_path):
    """
    对Verilog文件中的每个模块逐一插桩，支持嵌套的generate块和for循环。
    :param file_path: 输入的Verilog文件路径
    :param output_path: 输出的插桩后的Verilog文件路径
    """
    # 读取Verilog文件
    with open(file_path, 'r') as file:
        verilog_code = file.read()

    # 正则表达式
    module_pattern = re.compile(r'\bmodule\s+(\w+)\s*\(.*?\);(.*?)\bendmodule\b', re.S)  # 匹配模块及其范围
    param_pattern = re.compile(r'\b(localparam|parameter)\s+(\[[^\]]+\]\s+)?(\w+)\s*=\s*([^;]+);')  # 匹配parameter/localparam
    named_block_pattern = re.compile(r'begin\s*:\s*(\w+)(.*?)end\b', re.S)  # 匹配命名块
    for_generate_pattern = re.compile(r'for\s*\(.*?\)\s*begin\s*:\s*(\w+)(.*?)end', re.S)  # 匹配for循环生成块
    generate_block_pattern = re.compile(r'generate\s+(.*?)endgenerate', re.S)  # 匹配完整的generate块

    # 查找所有模块
    modules = module_pattern.finditer(verilog_code)
    instrumented_code = verilog_code  # 初始化插桩后的代码
    offset = 0  # 用于调整插桩代码后的位置偏移

    def parse_generate_block(block_code, parent_path=""):
        """
        递归解析generate块，生成层次化名称和参数列表。
        :param block_code: 当前块的代码
        :param parent_path: 上级块的路径（用于层次化命名）
        :return: 嵌套块的参数映射
        """
        block_param_map = {}

        # 处理命名块
        named_blocks = named_block_pattern.findall(block_code)
        for block_name, inner_code in named_blocks:
            # 生成当前块的完整路径
            full_path = f"{parent_path}.{block_name}" if parent_path else block_name
            # 提取当前块的参数
            params = [
                f"{full_path}.{param_name}"
                for _, _, param_name, _ in param_pattern.findall(inner_code)
            ]
            # 递归解析内部嵌套块
            nested_params = parse_generate_block(inner_code, full_path)
            # 合并当前块的参数和嵌套块的参数
            block_param_map[full_path] = params
            block_param_map.update(nested_params)

        # 处理for循环块
        for_blocks = for_generate_pattern.findall(block_code)
        for block_name, inner_code in for_blocks:
            # 生成当前块的完整路径
            full_path = f"{parent_path}.{block_name}" if parent_path else block_name
            # 提取当前块的参数
            params = [
                f"{full_path}.{param_name}"
                for _, _, param_name, _ in param_pattern.findall(inner_code)
            ]
            # 递归解析内部嵌套块
            nested_params = parse_generate_block(inner_code, full_path)
            # 合并当前块的参数和嵌套块的参数
            block_param_map[full_path] = params
            block_param_map.update(nested_params)

        return block_param_map

    # 遍历模块逐一处理
    for module in modules:
        module_name = module.group(1)  # 模块名称
        module_body = module.group(2)  # 模块内部代码
        module_start = module.start() + offset  # 考虑插桩后的偏移
        module_end = module.end() + offset

        # 提取模块内部的parameter和localparam
        params = param_pattern.findall(module_body)  # 提取parameter/localparam

        # 提取嵌套的generate块
        generate_blocks = generate_block_pattern.findall(module_body)
        block_param_map = {}
        for generate_block in generate_blocks:
            block_param_map.update(parse_generate_block(generate_block))

        # 构建插桩代码
        def parameter_print_code(module_name, param_list, block_param_map):
            """生成parameter和localparam的打印代码"""
            code = "\ninitial begin\n"
            code += f'    $display("Module: {module_name}");\n'  # 打印模块名
            for param_type, _, param_name, _ in param_list:
                # 检查参数是否属于某个私有块
                for block_path, block_params in block_param_map.items():
                    if param_name in block_params:
                        param_name = f"{block_path}.{param_name}"  # 使用层次化名称
                        break
                code += f'    $display("{param_type.capitalize()} {param_name} = %0d", {param_name});\n'
            # 打印嵌套块的参数
            for block_path, block_params in block_param_map.items():
                for param in block_params:
                    code += f'    $display("Localparam {param} = %0d", {param});\n'
            code += "end\n"
            return code

        # 生成当前模块的插桩代码
        instrument_code = parameter_print_code(module_name, params, block_param_map)

        # 在当前模块的endmodule前插入插桩代码
        instrumented_code = (
            instrumented_code[:module_end - len("endmodule;")] +
            instrument_code +
            instrumented_code[module_end - len("endmodule;"):]
        )

        # 更新偏移量
        offset += len(instrument_code)

    # 写入插桩后的代码
    with open(output_path, 'w') as file:
        file.write(instrumented_code)

    print(f"Instrumented Verilog file saved to {output_path}")


# 示例使用
input_verilog_file = "cva6_module.v"  # 输入文件
output_verilog_file = "cva6_instrumented.v"  # 输出文件

instrument_verilog_with_nested_generate(input_verilog_file, output_verilog_file)