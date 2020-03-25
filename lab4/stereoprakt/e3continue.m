clear all;

refImage = imread('truedisp.row3.col3.pgm');
n_values = [5,7,9,12,15,19,23,25];
difference_to_reference = zeros(1, size(n_values, 2));
for i=1:size(n_values,2)
    
    disp(i)
    compImage = imread(join(["e3N" int2str(n_values(1,i)) ".png"], ""));
    difference_to_reference(1,i) = sum(abs(compImage-refImage), 'all');
    
end
difference_to_reference(1,9) = sum(abs(randi([0,255],288,384)-double(refImage)), 'all');
difference_to_reference = rescale(difference_to_reference,0,1);
y = difference_to_reference(1, 1:8);
x= n_values;
figure
hold on
plot(x,y);
xlabel("Window size");
ylabel("Difference/random init");
