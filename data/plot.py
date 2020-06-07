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

class problem_c(Enum):
    matsum  = 0
    saxpy   = auto()
    matmult = auto()

class compiler_c(Enum):
    cray  = 0
    gnu   = auto()
    intel = auto()
    pgi   = auto()

color_map = plt.get_cmap("tab20").colors

compiler_e=['cray_c','gnu_c','intel_c','pgi_c']
problem_e = ['matsum','saxpy','matmult']
name_e = ['arraySyntax', 'do', 'doConcurrent1', 'doConcurrent2',
          'ompParallelDo', 'ompParallelLoop', 'ompTarget', 'ompTargetDataless',
          'ompTargetArraySyntax', 'ompWorkshare']

linestyle_e = [(0, (5, 1)),'--','-.',':', # intrinsic
               (0, (5, 1)),'--','-.',':', # OpenMP
                   '--','-.']     # OpenMP Target


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



def set_and_run_plot():
    for prob_num, prob_data in data.groupby("problem_enum"):
        # if (prob_num == problem_c.matsum.value):
        #     continue
        print("---",problem_e[prob_num],"---")
        # return prob_data

        fig, axs = plt.subplots(2, 2, sharex=True, sharey=True)
        plt.suptitle(problem_e[prob_num], fontsize=14)
        plt.xscale("log")
        axes = plt.gca()
        # axes.set_ylim([0,0.05])
        axes.set_ylim([0,2])

        for compiler, c_data in prob_data.groupby("compiler_enum"):
            print("   ---",compiler_e[compiler],"---")
            i = int(compiler/2); j =  compiler%2
            axs[i,j].set_title(compiler_e[compiler])

            for method, m_data in c_data.groupby("method_enum"):
                print("      ---", name_e[method], method)

                lw=2

                m_data.plot(x=' n', y='time', ax=axs[i,j], alpha=0.75,
                            label=name_e[method],
                            color=color_map[method],
                            linestyle=linestyle_e[method], linewidth=lw)


            # plt.show()

        plt.show()





choices = ['method_enum', 'problem_enum', 'compiler_enum']
q = set_and_run_plot()

print("FIN")
