import flatten
import preprocess
import os
import time
import psutil
import subprocess

start_time = time.time()
start_memory = psutil.Process(os.getpid()).memory_info().rss / (1024 * 1024)


# formatted part
# name = "b19"
# path = r'tests/regression/{name}/'.format(name=name)   
# inputfile = r'{name}.v'.format(name=name)   
# outputfile = r'f_{name}.v'.format(name=name)
# top_module = r'{name}'.format(name=name)

path = 'tests/regression/AES/AES-T1000/'
inputfile = 'top.v'
outputfile = 'f_top.v'
top_module = 'top'

inputpath = path+inputfile
formatpath = path+outputfile

if os.path.exists(formatpath):
   os.remove(path=formatpath)

# format the file
with open(path+inputfile, 'r') as f:
    design = f.read()
    preprocess.format_file(design, formatpath)
    # copy the file to formatpath
    # with open(formatpath, 'w') as f:
    #     f.write(design)



# flatten part
folder_path = os.path.dirname(formatpath)+'/tmp'
if os.path.exists(folder_path):
    file_list = os.listdir(folder_path)
    for filename in file_list:
        tmp_file_path = os.path.join(folder_path, filename)
        os.remove(tmp_file_path)
else:
    os.mkdir(folder_path)
tmp_output_path = os.path.dirname(formatpath)+'/tmp/'+formatpath.split('/')[-1]
debug_mode = True
with open(formatpath,"r") as file:
    design = file.read()
    tmp_flatten_design = flatten.pyflattenverilog(design, top_module, tmp_output_path, debug_mode)
    while True:
        if tmp_flatten_design != -1:
            tmp_flatten_design = flatten.pyflattenverilog(tmp_flatten_design, top_module, tmp_output_path, debug_mode)
        else:
            break

# 结束监测
end_memory = psutil.Process(os.getpid()).memory_info().rss / (1024 * 1024)
end_time = time.time()





# 执行eqv检查
# 路径到你的.fms文件
fms_file_path = 'tests/formality/verify.fms'


compare_path = path+'flatten_{outputfile}'.format(outputfile=outputfile)
# 读取.fms文件内容
with open(fms_file_path, 'r') as file:
    lines = file.readlines()

# 修改包含特定read_verilog行的路径
with open(fms_file_path, 'w') as file:
    for line in lines:
        if 'read_verilog -r' in line:
            # 替换为新的inputpath
            new_line = f"read_verilog -r {inputpath}\n"
            file.write(new_line)
        elif 'read_verilog -i' in line :
            # 替换为新的outputpath
            new_line = f"read_verilog -i {compare_path}\n"
            file.write(new_line)
        elif 'set_top' in line:
            # 替换为新的top_module
            new_line = f"set_top {top_module}\n"
            file.write(new_line)
        else:
            file.write(line)

formality_command = ['fm_shell', '-f', fms_file_path]

# 运行命令
try:
    result = subprocess.run(formality_command, check=True, text=True, capture_output=True)
    print("命令执行成功！")
    print("标准输出：", result.stdout)
except subprocess.CalledProcessError as e:
    print("命令执行失败：", e)

# 计算并打印结果
print(f"执行时间：{end_time - start_time}秒")
print(f"内存使用增加：{end_memory - start_memory} MB")