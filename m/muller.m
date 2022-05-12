function [p,k,y]=muller(f,p0,p1,p2,delta,epsilon,max1)
% 输入参数: f为原函数
%           p0,p1,p2为初始点
%           delta为p的最大允许误差
%           epsilon为函数值f(p)的最大允许误差
%           max1为最大迭代次数
% 输出参数: p为迭代序列
%           k为迭代次数
%           y为f(p)
P=[p0 p1 p2];
for k=1:max1
    F=feval(f,P);
    h0=P(1)-P(3);h1=P(2)-P(3);
    c=F(3);
    e0=F(1)-c;e1=F(2)-c;
    a=(e0*h1-e1*h0)/(h1*h0^2-h0*h1^2);
    b=(e1*h0^2-e0*h1^2)/(h1*h0^2-h0*h1^2);
    if(b>0)
        z=(-2*c)/(b+sqrt(b^2-4*a*c));
    elseif(b<0)
        z=(-2*c)/(b-sqrt(b^2-4*a*c));
    end
    p(k)=p2+z;
    x=find(max(abs(P-p(k))))
    P(max(abs(P-p(k))))=[];
    P=[P p(k)];
    err(k)=abs(z);
    relerr(k)=err(k)/(abs(P(3))+delta);
    y(k)=feval(f,P(3));
    if(err(k)<delta)|(relerr<delta)|(abs(y(k))<epsilon)
        break;
    end
end