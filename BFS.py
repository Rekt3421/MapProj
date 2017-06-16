import numpy
from numpy._distributor_init import NUMPY_MKL
import scipy.io as sio



def BFS(start , end , data, path):
		

intersections = sio.loadmat('intersections.mat')

intersections = intersections.get('intersections')


for each in intersections:
	print "Start = " , each[2], " End = ", each[3]



