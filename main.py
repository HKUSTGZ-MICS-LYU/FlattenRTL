import argparse, pathlib
import os, shutil

import flatten


def argparser():   #定义一个叫argparser的函数
    parser = argparse.ArgumentParser()  #赋值给parser一个ArgumentParser对象
    parser.add_argument('dir', type=str,   #添加一个参数dir，类型为字符串
                        help='The working directory.')   
    parser.add_argument('-f', '--filelist', type=str, default='filelist.f',  #添加一个参数top，类型为字符串，默认值为top
                        help='The filelist of design.')   
    parser.add_argument('-t', '--top', type=str, default='top',  #添加一个参数top，类型为字符串，默认值为top
                        help='The name of the top module.')  
    parser.add_argument('-o', '--output', type=str, default='flatten.v',   #添加一个参数output，类型为字符串，默认值为flatten.v
                        help='The output file containint the flattened module. Default = flatten.v')
    parser.add_argument('-ex','--exclude',type=str, default='',
                        help='The filelist of excluded files.' )
    parser.add_argument('-g', '--debug', default=False, action='store_true',   #添加一个参数debug，类型为布尔值，默认值为False
                        help='Enable debug mode.')
    return parser   #返回parser

def main():  #定义一个叫main的函数
    banner = """ Welcome to FlattenRTL! """  #定义一个字符串
    print(banner)  #打印字符串
    parser = argparser()   #赋值给parser一个argparser对象
    args = parser.parse_args()  # 调用parse_args方法，获取参数们

    directory = args.dir   #赋值给directory参数dir的值

    input_filelist = pathlib.Path(directory, args.filelist)   #赋值给input_file一个pathlib.Path对象
    output_file = pathlib.Path(directory, args.output)    #赋值给output_file一个pathlib.Path对象

    if os.path.exists(output_file):   #如果output_file存在
        os.remove(path=output_file)    #删除output_file
    
    with open(input_filelist, "r") as f:    #打开input_filelist文件
        files = f.readlines()
    
    design = ''    #定义一个字符串
    for item in files:
        with open(pathlib.Path(directory, item.strip()), "r") as f:    #打开文件
            content = f.read()
            design += content + '\n'
            
    exclude_module = set()
    if args.exclude != '':
        exclude_arr = args.exclude.split(',')
        for item in exclude_arr:
            exclude_module.add(item.strip())
    
    # all intermediate flattened results will be stored in directory/tmp 
    if args.debug:    #如果args.debug为真
        tmp_folder = pathlib.Path(directory, "tmp")    #赋值给tmp_folder一个pathlib.Path对象
        print(f'[INFO] Intermediate flattened files will be saved in {tmp_folder}')    #打印字符串

        if os.path.exists(tmp_folder):    #如果tmp_folder存在
            print(f'[INFO] Removing existing files in {tmp_folder}')   #打印字符串
            shutil.rmtree(tmp_folder)    #删除tmp_folder
        os.mkdir(tmp_folder)    #创建tmp_folder

    # flatten the preprocessed output file iteratively
    if design != '':          #如果design不为空
        tmp_idx = 0    #赋值给tmp_idx一个值                 
        tmp_flatten_design = design    #赋值给tmp_flatten_design一个design的值
        done = False    #赋值给done一个False
        while not done:    #当done不为真时
            if args.debug:    #如果args.debug为真
                tmp_output_file = pathlib.Path(tmp_folder, f'flatten_{tmp_idx}.v')    #赋值给tmp_output_file一个pathlib.Path对象
                print(f'[INFO] Writing intermediate flattened design in {tmp_output_file}')    #打印字符串
                with open(tmp_output_file, 'w') as f:   #打开tmp_output_file文件
                    f.write(tmp_flatten_design)    #写入文件内容
                tmp_idx += 1   #tmp_idx加1
            done, tmp_flatten_design = flatten.pyflattenverilog(    #赋值给done和tmp_flatten_design一个flatten.pyflattenverilog对象
                tmp_flatten_design, args.top, exclude_module    
            )
    
        # write to output file
        with open(output_file, "w") as f:    #打开output_file文件
            print(f'[INFO] Writing the final flattened design in {output_file}')    #打印字符串
            f.write(tmp_flatten_design)     #写入文件内容
    
        # format
        print(f'[INFO] Formating the flattened design in {output_file} using iStyle')    #打印字符串

if __name__ == "__main__":    #如果__name__等于__main__
    # 计算总时长
    import time    #导入time模块
    start = time.time()    #赋值给start一个time.time()的值
    main()    #执行main函数
    end = time.time()    #赋值给end一个time.time()的值
    print(f'[INFO] Total time: {end - start} seconds')    #打印字符串