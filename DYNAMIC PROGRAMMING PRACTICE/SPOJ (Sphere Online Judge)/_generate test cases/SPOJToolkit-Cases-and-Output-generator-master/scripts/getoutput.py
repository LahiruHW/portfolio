import sys
from sys import argv
import os
import subprocess

def main():
	filename = argv[1]
	problem = argv[2]
	subprocess.call(['g++','solutions/%s.cpp' % filename])
	for inp in os.listdir(problem):
		if(inp.split('.')[1] != 'in'):
			continue
		output = os.popen('./a.out < %s/%s' % (problem, inp))
		f = open('%s/%s.out' % (problem, inp.split('.')[0]), 'w')
		f.write(output.read())
		f.close()
	os.popen('rm -r a.out')

main()