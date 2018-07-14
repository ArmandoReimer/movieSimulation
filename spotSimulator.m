function [fluoTrue,fluoMeas] = spotSimulator

    R = 6; %radius of the generated spot in pixels
    numPixels = 30;
    meanAmp = 5; %our spot can peak out here 
    meanbg = 2;  %the background will fluctuate around this value
    %add some noise to the previous two values
    bg = meanbg + randn(numPixels, numPixels, numPixels);
    amp = meanAmp + (meanAmp/2)*randn;
    
    %generate the coordinates for our future spot
    x = linspace(-R, R, numPixels);
    y = linspace(-R, R, numPixels);
    z = linspace(-R, R, numPixels);
    [X,Y,Z] = meshgrid(x, y, z);
  
    %generate the image
    spot = amp.*exp(-(X.^2 + Y.^2 + Z.^2));    
    im = spot + bg;
    
    %display the image (max z-projected with peak height and color corresponding to intensity)
    proj = max(im, [], 3);
    surf(x, y, proj)
    
    %generate some preliminary properties of the spot to get a feel for how
    %well we can reconstruct the spot in post-processing
    
    fluoTrue = sum(spot(:));
    fluoMeas = sum(im(:));
       
end


