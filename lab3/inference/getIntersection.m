function [x, y] = getIntersection(l1x1, l1x2, l1y1,l1y2, l2x1, l2x2, l2y1, l2y2)
    x = 0;
    p1 = [0];
    x1  = [l1x1 l1x2];  
    y1  = [l1y1 l1y2];
    x2 = [l2x1 l2x2];
    y2 = [l2y1 l2y2];
    if(l1x1 == l1x2 && l2x1 == l2x2)
        error('Lines not intersect, z=0');
    elseif(l1y1 == l1y2 && l2y1 == l2y2)
        error('Lines not intersect, z=0');
    elseif(l1x1 == l1x2)
        x = l1x1;
        fprintf('l1x1=l1x2, x = %.2f \n', x);
    elseif(l2x1 == l2x2)
        x = l2x1;
        fprintf('l2x1=l2x2, x = %.2f \n', x);
    else
        

        %fit linear polynomial
        p1 = polyfit(x1,y1,1);
        p2 = polyfit(x2,y2,1);
        %calculate intersection
        x = fzero(@(x) polyval(p1-p2,x),3);
        fprintf('x = %.2f', x);
    end
    
    if(l1y1 == l1y2)
        y = l1y1;
        fprintf('l1y1=l1y2, y = %.2f \n', y);
    elseif(l2y1 == l2y2)
        y = l2y1;
        fprintf('l2y1=l2y2, y = %.2f \n', y);
    else
        p1 = polyfit(x1,y1,1);
        y = polyval(p1,x);
        fprintf('y = %.2f \n', y);
    end

end

