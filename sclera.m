function [out t]=sclera(b)
   b=double(b);
   p=size(b,1); %rows
   q=size(b,2); %cols
   tic
   sc=zeros(p,q);
   for i=1:p-1
       for j=1:q
          ssum=0.00;
          for k=1:3
              ssum=ssum+b(i,j,k);
          end
            minrgb=min(b(i,j,1:3));
            s=1-((3*minrgb)/ssum);
            if(s<=0.08)
              sc(i,j,1)=b(i,j,1);
              sc(i,j,2)=b(i,j,2);
              sc(i,j,3)=b(i,j,3);
            end
       end
   end
    out=sc;
    f=toc;
    t=f;
end
   
   
    
           