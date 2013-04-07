eye=imread('maranr1.bmp');
smallmatrix=zeros(8,8);
for i = 1:8
    for j=1:8
        smallmatrix(i,j)=eye(i,j);
    end
end
    
    