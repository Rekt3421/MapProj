%% load data into matlab
hold on
clear all
load('cellarray_ways.mat', 'cellarray_ways');
blocks={};
blocks{1}=[76,77,69,70];
blocks{2}=[191,219,263,264];
blocks{3}=[191,219,264,265];
blocks{4}=[110,109,158,126];
blocks{5}=[130,131,133,135];
blocks{6}=[241,242,235,238];
blocks{7}=[191,219,262,263];
blocks{8}=[191,219,261,262];
blocks{9}=[141,142,252,155];
blocks{10}=[166,165,74,167];
blocks{11}=[166,97,165,167];
blocks{12}=[166,83,74,97];
blocks{13}=[63,83,74,97];
blocks{14}=[63,80,74,97];
num_of_blocks=size(blocks)

for iii=1:num_of_blocks(2)
%Ways = zeros(length(cellarray_ways),length(cellarray_ways{cell_num}),2);
%% find block
for cell_num = 1:length(cellarray_ways)
    for point_num = 1:length(cellarray_ways{cell_num})
        Ways(cell_num,point_num,1) = cellarray_ways{cell_num}{point_num}(1);
        Ways(cell_num,point_num,2) = cellarray_ways{cell_num}{point_num}(2);
    end
end


%% load data into matlab

load('cellarray_ways.mat', 'cellarray_ways');

%Ways = zeros(length(cellarray_ways),length(cellarray_ways{cell_num}),2);
%% find block
for cell_num = 1:length(cellarray_ways)
    for point_num = 1:length(cellarray_ways{cell_num})
        Ways(cell_num,point_num,1) = cellarray_ways{cell_num}{point_num}(1);
        Ways(cell_num,point_num,2) = cellarray_ways{cell_num}{point_num}(2);
    end
end



hold on
X={};
Y={};



    
for cell_num = 1:length(cellarray_ways)
    %plot(Ways(cell_num,:,1) , Ways(cell_num,:,2));
  
     manual_ways_toshow=blocks{iii};
  %%manual_ways_toshow=[1:319]
%% manual_ways_toshow=[63,80,74,97];
    if (sum(cell_num==manual_ways_toshow)==1)
        
        disp([num2str(cell_num) ,'_']);
        %following code is used to detect if the path(set of points) is a
        %relatively straight line
        [p,struct] = polyfit( Ways(cell_num,1:length(cellarray_ways{cell_num}),1) , Ways(cell_num,1:length(cellarray_ways{cell_num}),2) ,1)
        if(struct.df<8 )% .df is a measure of straightness (dont know/need the exact details)
            
            plot( Ways(cell_num,1:length(cellarray_ways{cell_num}),1) , Ways(cell_num,1:length(cellarray_ways{cell_num}),2) ,'g');
            X{end+1}= Ways(cell_num,1:length(cellarray_ways{cell_num}),1);
            Y{end+1}= Ways(cell_num,1:length(cellarray_ways{cell_num}),2);
        else
            %dont plot lines that arent straight
            disp('is not a st line')
        end
        % number the lines for easy marking of paths
        text(max(Ways(cell_num,1:length(cellarray_ways{cell_num}),1)),max(Ways(cell_num,1:length(cellarray_ways{cell_num}),2)),num2str(cell_num))
        disp('^');
    end
end





%% pick a way and get its neighbouring ways
way_end={};
way_start={};
diff={};
for i = 1:length( manual_ways_toshow)
    
    
    way_end{i}=[X{i}(1),Y{i}(1)];   
    way_start{i}=[X{i}(length(X{i})),Y{i}(length(Y{i}))];
    diff{i}=way_end{i}-way_start{i};
    slopes(i)=(diff{i}(2)/diff{i}(1));
end
slopes1=slopes;
slopes=abs(slopes);
one=min(slopes);
one=find(slopes==one);
slopes(one)=inf;

two=min(slopes);
two=find(slopes==two);
slopes(one)=-inf;
slopes(two)=-inf;

three=max(slopes);
three=find(slopes==three);
slopes(three)=-inf;

four=max(slopes);
four=find(slopes==four);

slopes=slopes1   
   
   
   
   
   
   
   
   
   
   
   x1=[way_start{one}(1), way_end{one}(1)];
   y1=[way_start{one}(2), way_end{one}(2)];
   
    p1 = polyfit(x1,y1,1);
    
   x2=[way_start{four}(1), way_end{four}(1)];
   y2=[way_start{four}(2), way_end{four}(2)];
   
    p2 = polyfit(x2,y2,1); 
drawnow;

x_intersect = fzero(@(x) polyval(p1-p2,x),3);
y_intersect = polyval(p1,x_intersect);

line(x1,y1);

line(x2,y2);
plot(x_intersect,y_intersect,'r*')
x_pts(1)=x_intersect;
y_pts(1)=y_intersect;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 x11=[way_start{one}(1), way_end{one}(1)];
   y11=[way_start{one}(2), way_end{one}(2)];
   
    p11 = polyfit(x11,y11,1);
    
   x21=[way_start{three}(1), way_end{three}(1)];
   y21=[way_start{three}(2), way_end{three}(2)];
   
    p21 = polyfit(x21,y21,1); 
%%drawnow;

x_intersect1 = fzero(@(x) polyval(p11-p21,x),3);
y_intersect1 = polyval(p11,x_intersect1);

line(x11,y11);

line(x21,y21);
plot(x_intersect1,y_intersect1,'r*')
x_pts(2)=x_intersect1;
y_pts(2)=y_intersect1;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 x1=[way_start{two}(1), way_end{two}(1)];
   y1=[way_start{two}(2), way_end{two}(2)];
   
    p1 = polyfit(x1,y1,1);
    
   x2=[way_start{four}(1), way_end{four}(1)];
   y2=[way_start{four}(2), way_end{four}(2)];
   
    p2 = polyfit(x2,y2,1); 
%%drawnow;

x_intersect = fzero(@(x) polyval(p1-p2,x),3);
y_intersect = polyval(p1,x_intersect);

line(x1,y1);

line(x2,y2);
plot(x_intersect,y_intersect,'r*')
x_pts(3)=x_intersect;
y_pts(3)=y_intersect;
drawnow;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x1=[way_start{two}(1), way_end{two}(1)];
   y1=[way_start{two}(2), way_end{two}(2)];
   
    p1 = polyfit(x1,y1,1);
    
   x2=[way_start{three}(1), way_end{three}(1)];
   y2=[way_start{three}(2), way_end{three}(2)];
   
    p2 = polyfit(x2,y2,1); 
%%drawnow;

x_intersect = fzero(@(x) polyval(p1-p2,x),3);
y_intersect = polyval(p1,x_intersect);

line(x1,y1);

line(x2,y2);
plot(x_intersect,y_intersect,'r*')

x_pts(4)=x_intersect;
y_pts(4)=y_intersect;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
drawnow;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%%Find the 2 base points and the 2 top points%%
 indexOf_top_point_1 = -1;
 indexOf_top_point_2 = -1;
if(y_pts(1)<y_pts(3) && (y_pts(2)<y_pts(4)) )
    
        
        indexOf_base_point1 = 1;
        indexOf_base_point2 = 2;
        indexOf_top_point_1 = 3;
        indexOf_top_point_2 = 4;
        
    
    
elseif(y_pts(1)<y_pts(4) && (y_pts(2)<y_pts(3)))
     
    
        indexOf_base_point1 = 1;
        indexOf_base_point2 = 2;
        indexOf_top_point_1 = 3;
        indexOf_top_point_2 = 4;
    
     
        
else        
        indexOf_base_point1 = 3;
        indexOf_base_point2 = 4;
        indexOf_top_point_1 = 1;
        indexOf_top_point_2 = 2;
    
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Find Mid of the 2 pts and iterate%%
mid_x_basepts= x_pts(indexOf_base_point1)*0.5 + x_pts(indexOf_base_point2)*0.5;

mid_y_basepts= y_pts(indexOf_base_point1)*0.5 + y_pts(indexOf_base_point2)*0.5;

mid_x_top_pts= x_pts(indexOf_top_point_1)*0.5 + x_pts(indexOf_top_point_2)*0.5;

mid_y_top_pts= y_pts(indexOf_top_point_1)*0.5 + y_pts(indexOf_top_point_2)*0.5;


x_pts(5) = mid_x_basepts;

y_pts(5) = mid_y_basepts;

x_pts(6) = mid_x_top_pts;

y_pts(6) = mid_y_top_pts;

perpendicular_to_base_X = [x_pts(5),x_pts(6)];

perpendicular_to_base_Y = [y_pts(5),y_pts(6)];

plot(x_pts(5) , y_pts(5) , 'X')

plot(x_pts(6) , y_pts(6) , 'X')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%For dividing plots%%%%%%%%%%%%%%%%
if(x_pts(indexOf_base_point1) < x_pts(indexOf_base_point2))
    left_base_pt_x = (x_pts(indexOf_base_point1));
   
    left_base_pt_y = (y_pts(indexOf_base_point1));
    
    right_base_pt_x = (x_pts(indexOf_base_point2));
   
    right_base_pt_y = (y_pts(indexOf_base_point2));
    
    
else
    left_base_pt_x = (x_pts(indexOf_base_point2));
   
    left_base_pt_y = (y_pts(indexOf_base_point2));
    
    right_base_pt_x = (x_pts(indexOf_base_point1));
   
    right_base_pt_y = (y_pts(indexOf_base_point1));
end


if(x_pts(indexOf_top_point_1) < x_pts(indexOf_top_point_2))
    left_top_pt_x = (x_pts(indexOf_top_point_1));
   
    left_top_pt_y = (y_pts(indexOf_top_point_1));
    
    right_top_pt_x = (x_pts(indexOf_top_point_2));
   
    right_top_pt_y = (y_pts(indexOf_top_point_2));
    
else
    left_top_pt_x = (x_pts(indexOf_top_point_2));
   
    left_top_pt_y = (y_pts(indexOf_top_point_2));
    
    right_top_pt_x = (x_pts(indexOf_top_point_1));
   
    right_top_pt_y = (y_pts(indexOf_top_point_1));
end
slope_1=(right_top_pt_y - right_base_pt_y)/(right_top_pt_x -right_base_pt_x );

slope_2=(left_top_pt_y - left_base_pt_y)/(left_top_pt_x - left_base_pt_x );

curr_X1 = right_top_pt_x;

curr_Y1 = right_top_pt_y;

curr_X2 = left_top_pt_x;

curr_Y2 = left_top_pt_y;

%% controls size of each slice%%
delta = 0.00005;
count_1=0;
count_2=0;
%%%%%%%%%%%%%%%%%%%%%%%
if (slope_1 < 0 && slope_2 > 0)
    curr_X1 = right_base_pt_x;
    curr_Y1 = right_base_pt_y;
    while(curr_Y2+ slope_2 * delta >left_base_pt_y && curr_Y1+slope_1 * delta>right_base_pt_y)

  
    curr_X1 = curr_X1 + delta;

    curr_X2 = curr_X2 + delta*-1;

    curr_Y2 = curr_Y2 + slope_2 * delta*-1;

    curr_Y1 = curr_Y1 + slope_1 * delta;


    x_points = [curr_X1 ,  curr_X2];

    y_points = [curr_Y1 ,  curr_Y2];

    plot(x_points,y_points);

    count_1=count_1+  1;
    end
end
if (slope_2 < 0 && slope_1 > 0)
   
    while(curr_Y2+ slope_2 * delta >left_base_pt_y && curr_Y1+slope_1 * delta>right_base_pt_y)

  
    curr_X1 = curr_X1 + delta*-1;

    curr_X2 = curr_X2 + delta;

    curr_Y2 = curr_Y2 + slope_2 * delta;

    curr_Y1 = curr_Y1 + slope_1 * delta*-1;


    x_points = [curr_X1 ,  curr_X2];

    y_points = [curr_Y1 ,  curr_Y2];

    plot(x_points,y_points);

    count_1=count_1+  1;
    end
    
    
end
while(curr_Y2+ slope_2 * delta >left_base_pt_y && curr_Y1+slope_1 * delta>right_base_pt_y)

  
curr_X1 = curr_X1 + delta;

curr_X2 = curr_X2 + delta;

curr_Y2 = curr_Y2 + slope_2 * delta;

curr_Y1 = curr_Y1 + slope_1 * delta;


x_points = [curr_X1 ,  curr_X2];

y_points = [curr_Y1 ,  curr_Y2];

plot(x_points,y_points);

count_1=count_1+  1;
end

end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%