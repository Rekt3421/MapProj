import numpy
from numpy._distributor_init import NUMPY_MKL
import scipy.io as sio
import os

def arrange(items):
	for each in items:
		sorted(items)
	return items	

def BFS(start , end , data, path,way,count,offset,lat ,lon):
	if count >100000:
		return []
	neighbours = [] 
	biggerways = []
	coords = []
	temp = 0
	for each in data:
		if (each[5] == start or each[4] == start )  and each[4+offset] not in way and(abs(each[0] - lat) >0.0002 and abs(each[0] - lon) >0.0002 )  :
			if each[4] == start  : 
				neighbours.append(each[5])
				biggerways.append(each[5])
				x = (each[0],each[1])
				coords.append(x)
				cnt = 0
				tmp = [0,1]
				
			elif each[5] == start : 
				neighbours.append(each[4])
				biggerways.append(each[4])
				x = (each[0],each[1])
				coords.append(x)
				
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
		pos = coords[ind]
		x_pos = pos[0]
		y_pos = pos[1]
	
		return BFS(each,end,data,path1,way1,count+1,offset,x_pos,y_pos)	
		return BFS(each,end,data,path1,way1,count+1,abs(offset-1),x_pos,y_pos)	
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
		


	
	res = (BFS(each[4],each[5],data,[each[2]],[each[4]],1,0,0,0))
	if not res == None:
		res = sorted(res)
		if res not in plots and len(res) > 3:
			plots.append(res)
			plot_num = plot_num + 1
			print res
	
	res = (BFS(each[5],each[4],data,[each[5]],[each[5]],1,1,0,0))
	if not res == None:
		res = sorted(res)
		if res not in plots and len(res) > 3:
			plots.append(res)
			plot_num = plot_num + 1
			print res						
	count = count +1 

sio.savemat('C:\Users\Safi syed\Desktop\map project graphics\ blocks',mdict={'arr': plots},appendmat=True, format = '5')
