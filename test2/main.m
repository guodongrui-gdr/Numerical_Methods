function [SRmat,quad,err]=main(f,a,b,tol1,tol2,disc)
% 输入参数: f    -被积函数
%           a,b  -积分上下限
%           tol1 -粗精度
%           tol2 -细精度
%           disc -间断点
if(nargin==5)
    [SRmat,quad,err]=adapt(f,a,b,tol1,tol2);
elseif(nargin==6)
    H=b-a;
    SRmat=[];
    quad=0;
    err=0;
    for i=1:length(disc)
        h=(disc(i)-a)/H;
        [SRmati,quadi,erri]=adapt(f,a,disc(i)-tol2,tol1*h,tol2*h);
        SRmat=[SRmat;SRmati];
        quad=quad+quadi;
        err=err+erri;
        a=disc(i);
    end
    h=(b-a)/H;
    [SRmat1,quad1,err1]=adapt(f,a+tol2,b,tol1*h,tol2*h);
    SRmat=[SRmat;SRmat1];
    quad=quad+quad1;
    err=err+err1;
end