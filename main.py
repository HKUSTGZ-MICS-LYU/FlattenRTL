import argparse, pathlib
import os

import flatten
import preprocess

def argparser():
    parser = argparse.ArgumentParser()
    parser.add_argument('dir', type=str,
                        help='The working directory.')
    parser.add_argument('input', type=str,
                        help='The input file containing the top module')
    parser.add_argument('-t', '--top', type=str, default='top',
                        help='The name of the top module.')
    parser.add_argument('-o', '--output', type=str, default='flatten.v',
                        help='The output file containint the flattened module. Default = flatten.v')
    parser.add_argument('-g', '--debug', default=False, action='store_true',
                        help='Enable debug mode.')
    return parser

def main():
    banner = """ Welcome to FlattenRTL! """
    print(banner)
    parser = argparser()
    args = parser.parse_args()

    directory = args.dir

    input_file = pathlib.Path(directory, args.input)
    output_file = pathlib.Path(directory, args.output)

    if os.path.exists(output_file):
        os.remove(path=output_file)
    
    # preprocess input file and store it to output file
    with open(input_file, 'r') as f:
        design = f.read()
        preprocess.formatter_file(design, output_file)
    
    # all intermediate flattened results will be stored in directory/tmp 
    tmp_folder = pathlib.Path(directory, "tmp")
    print(f'[INFO] Intermediate flattened files will be saved in {tmp_folder}')

    if os.path.exists(tmp_folder):
        file_list = os.listdir(tmp_folder)
        print(f'[INFO] Removing existing files in {tmp_folder}')
        for filename in file_list:
            tmp_file_path = os.path.join(tmp_folder, filename)
            os.remove(tmp_file_path)
    else:
        os.mkdir(tmp_folder)

    # flatten the preprocessed output file iteratively
    with open(output_file, "r") as file:
        design = file.read()            
        tmp_idx = 0
        tmp_flatten_design = design
        while tmp_flatten_design != -1:
            tmp_output_file = pathlib.Path(tmp_folder, f'flatten_{tmp_idx}.v')
            if args.debug:
                tmp_idx += 1
            tmp_flatten_design = flatten.pyflattenverilog(
                tmp_flatten_design, args.top, str(tmp_output_file)
            )

if __name__ == "__main__":
    main()