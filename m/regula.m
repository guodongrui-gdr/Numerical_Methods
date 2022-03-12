function [c,err,yc]=regula(a,b,max1)
ya=f1(a);
yb=f1(b);
if ya*yb>0
    return;
end
for k=1:max1
    dx=yb*(b-a)/(yb-ya);
    c=b-dx;
    yc=f1(c);
    ac=c-a;
    if yc==0
       break;
    elseif yb*yc<0
        a=c;
        ya=yc;
    elseif ya*yc<0
        b=c;
        yb=yc;
    end
end
c;
err=abs(b-a)/2;
yc=f1(c);