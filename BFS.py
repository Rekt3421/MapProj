import numpy
from numpy._distributor_init import NUMPY_MKL
import scipy.io as sio
import os

def arrange(items):
	for each in items:
		sorted(items)
	return items	

def BFS(start , end , data, path,way,count):
	if count >100000:
		return []
	neighbours = [] 
	biggerways = []
	temp = 0
	for each in data:
		if (each[2] == start or each[3] == start )  and each[5] not in way  :
			if each[2] == start and each[3] : 
				neighbours.append(each[3])
				biggerways.append(each[5])
				
				cnt = 0
				tmp = [0,1]
				
			elif each[3] == start and each[2]  and each[4] not in way: 
				neighbours.append(each[2])
				biggerways.append(each[4])
				
				cnt = 0
				tmp = [0,1]
				
		temp = temp +1		
	if end in neighbours:
		path.append(end)
		ind = neighbours.index(end)
	
		way.append(biggerways[ind])
		
		return way
			


	cnt = 0
	for each in neighbours:
		path1 = path 
		way1=way
		path1.append(each)
		ind = neighbours.index(each)
		way1.append(biggerways[ind])
	
		return BFS(each,end,data,path1,way1,count+1)	
		cnt = cnt +1

plots = []

intersections = sio.loadmat('intersections.mat')

intersections = intersections.get('intersections')

count = 0
tmp = [0,1,2]
tmp[0] = 1
tmp[1] = 2
plot_num = 0
res = [0 ,0 ,0,0,0,0]
plots = []
for each in intersections:
	if not each[4] == each[5]: 
		
		data = intersections
		


		res = (BFS(each[3],each[2],data,[each[3]],[each[5]],1))
		if not res == None:
			res = sorted(res)
			if res not in plots :
				plots.append(res)
				plot_num = plot_num + 1
				print res
	count = count +1 

sio.savemat('C:\Users\Safi syed\Desktop\map project graphics\plots',mdict={'arr': plots},appendmat=True)
