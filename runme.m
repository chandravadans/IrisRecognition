clc
clear
D=rdir('.\**\*.jpg');          % Recursive dir listiing
c0='_local';                   % for appending to file name
for i= 1:10                    % sample 10 images change it to length(D)
x=D(i).name;                   %takes the first file (including path name)
c1=x(1:length(x)-12);          % It is found that the last 12 chars of 'x' contains name of image 
                               %(8 chars for name of file one . and 3 chars for 'jpg') so c1 has path name
c2=x(length(x)-11:length(x)-4);% c2 has filename
c3=x(length(x)-3:length(x));   % c3 has '.jpg'
xx=cellstr(x);                 % for converting character array to string
xy=imread(char(xx));           % reading the image from the particular path
[local x y time]=localisation2(xy,0.2);% doing the localisation

cc=strcat(c1,c2,c0,c3)         % constructing the path & filename(including the extension _local

imwrite(local,cc)               % writing the localised image
end
%CAUTION There should be no images in current dir