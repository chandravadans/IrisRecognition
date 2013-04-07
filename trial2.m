%clc
%D=rdir('**\*.bmp');        % Recursive dir listiing
c0='_local';                   % for appending to file name
for i= 1:10                    % sample 10 images change it to length(D)
x=D(i).name;                   %takes the first file (including path name)
[d1,f1]=pname(x);              % splits the pathname & file name
[f1,extn]=strtok(f1,'.')       % Separates the filename & extension
xx=cellstr(x);                 % for converting character array to string
xy=imread(char(xx));           % reading the image from the particular path
[local x y time]=localisation2(xy,0.2);% doing the localisation

cc=strcat(d1,f1,c0,extn);       % constructing the path & filename(including the extension _local

imwrite(local,cc);              % writing the localised image
end
%CAUTION There should be no images in current dir