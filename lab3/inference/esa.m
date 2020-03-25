clear vars;
syms uinf1 uinf2 vinf1 vinf2 f A B C D u v
equation = uinf1*uinf2 + vinf1*vinf2 + f^4 == sqrt(uinf1^2 + vinf1^2 + f^2)*sqrt(uinf2^2 + vinf2^2 + f^2);
equation = subs(equation, uinf1, 0);
equation = subs(equation, vinf1, 3);
equation = subs(equation, uinf2, 5);
equation = subs(equation, vinf2, 5);
vast = solve([equation f>0], f, 'Real', true);
double(vast)

normeq = A*u + B*v + C*f == 0;

eq1 = subs(normeq, u, 0);
eq1 = subs(eq1, v, 3);

eq2 = subs(normeq, u, 5);
eq2 = subs(eq1, v, 5);

eq3 = subs(normeq, u, 10);
eq3 = subs(eq1, v, 7);

eq4 = subs(normeq, u, 15);
eq4 = subs(eq1, v, 9);

solve([eq1 eq2 eq3 eq4 f>0], B, 'Real', true, 'ReturnConditions', true)