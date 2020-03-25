clear vars
syms uInf1 uInf2 vInf1 vInf2 f om1 om2 om3

valueUInf1 = -1;
valueUInf2 = 2;

%%%% solve f using uInf1 and uInf2 %%%%%%
eqn1 = uInf1 == f*(om1/om3);
eqn2 = uInf2 == -f*(om3/om1);
%eqns = [, ];
%S = solve(eqns, [f], 'ReturnConditions', true);
%S.f
fu1 =  solve(eqn1, f);
fu2 =  solve(eqn2, f);
%solve(feqn, f)
%f2eqnu = f*f == fu1*fu2

%%%% solve f using vInf1 and vInf2 %%%%%%
eqn1 = vInf1 == f*(om2/om3);
eqn2 = vInf2 == -f*(om3/om2);
%eqns = [, ];
%S = solve(eqns, [f], 'ReturnConditions', true);
%S.f
fv1 = solve(eqn1, f);
fv2 = solve(eqn2, f);
%solve(feqn, f)
%f2eqnv = f*f == fv1*fv2)
%fu1 = subs(fu1, uInf1, valueUInf1)
%fu2 = subs(fu2, uInf2, valueUInf2)
f2eqnv = f*f == fv1*fv2
%result = solve(f2eqnu, f)
%subs(result, [uInf1, valueUInf1], [uInf2, valueUInf2])

