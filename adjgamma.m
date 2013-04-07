% ADJGAMMA - Adjusts image gamma.
%
% function g = adjgamma(im, g)
%
% Arguments:
%            im     - image to be processed.
%            g      - image gamma value.
%                     Values in the range 0-1 enhance contrast of bright
%                     regions, values > 1 enhance contrast in dark
%                     regions. 
function newim = adjgamma(im, g)

    if g <= 0
	error('Gamma value must be > 0');
    end

    if isa(im,'uint8');
	newim = double(im);
    else 
	newim = im;
    end
    	
    newim =  newim.^(1/g);   % Apply gamma function


