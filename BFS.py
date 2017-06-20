import numpy
from numpy._distributor_init import NUMPY_MKL
import scipy.io as sio
import os

def arrange(items):
	for each in items:
		sorted(items)
	return items	

def BFS(start , end , data, path,way,count,offset):
	if count >100000:
		return []
	neighbours = [] 
	biggerways = []
	temp = 0
	for each in data:
		if (each[2] == start or each[3] == start )  
			if each[2] == start  : 
				neighbours.append(each[3])
				biggerways.append(each[5])
				
				cnt = 0
				tmp = [0,1]
				
			elif each[3] == start : 
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
			
	if end in path or end in way:
			return way		

	cnt = 0
	for each in neighbours:
		path1 = path 
		way1=way
		path1.append(each)
		ind = neighbours.index(each)
		way1.append(biggerways[ind])
	
		return BFS(each,end,data,path1,way1,count+1,offset)	
		cnt = cnt +1
	return way		
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
print len(intersections)
for each in intersections: 
	data = intersections
		


	res = (BFS(each[3],each[2],data,[each[3]],[each[5]],1,0))
	if not res == None:
		res = sorted(res)
		if res not in plots and len(res) > 3:
			plots.append(res)
			plot_num = plot_num + 1
			print res
	res = (BFS(each[2],each[3],data,[each[2]],[each[4]],1,0))
	if not res == None:
		res = sorted(res)
		if res not in plots and len(res) > 3:
			plots.append(res)
			plot_num = plot_num + 1
			print res
	res = (BFS(each[2],each[3],data,[each[2]],[each[4]],1,1))
	if not res == None:
		res = sorted(res)
		if res not in plots and len(res) > 3:
			plots.append(res)
			plot_num = plot_num + 1
			print res
	res = (BFS(each[3],each[2],data,[each[3]],[each[5]],1,1))
	if not res == None:
		res = sorted(res)
		if res not in plots and len(res) > 3:
			plots.append(res)
			plot_num = plot_num + 1
			print res						
	count = count +1 

sio.savemat('C:\Users\Safi syed\Desktop\map project graphics\ blocks',mdict={'arr': plots},appendmat=True, format = '5')
