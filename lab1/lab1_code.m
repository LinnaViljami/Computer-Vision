close all
% ------ ROTATION --------

r_angles = [''; 'r10'; 'r20'; 'r30'; 'r40'; 'r50'; 'r60'; 'r70'; 'r80'; 'r90'; 'r180'; "r270"];
rotations = [0,10,20,30,40,50,60,70,80,90,180,270]
matches = [];
for i = 1:size(r_angles,1)
    filename = join(["book", r_angles(i,1), ".pgm"], "");
    matches = [matches, match('scene.pgm', filename)];
end
close all
figure
hold on
plot(rotations, matches);
xlabel("Rotation angle");
ylabel("Matches");


% ------ SHEARING --------

s_factor = [''; 's25'; 's50'; 's100'; 's200'; 's300'; "s400"];
shearings = [0,25,50,100,200,300,400];
matches = [];
for i = 1:size(s_factor,1)
    filename = join(["book", s_factor(i,1), ".pgm"], "");
    matches = [matches, match('scene.pgm', filename)];
end
close all
figure
hold on
plot(shearings, matches);
xlabel("Shearing (%)");
ylabel("Matches");


% -------- DETAILS COMPARED WITH OUTDOOR AND INDOOR SCENE -------
outdoor_scene = "street.png";
indoor_scene = "scene.png";
detail_index = ["1";"2";"3";"4";"5"];
class_labels = [1,1,1,1,1,2,2,2,2,2];
matches_indoor = [];
matches_outdoor = [];
keypoints_detected = [];
for i = 1:size(detail_index, 1)
    detail_filename = join(["detail", detail_index(i,1), ".png"], "");
    matches_indoor = [matches_indoor match(indoor_scene, detail_filename)];
    matches_outdoor = [matches_outdoor match(outdoor_scene, detail_filename)];
    [~,keys,~] = sift(detail_filename);
    keypoints_detected = [keypoints_detected size(keys,1)]
    
end

close all

% try to fit normal distributions and determine the threshold, results was
% not good because lack of data
mu1= mean(matches_indoor./keypoints_detected);
mu2= mean(matches_outdoor./keypoints_detected);
sigma1= std(matches_indoor./keypoints_detected);
sigma2= std(matches_outdoor./keypoints_detected);
dist1 =@(x) exp(-(x-mu1).^2 / (2*sigma1^2)) / sqrt(2*sigma1^2*pi);
dist2 =@(x) exp(-(x-mu2).^2 / (2*sigma2^2)) / sqrt(2*sigma2^2*pi);
threshold = fzero(@(x) dist1(x) - dist2(x), rand * (mu1 - mu2) + (mu1 + mu2))
x = [0:0.001:0.03];
y1 = normpdf(x, mu1, sigma1);
y2 = normpdf(x, mu2, sigma2);
figure
hold on
title('Threshold and normal distributions')
xlabel('Matches/keypoints')
plot(x,y1);
plot(x,y2);
xline(threshold);
legend("Indoor", "Outdoor", "Threshold");