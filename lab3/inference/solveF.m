function f_value = solveF(p1x,p1y, p2x, p2y, p3x, p3y, p4x, p4y)
% return camera f, inputparameters: square corners clockwise
[uinf1, vinf1] = getIntersection(p1x, p2x, p1y, p2y, p4x, p3x, p4y, p3y);
[uinf2, vinf2] = getIntersection(p2x, p3x, p2y, p3y, p1x, p4x, p1y, p4y);
syms f;
equf1 = f*f == -1*uinf1*uinf2;
equf2 = f*f == -1*vinf1*vinf2;
solve(equf1, f)
solve(equf2, f)

f_value = 0;

end

