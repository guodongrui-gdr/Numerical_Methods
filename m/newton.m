% newton.m
function [p,err,k,y]=newton(f,p0,delta,epsilon,max1,M)% M重根情况下的牛顿迭代法
%输入参数:   f为原函数
%           p0为初始值
%           delta为p的最大允许误差
%           epsilon为函数值f(p)的最大允许误差
%           max1为最大迭代次数
%           M为根的阶数
%输出参数:  p为迭代序列
%           err为p的实际误差
%           k为迭代次数
%           y为f(p)
syms x;
g=f(x);
df=matlabFunction(diff(g,1));
for k=1:max1
    if feval(df,p0)==0
        disp(p0);
        break;
    end
    p1=p0-M*feval(f,p0)/feval(df,p0);
    err(k)=abs(p0-p1);
    relerr=2*err/(abs(p1)+delta);%相对误差
    p(k)=p1;
    p0=p1;
    y(k)=feval(f,p0);
    if(err(k)<delta)|(relerr<delta)|(abs(y(k))<epsilon)
        break;
    end
end