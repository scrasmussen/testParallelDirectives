import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

# data = np.genfromtxt('cray-general-no-opt.txt') #, ',')
data = pd.read_csv('cray-general-no-opt.txt', sep=',')

print(data)
