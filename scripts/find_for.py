import re
import sys
from collections import defaultdict

# Verilog 保留关键字列表
VERILOG_KEYWORDS = {
    "module", "endmodule", "input", "output", "wire", "reg", "assign", "always",
    "if", "else", "for", "while", "case", "endcase", "begin", "end", "parameter",
    "localparam", "generate", "endgenerate", "function", "endfunction", "task", "endtask"
}


def find_for_loop_instantiations(verilog_code):
    """
    在 Verilog 文件中识别所有 `for` 循环内部的模块实例化。
    返回一个列表，包含每个实例化的模块名和实例名。
    """
    # 匹配 `generate` 块
    generate_pattern = re.compile(r'generate.*?endgenerate', re.S)
    for_loops = []
    
    # 提取所有 `generate ... endgenerate` 块
    for generate_block in generate_pattern.findall(verilog_code):
        # 匹配 `for` 循环内部的内容
        for_pattern = re.compile(r'for\s*\(.*?\).*?begin(.*?)end', re.S)
        for_loop_blocks = for_pattern.findall(generate_block)
        for_loops.extend(for_loop_blocks)

    # 提取 `for` 循环中的模块实例化
    instantiations = []
    instance_pattern = re.compile(
        r'\b([a-zA-Z_][a-zA-Z0-9_]*)'  # 匹配模块名
        r'(?:\s*#\s*\(.*?\))?\s+'      # 匹配参数化部分（可选）
        r'([a-zA-Z_][a-zA-Z0-9_]*)\s*\(',  # 匹配实例名和括号
        re.S
    )
    for loop in for_loops:
        instantiations.extend(instance_pattern.findall(loop))

    # 过滤掉 Verilog 保留关键字和生成块自动命名
    filtered_instantiations = [
        (module_name, instance_name)
        for module_name, instance_name in instantiations
        if module_name not in VERILOG_KEYWORDS and instance_name not in VERILOG_KEYWORDS
        and not module_name.startswith("genblk")  # 过滤生成块自动命名
    ]

    return filtered_instantiations


def main(input_file):
    # 读取输入 Verilog 文件
    with open(input_file, 'r') as f:
        verilog_code = f.read()

    # 查找所有 `for` 循环中的实例化
    instantiations = find_for_loop_instantiations(verilog_code)

    # 打印结果
    if instantiations:
        print("在 `for` 循环中找到的模块实例化：")
        for module_name, instance_name in instantiations:
            print(f"模块名: {module_name}, 实例名: {instance_name}")
    else:
        print("未在 `for` 循环中找到任何模块实例化。")


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("用法: python script.py 输入文件")
    else:
        input_file = sys.argv[1]
        main(input_file)