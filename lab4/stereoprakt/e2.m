clear vars
close all


%read images
file1 = 'scene1.row3.col1.ppm';
file2 = 'scene1.row3.col3.ppm';
I = makeDispImage(file1,file2, 7,28,28);
I(I>255) = 255;
imwrite(I/255,'e2N7.png');

