import os

# 指定目录路径
base_path = 'tests/regression/dma/'
# 文件列表路径
filelist_path = "tests/regression/dma/files.f"
# 输出文件路径
output_file_path = "tests/regression/dma/top.v"

# 读取file.f中的文件名
with open(filelist_path, "r") as file_list:
    filenames = file_list.read().splitlines()
print(filenames)
# 合并文件内容到top.v
with open(output_file_path, "w") as output_file:
    for filename in filenames:
        print("Processing this file {}".format(filename))
        # 构建每个文件的完整路径
        filepath = base_path + filename
        print("Current file path {}".format(filepath))
        with open(filepath, "r") as file:
            # 读取文件内容并写入top.v
            contents = file.read()
            output_file.write(contents + "\n\n")  # 在文件内容之间添加换行符以分隔
  