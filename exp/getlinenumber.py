import os
file_path = "tests/regression/AES/AES-T1000/top1.v"
if os.path.exists(file_path):
    with open(file_path, 'r') as file:
        lines = file.readlines()
        count = sum(1 for line in lines if not (line.lstrip().startswith('*') or line.lstrip().startswith('/') or line.strip() == ''))
    print(f"The file has {count} lines that do not start with '*' or '/' and are not blank.")
else:
    print("File does not exist.")
