function [p,err,k,y]=secant(f,p0,p1,delta,epsilon,max1)% 割线法
%输入参数:  f为输入函数
%           p0,p1为两个初始点
%           delta为p的最大允许误差
%           epsilon为函数值f(p)的最大允许误差
%           max1为最大迭代次数
%输出参数:  p为迭代序列
%           err为p的实际误差
%           k为迭代次数
%           y为f(p)
for k=1:max1
    p(k)=p1-feval(f,p1)*(p1-p0)/(feval(f,p1)-feval(f,p0));
    err(k)=abs(p(k)-p1);
    relerr=2*err/(abs(p1)+delta);%相对误差
    p0=p1;
    p1=p(k);
    y(k)=feval(f,p1);
    if(err(k)<delta)|(relerr<delta)|(abs(y(k))<epsilon)
        break;
    end
end