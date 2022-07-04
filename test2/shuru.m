f=str2func(['@(x)' input("请输入被积函数f:",'s')]);
a=input("请输入积分下界:");
b=input("请输入积分上界:");
tol1=input("请输入粗控制精度:");
tol2=input("请输入细控制精度:");
[SRmat,quad,err]=main(f,a,b,tol1,tol2)