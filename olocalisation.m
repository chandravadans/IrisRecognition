function [ out xc yc time ] = olocalisation( img,scale )
%UNTITLED Vectorised version of localisation2, which localises the iris of
%an eye
%   Detailed explanation goes here
tic;
x=0;
y=0;
scalewin=50*scale
xmin=255*scalewin;
%b=rgb2gray(img);
b=imresize(img,scale);
b=double(b);
p=size(b,1);        %p's max value is 240
q=size(b,2);        %q's max value is 320
i=2:p-1;
j=1:q-scalewin;
[I J]=meshgrid(i,j);
%for i=2:p-1
%   for j=1:q-scalewin
      ssum=sum(b(I,J:J+scalewin));
      if(xmin>ssum)
        xmin=ssum;
        x=i;
     end
%   end
%    end
ymin=255*scalewin;

ssum=0;
for i=2:q-1
      for j=2:p-scalewin
       ssum=sum(b(j:j+scalewin,i));
      if(ssum<ymin)
         ymin=ssum;
         y=i;
      end
   end
 end
%m=1;n=1;

%error checking start
x=round((x * (1/scale)));
y=round((y * (1/scale)));
disp x;
disp y;
xc=x ;
yc=y ;

%b=rgb2gray(img);
b=(img);
p=size(b,1);        %p's max value is 240
q=size(b,2);        %q's max value is 320

if(x+75>p)
    ux=p;
else
    ux=x+75;
end

if(y+75>q)
    uy=q;
else
    uy=y+75;
end
if(x-75<0)
    lx=1;
else
    lx=abs(x-75);
end
if(y-75<0)
    ly=1;
else
    ly=abs(y-75);
end
%error check end   
if uy<ly
    temp=uy;
    uy=ly;
    ly=temp;
end

if ux<lx
    temp=ux;
    ux=lx;
    lx=temp;
end  
  

c=b(lx:ux,ly:uy); 
out=c;
time=toc;



end

