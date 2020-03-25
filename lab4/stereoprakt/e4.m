clear all
close all
addpath('/home/viljami/MATLAB2019A/projects/computerVision/lab1/siftDemoV4');

%read images
file1 = 's1r3c1.pgm';
file2 = 's1r3c3.pgm';

%extract keypoints
[I1,keys1,loc1] = sift(file1);
[I2, keys2, loc2] = sift(file2);

%link keys1 loc1 to matching keys2 loc2
[matches, ~] = match(file1, file2);

%construct matches indice arrays
im1Matches = [];
im2Matches = [];
for i=1:size(matches,2)
    if(matches(1,i) > 0)
        im1Matches = [im1Matches i];
        im2Matches = [im2Matches matches(1,i)];
    end
end
%extract y and x values
y1 = zeros(1,size(im1Matches,2));
y2 = zeros(1,size(im1Matches,2));
x1 = zeros(1,size(im1Matches,2));
x2 = zeros(1,size(im1Matches,2));

for i=1:size(im1Matches,2)
    y1(i) = loc1(im1Matches(i),1);
    y2(i) = loc2(im2Matches(i),1);
    x1(i) = loc1(im1Matches(i),2);
    x2(i) = loc2(im2Matches(i),2);
end
differences = abs(x1-x2).*8;
ydifferences = abs(y1-y2);
%extract difference values from reference image
refImage = imread('truedisp.row3.col3.pgm');
xIndices = round(x1);
yIndices = round(y1);
referenceDifferences = zeros(1, size(xIndices,2));
for i=1:size(xIndices,2)
    referenceDifferences(1,i) = refImage(yIndices(1,i), xIndices(1,i));
end


%plot comparison function
x = linspace(1,371,371);
figure;
hold on
plot(x, referenceDifferences);
plot(x, differences);
xlabel("Index of match");
ylabel("Difference value");
legend(["Reference image" "Keypoints"])
hold off

figure;
hold on
plot(x(1,1:350), ydifferences(1,1:350));
xlabel("Index of match");
ylabel("Rows difference");
hold off

%plot bar plot
% biases = abs(referenceDifferences-differences)/abs(differences);
% biases = round(biases);
% barData = zeros(1, max(biases))
% for i=1:size(biases,2)
%     if(biases(1,i) > 0)
%         barData(1,biases(1,i)) = barData(1,biases(1,i)) + 1; 
%     end
% end
% bar_values = [];
% bar_counts = [];
% for i=1:size(barData,2)
%     if(barData(1,i) > 0)
%         bar_values = [bar_values i];
%         bar_counts = [bar_counts barData(1,i)];
%     end
% end
% figure
% hold on
% bar(bar_values, bar_counts);
% hold off
