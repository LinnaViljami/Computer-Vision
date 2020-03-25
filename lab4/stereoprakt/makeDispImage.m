function distImage = makeDispImage(file_left,file_right, n, max_xshift, max_yshift)
% n= window size


%read images
I1 = rgb2gray(imread(file_right));
I2 = rgb2gray(imread(file_left));

%blurr images
I1 = imgaussfilt(I1);
I2 = imgaussfilt(I2);


s1 = size(I2,1);
s2 = size(I2,2);

%add zero padding

distImage = zeros(s1,s2);
distanceMultiplier = 8;
%for every window position
for j=1:s1-n
    for i=1:s2-n
        %extract window from left and corresponding row from right image
        %max_shift = i + 80;
        %if(max_shift > s2)
        %    max_shift = s2;
        %end
        window = I1(j:j+n-1,i:i+n-1);
        rowMinJ = max([j-max_yshift j]);
        rowMaxJ = min([j+n-1+max_yshift s1]);
        rowMinI = max([i-max_xshift i]);
        rowMaxI = min([i+n-1+max_xshift s2]);
        rows = I2(rowMinJ:rowMaxJ,rowMinI:rowMaxI);
        
        
        %differences = zeros(size(rows,2)-n, 1);
        %shift reference window
        %for(i2=1:size(rows,2)-n)
        %    refWindow = rows(:,i2:i2+n-1);
            
            %calculate differences
        %    difference = sum(abs(refWindow-window), 'all');
        %    differences(i2,1) = difference;
        %end
        
        %[miny, minx] = find(differences==min(differences));;
        %calculate normalized correlation
        c = normxcorr2(window,rows);
        %find max value
        [ypeak, xpeak] = find(c==max(c(:)));
        %disp(ypeak(1,1)-n);
        difference = xpeak(1,1)-n;
        
        
        %calculate difference value
        %disp(xpeak(1,1)-n);
        %yoffSet = ypeak(1,1)-1;
        %xoffSet = xpeak(1,1)-1;
        
        diffValue = difference*distanceMultiplier;
        %fprintf('Esa %d.2f \n', diffValue);
        %disp(diffValue);
        %disp(distImage(j,i));
        distImage(j+floor(n/2),i+floor(n/2)) = diffValue;
    end
end

end

