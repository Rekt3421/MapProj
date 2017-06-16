import numpy
from numpy._distributor_init import NUMPY_MKL
import scipy.io as sio



def BFS(start , end , data, path,count):
	if count >20:
		return []
	neighbours = [] 
	
	temp = 0
	for each in data:
		if (each[2] == start or each[3] == start )  :
			if each[2] == start and each[3] not in neighbours  and not each[1] == 1 : 
				neighbours.append(each[3])
				
				data[temp][1]=1
			elif each[3] == start and each[2] not in neighbours and not each[1] == 1: 
				neighbours.append(each[2])
				data[temp][1]=1
		temp = temp +1		
	if end in neighbours:
		path.append(end)
		
		return path			


	cnt = 0
	for each in neighbours:
		path1 = path 
		path1.append(each)
		print count
		BFS(each,end,data,path1,count+1)	
		cnt = cnt +1

plots = []

intersections = sio.loadmat('intersections.mat')

intersections = intersections.get('intersections')

count = 0

for each in intersections:
	if not each[2] == each[3]: 
		print "target = " , each[2]
		data = intersections
		data[count][1]=1
		res = BFS(each[2],each[3],data,[each[2]],1)

		print "RESULLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLT =====" , each[3]
		x=raw_input('Temp')
		print res 
	count = count +1 



