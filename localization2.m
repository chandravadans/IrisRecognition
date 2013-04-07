function [out time]=localization2(img);
tic;
xmin=255*150;
r=size(img,3);
b=rgb2gray(img);   
b=double(b);
p=size(b,1);
q=size(b,2);
for i=2:p-1
   for j=1:q-150
      ssum=sum(b(i,j:j+150));
     if(xmin>ssum)
        xmin=ssum;
        x=i;
     end
   end
end
k=0;
ymin=255*150;
for i=2:q-1
       ssum=0;
   for j=2:p-150
       ssum=sum(b(j:j+150,i));
      if(ssum<ymin)
         ymin=ssum;
         y=i;
      end
   end
 end
m=1;n=1;
b=rgb2gray(img);
c=b(abs(x-60):abs(x+60),abs(y-60):abs(y+60));
out=c;
time=toc;