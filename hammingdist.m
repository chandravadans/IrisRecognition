function [hd]=hammingdist(image1,image2)
%get total pixels in the images.
N=size(image1,1)*size(image1,2);
sum=0;
for i=1:size(image1,1)
    for j=1:size(image1,2)
        if image1(i,j)==image2(i,j)
            sum=sum+0;
        else
            sum=sum+1;
        end
    end
end
hd=sum/(2*N);
end

