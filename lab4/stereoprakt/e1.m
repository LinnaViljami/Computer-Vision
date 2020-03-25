clear vars
close all
%save image 1 points
I1 = imread('scene1.row3.col1.ppm');
imshow(I1);
hold on
[x1,y1] = getpts();
plot(x1,y1,'r*');
saveas(gcf,'e1image1.png');
hold off

%save image 2 points
I2 = imread('scene1.row3.col3.ppm');
imshow(I2);
hold on
[x2,y2] = getpts();
plot(x2,y2, 'r*');
saveas(gcf,'e1image2.png');
hold off

%calculate differences
manualdiffx = x1-x2;
%scale differences according to the method used constructing the reference image
manualdiffx = manualdiffx * 8;
%save differences to dat file
%save e1differences.dat x -ascii

%get actual differences from reference image
Iref = imread('truedisp.row3.col3.pgm');
imshow(Iref);
hold on
[xref,yref] = getpts();
plot(xref,yref, 'r*');
saveas(gcf,'e1imageref.png');
hold off

%pick nearest integer
xref = round(xref);
yref = round(yref);

realDifferences = zeros(size(xref,1), 1);
%pick pixel values
for i=1:size(xref,1)
    pixelX = xref(i,1);
    pixelY = yref(i,1);
    realDifferences(i,1) = I(pixelY, pixelX);
end

%compare results
biasValues = realDifferences - manualDiffx;
abs(biasValues)