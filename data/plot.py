import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

# data = pd.read_csv('cray-general-no-opt.txt', sep=',')
data = pd.read_csv('tmp-cray2.txt', sep=',')
fig, ax = plt.subplots()

for name, group in data.groupby('method'):
    group.plot(x='n', y='time', kind='line', ax=ax, label=name)

plt.show()
# print(data)
