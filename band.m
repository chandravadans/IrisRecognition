function [band]= band(image, x_iris, y_iris, r_iris, x_pupil, y_pupil, r_pupil)

x_iris = double(x_iris);
y_iris = double(y_iris);
r_iris = double(r_iris);

x_pupil = double(x_pupil);
y_pupil = double(y_pupil);
r_pupil = double(r_pupil);

ox = x_pupil - x_iris;
oy = y_pupil - y_iris;

if ox <= 0
    sgn = -1;
elseif ox > 0
    sgn = 1;
end

if ox==0 && oy > 0
    
    sgn = 1;
    
end

width= r_pupil:r_iris;
theta= 0:2*pi;
band=zeros(size(image,2),size(image,1));
band(width)=width.*theta;