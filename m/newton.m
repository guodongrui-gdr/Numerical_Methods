function p0=newton(p0,max1)
syms x;
f=cos(x);
for k=1:max1
    dy=diff(f,1);
    x=p0;
    p1=p0-eval(f)/eval(dy);
    p0=p1;
end