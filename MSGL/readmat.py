import scipy.io as sio

path = '../../datasets/Trento/Trento-GT.mat'
mat_file = sio.loadmat(path)

keys = [key for key in mat_file.keys() if not key.startswith('__')]
print(keys[0])