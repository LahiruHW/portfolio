'''
pass only 1 parameter - the folder name after manual deletes
otherwise pass the solutions c++ file and the folder to get wrong
test cases and delete automatically
eg -> python scripts/correct.py KNAPSACK (after manual deletes) OR
python <main.py>/<scripts/correct.py> knapsackdp KNAPSACK (where knapsackdp.cpp
in soltutions/ has a comment as the first line like this: // 2 4 7 18 27) where
2, 4, 7 so on are bad test cases.s
'''
from sys import argv
import os

solfile = argv[1]
if len(argv) > 2:
	folder = argv[2]
	f = open('solutions/%s.java' % solfile, "r") # THIS IS THE ONLY CHANGE FROM correct.py
	a = f.readline()[3:].split()
	for s in a:
	    if os.path.isfile(folder + "/" + s + ".in"):
	        os.remove(folder+"/"+s+".in");
	        if os.path.isfile(folder + "/" + s + ".out"):
	        	os.remove(folder+"/"+s+".out");
	f.close()
else:
	folder = solfile
# Below line will make the program till 2n, where n is the number of files and when it 
# checks, the file is named n.in and n.out. This allows manual deletion and renaming
n = len([name for name in os.listdir(folder) if os.path.isfile(os.path.join(folder, name))])
x = 1
y = n
i = 1
for j in range(1, n+1):
    if os.path.isfile(folder + "/" + str(j) + ".in"):
        os.rename(folder+"/"+str(j)+".in", folder+"/"+str(i)+".in")
        os.rename(folder+"/"+str(j)+".out", folder+"/"+str(i)+".out")
        i += 1