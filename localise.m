function [ilocal,c1x,c1y]=localise(img);
gray=rgb2gray(img);
cx=0; cy=0;
maxy=size(gray,1);
maxx=size(gray,2);
[xsum,cy]=min(sum(gray(2:maxy-2,:)));
[ysum,cx]=min(sum(gray(:,2:maxx-2)));

if(cx+75>maxx)
    ux=maxx;
else
    ux=cx+75;
end

if(cy+75>maxy)
    uy=maxy;
else
    uy=cy+75;
end
if(cx-70<0)
    lx=1;
else
    lx=abs(cx-75);
end
if(cy-70<0)
    ly=1;
else
    ly=abs(cy-75);
end
c1x=abs(cx);c1y=abs(cy);
ilocal=gray(ly:uy,lx:ux);
end