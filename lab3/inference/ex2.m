clear vars;
I = imread('rectangle.tif');
%imshow(I);
%[x,y] = scanpoints(I);
[f_value, wvecs, normal] = my_rectangle('par_lines1.dat', 'par_lines2.dat');
dot(wvecs(1,:), wvecs(2,:));