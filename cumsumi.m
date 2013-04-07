function[t,out,x,xv,xgroup,svalue]=cumsumi(I)
 d=size(I);
 a=(d(1)/3)*(d(2)/10);              %a is the total number of cells
 k=0;l=0;
 for i=1:3:d(1)                     %horizontal direction, steps of 3
    for j=1:10:d(2)                 %vertical direction, steps of 10
        if(i+3<d(1) && j+10<d(2))   
           k=k+1;
           s(k,:,:)=I(i:i+2,j:j+9);
           x (k)=sum(sum(s(k,:,:)))/30;
        end
    end
 end
 for i=1:5:k
     if(i+4<k)
         l=l+1;
         xgroup(l)=sum(x(i:i+4))/5;
         xv(l,1:5)=x(i:i+4);
     end 
 end
 z=0;
 for i=1:l
     for j=1:5
         if(j==1) 
             m=0;
         else
            m=svalue(i,j-1);
         end
         z=z+1;
         svalue(i,j)=m+(xv(i,j)-xgroup(i));
     end
 end   
 for i=1:l
     [maxg,p]=max(svalue(i,1:5));
     [ming,q]=min(svalue(i,1:5));
     if(p>q) r=q;s=p; else r=p;s=q; end
     for j=1:5
         if(j>=r && j<=s)
            if(svalue(i,r)>=svalue(i,s))
                iriscode(i,j)=2;
            else
                iriscode(i,j)=1;
            end    
         
         else
            iriscode(i,j)=0;             
         end
     end
 end 
 b=1;
 i=1;
for j=1:5:l
   t(i,b:b+4)=iriscode(j,:);
   if(b+5>d(2)/10) i=i+1;b=1; end
    b=b+5;
end   
         out=s;
 
  