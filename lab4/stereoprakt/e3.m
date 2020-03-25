clear vars
close all


%read images
file1 = 'scene1.row3.col1.ppm';
file2 = 'scene1.row3.col3.ppm';
refImage = imread('truedisp.row3.col3.pgm');
refImage = double(refImage);

n_values = [5,7,9,12,15,19,23,25];
difference_to_reference = zeros(1, size(n_values, 2));
for i=1:size(n_values,2)
    
    I = makeDispImage(file1,file2, n_values(1,i),28,28);
    I(I>255) = 255;
    difference_to_reference(1,i) = sum(abs(double(I)-refImage), 'all');
    
    outputImage = join(["e3N" int2str(n_values(1,i)) ".png"], "");
    imwrite(I/255,outputImage);
end

difference_to_reference;