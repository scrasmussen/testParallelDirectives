import sys
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from enum import Enum, auto

def getSymbol(num):
    if (num == 1):
        return 'o'
    elif (num == 2):
        return '.'
    elif (num == 3):
        return ','
    elif (num == 4):
        return 'x'
    elif (num == 5):
        return '+'
    elif (num == 6):
        return 'v'
    elif (num == 7):
        return '^'
    elif (num == 8):
        return '<'
    elif (num == 9):
        return '>'
    elif (num == 10):
        return 's'
    elif (num == 11):
        return 'd'
    return 'd'

class color(Enum):
    arraySyntax = auto()
    do_m = auto()
    doConcurrent1_m = auto()
    doConcurrent2_m = auto()
    ompParallelDo_m = auto()
    ompParallelLoop_m = auto()
    ompTarget_m = auto()
    ompTargetDataless_m = auto()
    ompTargetArraySyntax_m = auto()
    ompWorkshare_m = auto()

color_map = plt.get_cmap("tab20").colors

compiler_e=['cray_c','gnu_c','intel_c','pgi_c']
problem_e = ['matsum','saxpy','matmult']
name_e = ['arraySyntax', 'do', 'doConcurrent1', 'doConcurrent2',
          'ompParallelDo', 'ompParallelLoop', 'ompTarget', 'ompTargetDataless',
          'ompTargetArraySyntax', 'ompWorkshare']


file = 'official/output.txt'
file = 'official/newRuns.txt'
data = pd.read_csv(file, sep=',')

print("ARTLESS: HACKING COLUMN NAMES, FIX LATER")
fix = list(data)
fix[3], fix[4] = fix[4], fix[3]
data.columns = fix



group_by_problem = False
for prob_name, problem in data.groupby('problem_enum'):
    if (not group_by_problem):
        break
    fig, ax = plt.subplots()
    ax.set_title(problem_e[prob_name])
    for name, group in problem.groupby('method_enum'):
        lw=5-4*name/len(color)
        lw=2
        # print(lw)

        ls=['-','--','-.',':'][name%4]

        group.plot(x=' n', y='time', kind='line', ax=ax, alpha=0.75,
                   label=name_e[name], color=color_map[name], linestyle=ls,
                   linewidth=lw, marker=getSymbol(name))



def set_and_run_plot(group_by):
    if (group_by == 'compiler_enum'):
        enum = compiler_e

    for prob_num, prob_data in data.groupby("problem_enum"):
        print("---",problem_e[prob_num],"---")

        fig, axs = plt.subplots(2, 2, sharex=True, sharey=True)
        plt.suptitle(problem_e[prob_num], fontsize=14)


        for group, q in prob_data.groupby(group_by):
            print("   ---",enum[group],"---")

            i = int(group/2); j =  group%2
            axs[i,j].set_title(enum[group])

            # ARTLESS: spilt into four windows
            axs[i,j].plot(q[' n'], q['time'])
            # group_data.plot(x=' n', y='time', kind='line', ax=ax, alpha=0.75,
            #            label=name_e[group], marker=getSymbol(group))
            # plt.show()

        plt.show()




choices = ['method_enum', 'problem_enum', 'compiler_enum']
set_and_run_plot(choices[2])


print('Fin')
sys.exit()


for prob_name, problem in data.groupby('method_enum'):


    fig, ax = plt.subplots()
    ax.set_title(problem_e[prob_name])
    for name, group in problem.groupby('method_enum'):
        lw=5-4*name/len(color)
        lw=2
        # print(lw)

        ls=['-','--','-.',':'][name%4]

        group.plot(x=' n', y='time', kind='line', ax=ax, alpha=0.75,
                   label=name_e[name], color=color_map[name], linestyle=ls,
                   linewidth=lw, marker=getSymbol(name))


plt.show()

print("FIN")
