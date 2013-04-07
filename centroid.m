function [x y] =centroid(im);
[a b]=find(im)
[x y]=[mean(a) mean(b)]
