import flatten
import preprocess
import os
import time
import psutil

# 开始监测
start_time = time.time()
start_memory = psutil.Process(os.getpid()).memory_info().rss / (1024 * 1024)
# formatted part

path = 'tests/regression/AES'
inputfile = '/top.v'
outputfile = '/f_top.v'
top_module = 'top'
inputpath = path+inputfile
formatpath = path+outputfile

if os.path.exists(formatpath):
   os.remove(path=formatpath)
with open(path+inputfile, 'r') as f:
    design = f.read()
    preprocess.formatter_file(design, formatpath)
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

