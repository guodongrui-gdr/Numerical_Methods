function [p0,err,k,y]=newton(f,df,p0,delta,epsilon,max1,M)%M重根情况下的牛顿迭代法
%输入参数:   f为原函数
%           df为f的一阶导函数
%           p0为初始值
%           delta为p的最大允许误差
%           epsilon为函数值f(p)的最大允许误差
%           max1为最大迭代次数
%           M为根的阶数
%输出参数:  p0为迭代结果
%           err为p0的实际误差
%           k为迭代次数
%           y为f(p0)
for k=1:max1
    p1=p0-M*feval(f,p0)/feval(df,p0);
    err=abs(p0-p1);
    relerr=2*err/(abs(p1)+delta);%相对误差
    p0=p1;
    y=feval(f,p0);
    if(err<delta)|(relerr<delta)|(abs(y)<epsilon)
        break;
    end
end