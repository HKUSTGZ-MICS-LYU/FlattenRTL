import argparse, pathlib
import os, shutil

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
    
    # preprocess the input file
    formatted_design = ''
    with open(input_file, 'r') as f:
        design = f.read()
        formatted_design = preprocess.format_file(design)
    
    # output the formatted design to file for debugging
    # formatted_file = pathlib.Path(directory, 'formatted.v')
    # print(f'[INFO] Writing the formatted design in {formatted_file}')
    # with open(formatted_file, 'w') as f:
    #     f.write(formatted_design)
    
    # all intermediate flattened results will be stored in directory/tmp 
    if args.debug:
        tmp_folder = pathlib.Path(directory, "tmp")
        print(f'[INFO] Intermediate flattened files will be saved in {tmp_folder}')

        if os.path.exists(tmp_folder):
            print(f'[INFO] Removing existing files in {tmp_folder}')
            shutil.rmtree(tmp_folder)
        os.mkdir(tmp_folder)

    # flatten the preprocessed output file iteratively
    if formatted_design != '':          
        tmp_idx = 0
        tmp_flatten_design = formatted_design
        done = False
        while not done:
            if args.debug:
                tmp_output_file = pathlib.Path(tmp_folder, f'flatten_{tmp_idx}.v')
                print(f'[INFO] Writing intermediate flattened design in {tmp_output_file}')
                with open(tmp_output_file, 'w') as f:
                    f.write(tmp_flatten_design)
                tmp_idx += 1
            done, tmp_flatten_design = flatten.pyflattenverilog(
                tmp_flatten_design, args.top
            )
    
        # write to output file
        with open(output_file, "w") as f:
            print(f'[INFO] Writing the final flattened design in {output_file}')
            f.write(tmp_flatten_design)
    
        # format
        print(f'[INFO] Formating the flattened design in {output_file} using iStyle')
        os.system("bin/iStyle -n --style=ansi " + str(output_file))

if __name__ == "__main__":
    main()