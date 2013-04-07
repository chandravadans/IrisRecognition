function [dir_name,file_name]=pname(x)
%Given file name along with path name this fn will separate path name &
%file name
r=x;
s='';
while(isempty(r)~= 1)
    [s1,r]=strtok(r,'\');
    if(isempty(r)~=1)
    s=strcat(s,s1,'\');
    end
end
dir_name=s;
file_name=s1;