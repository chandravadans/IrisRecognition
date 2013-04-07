function [out time]=localization(img);
tic;
xmin=255;
b=rgb2gray(img);
b=double(b);
p=size(b,1);
q=size(b,2);
for i=2:p-1
       sum=0;
       for j=1:q
           sum=sum+b(i,j);
        end
     min=sum/p; 
     if(min<xmin)
        xmin=min;
        x=i;
     end
  end
ymin=255;
for i=1:q
       sum=0;
       for j=2:p-1
           sum=sum+b(j,i);
        end
     min=sum/q; 
     if(min<ymin)
        ymin=min;
        y=i;
     end
end
m=1;n=1;
b=rgb2gray(img);
c=b(x-60:x+60,y-60:y+60);
out=c;
time=toc;