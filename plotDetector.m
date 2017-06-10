%% load data into matlab
hold on
close all
clear all
load('cellarray_ways.mat', 'cellarray_ways');

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
  
 manual_ways_toshow=[1:319]
%% manual_ways_toshow=[63,80,74,97];
    if (sum(cell_num==manual_ways_toshow)==1)
        
        disp([num2str(cell_num) ,'_']);
        %following code is used to detect if the path(set of points) is a
        %relatively straight line
        [p,struct] = polyfit( Ways(cell_num,1:length(cellarray_ways{cell_num}),1) , Ways(cell_num,1:length(cellarray_ways{cell_num}),2) ,1)
        if(struct.df<9 )% .df is a measure of straightness (dont know/need the exact details)
            
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


%% making 2 point ways
    Way_2pt =[];
    for cell_num = 1:length(cellarray_ways)
        curWayLen = length(cellarray_ways{cell_num});
        for iter =  1:curWayLen
            if iter+1 <= curWayLen
                %starting point
                Way_2pt(end+1 ,1 ,1) = Ways(cell_num,iter,1);
                Way_2pt(end ,1 ,2) = Ways(cell_num,iter,2);
                %ending point
                Way_2pt(end , 2 , 1)= Ways(cell_num,iter+1,1);
                Way_2pt(end , 2 , 2)= Ways(cell_num,iter+1,2);
            end
        end


    end
count = 0;
for i=1:length(Way_2pt)
    x1 = [Way_2pt(i,1,1),Way_2pt(i,2,1)];
    y1 = [Way_2pt(i,1,2),Way_2pt(i,2,2)];
    
   
    
     p1 = polyfit(x1,y1,1);
    
    
    for j=1:length(Way_2pt)
        if(i~=-j  )    
            x2 = [Way_2pt(j,1,1),Way_2pt(j,2,1)];
            y2 = [Way_2pt(j,1,2),Way_2pt(j,2,2)];
           %% diff_tocmp= tocmp_way_end-tocmp_way_start;
            %%slope_in=diff_tocmp(2)/diff_tocmp(1);
           
            p2 = polyfit(x2,y2,1); 
        
            x_intersect = fzero(@(x) polyval(p2-p1,x),1);
            
            y_intersect = polyval(p1,x_intersect);
            
            if(x_intersect >=min(x2) && x_intersect >= min(x1) && x_intersect <=max(x2) && x_intersect <= max(x1) && y_intersect >= min(y2) && y_intersect >= min(y1) && y_intersect <= max(y2) && y_intersect <=max(y1) )
         
                plot(x_intersect,y_intersect,'r*')
                count=count+1;
                drawnow;
            end
       end
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%