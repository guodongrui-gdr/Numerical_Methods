function [c,err,yc]=bisect(a,b,delta)
ya=f1(a);
yb=f1(b);
if ya*yb>0
    return;
end
max1=1+round((log(b-a)-log(delta))/log(2));
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
    if b-a<delta,break,end
end
c=(a+b)/2;
err=abs(b-a);
yc=f1(c);