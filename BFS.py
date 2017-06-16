import numpy
from numpy._distributor_init import NUMPY_MKL
import scipy.io as sio


intersections = sio.loadmat('intersections.mat')

intersections= intersections.get('intersections')


print intersections[1]