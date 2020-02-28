import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

file='official/output.txt'
data = pd.read_csv(file, sep=',')


# fig, ax = plt.subplots()
# for name, group in data.groupby('method'):
#     group.plot(x='n', y='time', kind='line', ax=ax, label=name)
# plt.show()



# print(data)
