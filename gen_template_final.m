function[t,x,xvgroup,xvv]=gen_template_final(I)
%function[t,x,xv,xgroup,svalue]=cumsumi(I)
 d=size(I);                     
 a=(d(1)/3)*(d(2)/10);
 k=0;l=0;
 
 for i=1:3:d(1)                         %i iterates over the rows in steps of 3.
    for j=1:10:d(2)                     %j iterates over cols in steps of 10
        if(i+3<d(1) && j+10<d(2))       %as long as there exists one more step, i.e, till you don't fall off the edge
           k=k+1;
           s(k,:,:)=I(i:i+2,j:j+9);     %s is a 3d matr, k is the indx num, next 2 are the cell.
           x(k)=mean(mean(s(k,:,:)));   %x(k)is the representative sum of cell no. k
        end
    end
 end
 
 %vertical grouping
 lv=0;
 xvgroup=zeros(300);
 for kv=1:d(1)/3
     lv=lv+1;
     for ver=kv:30:kv+290
         xvgroup(lv)=xvgroup(lv)+x(ver);
         if(ver==kv+120)
             p=kv:30:kv+120;
             xvv(lv,1:5)=x(p);
             lv=lv+1;
         end
     end
 end
 
             
         
     
 
 for i=1:5:k                            % make a group out of 5 cells. l denotes the total no of groups.
     if(i+4<k)
         l=l+1;
         xgroup(l)=sum(x(i:i+4))/5;     %xgroup(l) has the average of the 5 cells in group l.
         xv(l,1:5)=x(i:i+4);            %xv(l,1:5) has the rep values of each of the 5 cells of group l.
     end 
 end
 
 z=0;
 for i=1:l                              % i iterates over the groups
     for j=1:5                          % j iterates over each cell in the group
         if(j==1)                   
             m=0;                       %for the first cell, mean=0, ie S0=0
         else
            m=svalue(i,j-1);            %m is Si-1 in paper
         end
         z=z+1;
         svalue(i,j)=m+(xv(i,j)-xgroup(i)); %svalue(i,j) stores the cum sum of jth cell in ith group. Si=Si-1+(Xi-X|)
         
     end
 end
 %vert roooo%
 for i=1:lv                              % i iterates over the groups
     for j=1:5                          % j iterates over each cell in the group
         if(j==1)                   
             m=0;                       %for the first cell, mean=0, ie S0=0
         else
            m=svaluev(i,j-1);            %m is Si-1 in paper
         end
         z=z+1;
         svaluev(i,j)=m+(xv(i,j)-xgroup(i)); %svalue(i,j) stores the cum sum of jth cell in ith group. Si=Si-1+(Xi-X|)
         
     end
 end
 %vert ends
 
 
 for i=1:l                              % i iterates over the groups
     [maxg,p]=max(svalue(i,1:5));       % maxg is max value in group, p is its index
     [ming,q]=min(svalue(i,1:5));       % ming is min value in group, q is its index
     if(p>q) 
         r=q;s1=p;                       %adjust so that greater of p and q is assigned to s, and the other, to r.
     else
         r=p;s1=q; 
     end
     for j=1:5                          
         if(j>=r && j<=s1)
             prev=j-1;
             if prev==0
                 prev=1;
             end
            if(svalue(i,j)>=svalue(i,prev))  % cell is on upward slope. set iriscode to 2.
                iriscode(i,j)=255;
            else
                iriscode(i,j)=128;            %cell is on downward slope.set iriscode to 1.
            end    
         
         else
            iriscode(i,j)=0;                %cell is not between minidx and maxidx, set iriscode to 0.
         end
     end
 end 
 b=1;
 i=1;
for j=1:5:l                             %j is from 1 to no_of_groups, steps of 5
   t(i,b:b+4)=iriscode(j,:);            %t stores the iriscode  generated for each step.
   if(b+5>d(2)/10) 
       i=i+1;
       b=1; 
   end
    b=b+5;
end

%Do the same for vertical, after transposing the image





end
 
  