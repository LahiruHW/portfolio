# Comparison script,
# Author : Mike He (https://github.com/AD1024)
import os
import time
from hashlib import md5
import random

def Compile(file_name, out_name):
    os.system(f'g++ {file_name} -o {out_name}')

def diff(a, b):
    name = random_name()
    os.system(f'diff -w -B {a} {b} >> {name}')
    result = open(f'{name}', 'r').read()
    os.system(f'rm {name}')
    return result

def run_program(program_name, input_file, output_file, show_time=False):
    print('-----------------------')
    start = time.time()
    os.system(f'./{program_name} < {input_file} >> {output_file}')
    diff = time.time() - start
    if show_time:
        print(f'{program_name} ran in {diff}ms')
    return output_file

def random_name():
    return f'{md5(str(random.random()).encode()).hexdigest()}.txt'

def main():
    std = input('Std source code: ')
    pgm = input('Dest source code: ')
    test_file = input('Test Cases file name prefix: ')
    case_tot = int(input('Number of test cases: '))

    Compile(std, 'std')
    Compile(pgm, 'tar')

    for i in range(1, case_tot + 1):
        std_out = run_program('std', f'{test_file}{i}.in', f'{random_name()}', True)
        target_out = run_program('tar', f'{test_file}{i}.in', f'{random_name()}', True)
        difference = diff(target_out, std_out)
        if len(difference):
            with open(f'Case #{i}_diff.txt', 'w') as f:
                f.write(difference)
            print(f'Difference found on Case #{i}')
        else:
            print(f'NO DIFF ON CASE #{i}')
        os.system(f'rm {std_out}')
        os.system(f'rm {target_out}')

if __name__ == "__main__":
    main()