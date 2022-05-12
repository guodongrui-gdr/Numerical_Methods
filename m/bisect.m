% bisect.m
function [p,err,k,y]=bisect(f,a,b,delta,max1)%二分法
% 输入参数: f为原函数
%           a,b为根所在的区间
%           max1为最大迭代次数
% 输出参数: c为求解出来的根
%           err为c与真实根之间的误差
%           yc为f(c)
ya=feval(f,a);
yb=feval(f,b);
p=zeros(max1);
if ya*yb>0
    disp("区间错误");
    return;
end
for k=1:max1
    p(k)=(a+b)/2;
    y=feval(f,p(k));
    if y==0
        a=p(k);
        b=p(k);
    elseif yb*y<0
        a=p(k);
        ya=y;
    elseif ya*y<0
        b=p(k);
        yb=y;
    end
    if b-a<delta
        break
    end
end
err=abs(b-a);
p=p';