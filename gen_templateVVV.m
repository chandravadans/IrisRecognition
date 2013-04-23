function[thv,th,tv]=gen_templateVVV(I)
%function[t,x,xv,xgroup,svalue]=cumsumi(I)
%I=adapthisteq(I);
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
kk=0;
for kv=1:d(2)/10
    lv=lv+1;                                  %lv denotes group number
    kk=0;
    mm=0;
    for ver=kv:30:kv+870                      %there are total 928 cells to group,we have 100/3=33 rows and 300/10=30 columns so for every column 33/=6(approx.) groups
        if(ver==kv+kk+150)                    %kk is used to determine next group number after successive  5 cells visited. first group=x(1),x(31),x(51)...x(121).
            kk=kk+150;
            lv=lv+1;
            mm=0;
        end
        xvgroup(lv)=xvgroup(lv)+x(ver);       %xvgroup(lv) has the average of the 5 cells in group lv.
        mm=mm+1;
        xvv(lv,mm)=x(ver);                      %xvv(l,1:5) has the rep values of each of the 5 cells of group lv.
    end
end
xvgroup=xvgroup/5;
%vert grouping ends
%horizontal grouping
for i=1:5:k                            % make a group out of 5 cells. l denotes the total no of groups.
    if(i+4<k)
        l=l+1;
        xgroup(l)=sum(x(i:i+4))/5;     %xgroup(l) has the average of the 5 cells in group l.
        xv(l,1:5)=x(i:i+4);            %xv(l,1:5) has the rep values of each of the 5 cells of group l.
    end
end
%horizontal grouping ends
%Computing Si=Si-1+(Xi-X|) for horizontal
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
%Si=Si-1+(Xi-X|) for horizontal ENDS
%Computing Si=Si-1+(Xi-X|) for vertical
for i=1:lv                              % i iterates over the groups
    for j=1:5                          % j iterates over each cell in the group
        if(j==1)
            m=0;                       %for the first cell, mean=0, ie S0=0
        else
            m=svaluev(i,j-1);            %m is Si-1 in paper
        end
        z=z+1;
        svaluev(i,j)=m+(xvv(i,j)-xvgroup(i)); %svalue(i,j) stores the cum sum of jth cell in ith group. Si=Si-1+(Xi-X|)
        
    end
end
%Si=Si-1+(Xi-X|) for Vertical ENDS

%Generating irisode for horizontal
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
%Generating irisode for horizontal  ENDS

%Generating irisodeV for Vertical
for i=1:lv                              % i iterates over the groups
    [maxg,p]=max(svaluev(i,1:5));       % maxg is max value in group, p is its index
    [ming,q]=min(svaluev(i,1:5));       % ming is min value in group, q is its index
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
            if(svaluev(i,j)>=svaluev(i,prev))  % cell is on upward slope. set iriscodeV to 2.
                iriscodev(i,j)=255;
            else
                iriscodev(i,j)=128;            %cell is on downward slope.set iriscodeV to 1.
            end
            
        else
            iriscodev(i,j)=0;                %cell is not between minidx and maxidx, set iriscodeV to 0.
        end
    end
end
%Generating irisodeV for Vertical ENDS
b=1;
i=1;
for j=1:5:l                             %j is from 1 to no_of_groups, steps of 5
    th(i,b:b+4)=iriscode(j,:);            %t stores the iriscode  generated for each step.
    if(b+5>d(2)/10)
        i=i+1;
        b=1;
    end
    b=b+5;
end
b=1;
i=1;
%vert
for j=1:5:lv                             %j is from 1 to no_of_groups, steps of 5
    tv(i,b:b+4)=iriscodev(j,:);            %tv stores the iriscodeV  generated for each step.
    if(b+5>d(2)/10)
        i=i+1;
        b=1;
    end
    b=b+5;
end
%vert ends
ths=size(th);
tvs=size(tv);
for i=1:ths(1)
    for j=1:ths(2)
        thv(i,j)=th(i,j);                         %thv is the horizontal and vertical combined iris (vertical below horizontal)
    end
end
for p=1:tvs(1)
    i=i+1;
    for q=1:tvs(2)
        thv(i,q)=tv(p,q);
    end
end
end

