import re
import sys
from collections import defaultdict, deque

# Verilog 保留关键字列表
VERILOG_KEYWORDS = {
    "module", "endmodule", "input", "output", "wire", "reg", "assign", "always",
    "if", "else", "for", "while", "case", "endcase", "begin", "end", "parameter",
    "localparam", "generate", "endgenerate", "function", "endfunction", "task", "endtask"
}

def find_instantiated_modules(module_code):
    """
    从模块代码中提取所有被实例化的模块名。
    支持普通实例化和参数化实例化（#(...) 格式）。
    """
    # 匹配实例化格式：
    # - module_name instance_name ( ... )
    # - module_name #(params) instance_name ( ... )
    instance_pattern = re.compile(
        r'\b([a-zA-Z_][a-zA-Z0-9_]*)'  # 匹配模块名
        r'(?:\s*#\s*\(.*?\))?\s+'      # 匹配参数化部分（可选）
        r'[a-zA-Z_][a-zA-Z0-9_]*\s*\(',  # 匹配实例名和括号
        re.S
    )
    # 提取所有可能的模块名
    matches = set(instance_pattern.findall(module_code))
    # 过滤掉 Verilog 保留关键字
    filtered_matches = {name for name in matches if name not in VERILOG_KEYWORDS}
    return filtered_matches


def extract_module_definitions(verilog_code):
    """
    从整个 Verilog 文件中提取所有模块定义。
    返回一个字典：{模块名: 模块代码字符串}。
    """
    # 匹配模块定义及其内容：module module_name ... endmodule
    module_pattern = re.compile(r'(module\s+([a-zA-Z_][a-zA-Z0-9_]*).*?endmodule)', re.S)
    modules = {}
    for match in module_pattern.finditer(verilog_code):
        full_module_text = match.group(1)
        module_name = match.group(2)
        modules[module_name] = full_module_text
    return modules


def build_dependency_graph(modules):
    """
    构建模块之间的依赖关系图。
    返回依赖图（字典形式）：{父模块: [子模块1, 子模块2, ...]}。
    """
    dependency_graph = defaultdict(list)

    for module_name, module_code in modules.items():
        # 找到当前模块实例化的所有子模块
        instantiated_modules = find_instantiated_modules(module_code)
        for sub_module in instantiated_modules:
            dependency_graph[module_name].append(sub_module)

    return dependency_graph


def resolve_dependencies(top_module, dependency_graph):
    """
    从顶层模块递归解析所有依赖的模块。
    返回一个包含所有相关模块的集合。
    """
    resolved = set()
    queue = deque([top_module])

    while queue:
        module = queue.popleft()
        if module not in resolved:
            resolved.add(module)
            # 将当前模块的所有子模块加入队列
            queue.extend(dependency_graph.get(module, []))

    return resolved


def filter_modules(verilog_code, top_module):
    """
    从 Verilog 文件中只保留与顶层模块相关的模块。
    """
    # 提取所有模块定义
    modules = extract_module_definitions(verilog_code)

    # 构建模块依赖图
    dependency_graph = build_dependency_graph(modules)

    # 打印模块依赖关系
    print("模块依赖关系:")
    for parent, children in dependency_graph.items():
        print(f"{parent} -> {', '.join(children) if children else '无子模块'}")

    # 解析从顶层模块开始的所有依赖模块
    relevant_modules = resolve_dependencies(top_module, dependency_graph)

    # 筛选相关的模块代码
    filtered_modules = []
    for module_name in relevant_modules:
        if module_name in modules:
            filtered_modules.append(modules[module_name])

    return "\n\n".join(filtered_modules)


def main(input_file, output_file, top_module):
    # 读取输入 Verilog 文件
    with open(input_file, 'r') as f:
        verilog_code = f.read()

    # 过滤未被顶层模块使用的模块
    filtered_verilog_code = filter_modules(verilog_code, top_module)

    # 写入输出 Verilog 文件
    with open(output_file, 'w') as f:
        f.write(filtered_verilog_code)

    print(f"处理完成，结果已保存到 {output_file}")


if __name__ == "__main__":
    if len(sys.argv) != 4:
        print("用法: python script.py 输入文件 输出文件 顶层模块名")
    else:
        input_file = sys.argv[1]
        output_file = sys.argv[2]
        top_module = sys.argv[3]
        main(input_file, output_file, top_module)