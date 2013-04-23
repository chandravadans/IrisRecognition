% normaliseiris - performs normalisation of the iris region by
% unwraping the circular region into a rectangular block of
% constant dimensions.
%
% Usage:
% [polar_array, polar_noise] = normaliseiris(image, x_iris, y_iris, r_iris,...
% x_pupil, y_pupil, r_pupil,image_filename, radpixels, angulardiv)
%
% Arguments:
% image                 - the input eye image to extract iris data from
% x_iris                - the x coordinate of the circle defining the iris
%                         boundary
% y_iris                - the y coordinate of the circle defining the iris
%                         boundary
% r_iris                - the radius of the circle defining the iris
%                         boundary
% x_pupil               - the x coordinate of the circle defining the pupil
%                         boundary
% y_pupil               - the y coordinate of the circle defining the pupil
%                         boundary
% r_pupil               - the radius of the circle defining the pupil
%                         boundary
% image_filename        - original filename of the input eye image
% radpixels             - radial resolution, defines vertical dimension of
%                         normalised representation
% angulardiv            - angular resolution, defines horizontal dimension
%                         of normalised representation

function [ring,polar_array] = normaliseiris(image, x_iris, y_iris, r_iris,...
    x_pupil, y_pupil, r_pupil,image_filename, radpixels, angulardiv)

orig=image;

[ring] = getring(orig,[round(x_pupil),round(y_pupil)],[round(x_iris),round(y_iris)],round(r_pupil),round(r_iris));

image=ring;

%Conversion to rectangle
angulardiv=angulardiv/2;
radiuspixels = radpixels + 2;
angledivisions = angulardiv-1;

r = 0:(radiuspixels-1);

%just the left wing
theta = 3*pi/4:(pi/2)/(angledivisions):5*pi/4;

x_iris = double(x_iris);
y_iris = double(y_iris);
r_iris = double(r_iris);

x_pupil = double(x_pupil);
y_pupil = double(y_pupil);
r_pupil = double(r_pupil);

% calculate displacement of pupil center from the iris center
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

r = double(r);
theta = double(theta);

a = ones(1,angledivisions+1)* (ox^2 + oy^2);

% need to do something for ox = 0
if ox == 0
    phi = pi/2;
else
    phi = atan(oy/ox);
end

b = sgn.*cos(pi - phi - theta);

% calculate radius around the iris as a function of the angle
r = (sqrt(a).*b) + ( sqrt( a.*(b.^2) - (a - (r_iris^2))));

r = r - r_pupil;

rmat = ones(1,radiuspixels)'*r;

rmat = rmat.* (ones(angledivisions+1,1)*[0:1/(radiuspixels-1):1])';
rmat = rmat + r_pupil;


% exclude values at the boundary of the pupil iris border, and the iris scelra border
% as these may not correspond to areas in the iris region and will introduce noise.
% ie don't take the outside rings as iris data.
rmat  = rmat(2:(radiuspixels-1), :);

% calculate cartesian location of each data point around the circular iris
% region
xcosmat = ones(radiuspixels-2,1)*cos(theta);
xsinmat = ones(radiuspixels-2,1)*sin(theta);

xo = rmat.*xcosmat;
yo = rmat.*xsinmat;

xo =double( x_pupil+xo);
yo =double( y_pupil-yo);

% extract intensity values into the normalised polar representation through
% interpolation
[x,y] = meshgrid(1:size(image,2),1:size(image,1));
x=double(x);
y=double(y);
image=double(image);
polar_array_left = interp2(x,y,image,xo,yo);

polar_array_left = double(polar_array_left)./255;

%just the right wing
theta = 7*pi/4:(pi/2)/(angledivisions):9*pi/4;

x_iris = double(x_iris);
y_iris = double(y_iris);
r_iris = double(r_iris);

x_pupil = double(x_pupil);
y_pupil = double(y_pupil);
r_pupil = double(r_pupil);

% calculate displacement of pupil center from the iris center
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

r = double(r);
theta = double(theta);

a = ones(1,angledivisions+1)* (ox^2 + oy^2);

% need to do something for ox = 0
if ox == 0
    phi = pi/2;
else
    phi = atan(oy/ox);
end
b = sgn.*cos(pi - phi - theta);

% calculate radius around the iris as a function of the angle
r = (sqrt(a).*b) + ( sqrt( a.*(b.^2) - (a - (r_iris^2))));

r = r - r_pupil;

rmat = ones(1,radiuspixels)'*r;

rmat = rmat.* (ones(angledivisions+1,1)*[0:1/(radiuspixels-1):1])';
rmat = rmat + r_pupil;

% exclude values at the boundary of the pupil iris border, and the iris scelra border
% as these may not correspond to areas in the iris region and will introduce noise.
% ie don't take the outside rings as iris data.
rmat  = rmat(2:(radiuspixels-1), :);

% calculate cartesian location of each data point around the circular iris
% region
xcosmat = ones(radiuspixels-2,1)*cos(theta);
xsinmat = ones(radiuspixels-2,1)*sin(theta);

xo = rmat.*xcosmat;
yo = rmat.*xsinmat;

xo =double( x_pupil+xo);
yo =double( y_pupil-yo);

% extract intensity values into the normalised polar representation through
% interpolation
[x,y] = meshgrid(1:size(image,2),1:size(image,1));
x=double(x);
y=double(y);
image=double(image);
polar_array_right = interp2(x,y,image,xo,yo);
polar_array_right = double(polar_array_right)./255;

%merge the left and right arrays
[polar_array]=[polar_array_left polar_array_right];



% start diagnostics, writing out eye image with rings overlayed
% get rid of outling points in order to write out the circular pattern
coords = find(xo > size(image,2));
xo(coords) = size(image,2);
coords = find(xo < 1);
xo(coords) = 1;

coords = find(yo > size(image,1));
yo(coords) = size(image,1);
coords = find(yo<1);
yo(coords) = 1;

xo = round(xo);
yo = round(yo);

xo = int32(xo);
yo = int32(yo);

end