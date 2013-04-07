%function to cut a ring centered at C inner radius rl and outer radius rh,
%out from an image I
%INPUTS:
%1.I:Image to be processed
%2.C(x,y):Centre coordinates of the circumcircle
%Coordinate system :
%origin of coordinates is at the top left corner
%positive x axis points vertically down
%and positive y axis horizontally and to the right
%3.n:number of sides
%4.r:radius of circumcircle
%OUTPUT:
%O:Image with circle
function [O]=getring(I,C,rl,rh,n)
if nargin==4
    n=600;
end
theta=(2*pi)/n;% angle subtended at the centre by the sides
%orient one of the radii to lie along the y axis
%positive angle ic ccw
rows=size(I,1);
cols=size(I,2);
angle=0:theta:2*pi;
%to improve contrast and help in detection
for r=rl:rh
x=C(1)-r*sin(angle);%the negative sign occurs because of the particular choice of coordinate system
y=C(2)+r*cos(angle);
if any(x>=rows)|any(y>=cols)|any(x<=1)|any(y<=1)%if circle is out of bounds return image itself
    O=I;
    return
end
for i=1:n
O(round(x(i)),round(y(i)))=I(round(x(i)),round(y(i)));
end
end
