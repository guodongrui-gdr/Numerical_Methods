% bisect.m
function [c,err,yc]=bisect(f,a,b,delta,max1)%二分法
% 输入参数: f为原函数
%           a,b为根所在的区间
%           max1为最大迭代次数
% 输出参数: c为求解出来的根
%           err为c与真实根之间的误差
%           yc为f(c)
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
    if b-a<delta
        break
    end
end
c=(a+b)/2;
err=abs(b-a);
yc=feval(f,c);
