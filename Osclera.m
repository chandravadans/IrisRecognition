function out=Osclera(b)
   b=double(b);
   p=numel(b);
%   q=size(b,2); %cols
%   r=size(b,3); %rgb values
    i=1:p-3
%       for j=1:q
          ssum=0.00;
%          for k=1:r
          ssum=ssum+b(p);
%          end
            minrgb=min(b(p),b(p+1),b(p+2));
            s=1-((3*minrgb)/ssum);
            if(s<=0.23)
              sc(p)=b(p);
%              sc(i,j,2)=b(i,j,2);
%              sc(i,j,3)=b(i,j,3);
            end
%       end
    out=sc;
end
   
   
    
           