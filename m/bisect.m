function c=bisect(f,a,b,max1)
ya=feval(f,a);
yb=feval(f,b);
if ya*yb>0
    disp("区间错误");
    return;
end
for k=1:max1
    
    c=(a+b)/2;
    yc=feval(f,c);
    if yc==0
        a=c;
        b=c;
    elseif yb*yc<0
        a=c;
        ya=yc;
    elseif ya*yc<0
        b=c;
        yb=yc;
    end
end

