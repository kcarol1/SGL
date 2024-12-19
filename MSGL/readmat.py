import scipy.io as sio
import numpy as np

path = '/exp/home/luxi.xiao/project/Comparative_experiment/SGL/MSGL/MUUFL.mat'
mat_file = sio.loadmat(path)

keys = [key for key in mat_file.keys() if not key.startswith('__')]
print(keys)
print(keys[0])
print(mat_file[keys[0]]['ca'])
y_pre = mat_file[keys[0]]['y_pre'][0][0]
print(f'shape:{y_pre.shape}')
print(np.unique(y_pre))