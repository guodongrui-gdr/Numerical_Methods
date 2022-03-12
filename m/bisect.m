function c=bisect(a,b,max1)
ya=f1(a);
yb=f1(b);
if ya*yb>0
    return;
end
for k=1:max1
    
    c=(a+b)/2;
    yc=f1(c);
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

