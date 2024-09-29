import argparse, pathlib
import os, shutil

import flatten


def argparser():  
    parser = argparse.ArgumentParser()  
    parser.add_argument('dir', type=str,   
                        help='The working directory.')   
    parser.add_argument('-f', '--filelist', type=str, default='filelist.f',  
                        help='The filelist of design.')   
    parser.add_argument('-t', '--top', type=str, default='top',  
                        help='The name of the top module.')  
    parser.add_argument('-o', '--output', type=str, default='flatten.v',  
                        help='The output file containint the flattened module. Default = flatten.v')
    parser.add_argument('-ex','--exclude',type=str, default='',
                        help='The filelist of excluded files.' )
    parser.add_argument('-g', '--debug', default=False, action='store_true',  
                        help='Enable debug mode.')
    return parser  

def main():  
    banner = """ Welcome to FlattenRTL! """ 
    print(banner) 
    parser = argparser()   
    args = parser.parse_args()  

    directory = args.dir 

    input_filelist = pathlib.Path(directory, args.filelist) 
    output_file = pathlib.Path(directory, args.output)  

    if os.path.exists(output_file):  
        os.remove(path=output_file) 
    
    with open(input_filelist, "r") as f:  
        files = f.readlines()
    
    design = ''  
    for item in files:
        with open(pathlib.Path(directory, item.strip()), "r") as f:  
            content = f.read()
            design += content + '\n'
            
    exclude_module = set()
    if args.exclude != '':
        exclude_arr = args.exclude.split(',')
        for item in exclude_arr:
            exclude_module.add(item.strip())
    
    # all intermediate flattened results will be stored in directory/tmp 
    if args.debug:  
        tmp_folder = pathlib.Path(directory, "tmp")  
        print(f'[INFO] Intermediate flattened files will be saved in {tmp_folder}')  

        if os.path.exists(tmp_folder):   
            print(f'[INFO] Removing existing files in {tmp_folder}')  
            shutil.rmtree(tmp_folder)   
        os.mkdir(tmp_folder)   

    # flatten the preprocessed output file iteratively
    if design != '':        
        tmp_idx = 0                 
        tmp_flatten_design = design    
        done = False    
        while not done:   
            if args.debug:  
                tmp_output_file = pathlib.Path(tmp_folder, f'flatten_{tmp_idx}.v')   
                print(f'[INFO] Writing intermediate flattened design in {tmp_output_file}')    
                with open(tmp_output_file, 'w') as f:   
                    f.write(tmp_flatten_design)   
                tmp_idx += 1   #tmp_idx加1
            done, tmp_flatten_design = flatten.pyflattenverilog(    
                tmp_flatten_design, args.top, exclude_module    
            )
    
        # write to output file
        with open(output_file, "w") as f:  
            print(f'[INFO] Writing the final flattened design in {output_file}')   
            f.write(tmp_flatten_design)     
    
        # format
        print(f'[INFO] Formating the flattened design in {output_file} using iStyle')  

if __name__ == "__main__":   
    # 计算总时长
    import time   
    start = time.time()   
    main()   
    end = time.time()  
    print(f'[INFO] Total time: {end - start} seconds')   