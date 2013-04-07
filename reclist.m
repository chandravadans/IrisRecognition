function [dlist] = reclist (directory)
%dlist=zeros(1024);
d=dir(directory);
for i=3:size(d,1)
    if isdir(d(i).name)
        reclist(d(i).name)
    end
    dlist(i)=d(i).name;
end