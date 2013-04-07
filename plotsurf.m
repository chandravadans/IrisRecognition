eye=imread('kelvinl1.bmp');
bweye=rgb2gray(eye);
x=1:240;
y=1:320;
mesh(x,y,bweye);