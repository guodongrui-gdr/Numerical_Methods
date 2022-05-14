f=@(x)cos(x).*cosh(x)-1;
fplot(f)
grid on
df=diff(f,x);
delta=10^(-10);epsilon=10^(-10);
max2=100;
a=0;b=50;
R=approot(f,a,b,10^(-20))
m=0;
for i=1:length(R)
    if abs(subs(df,x,R(i)))<epsilon
        [P,k]=muller(f,a,b,R(i),delta,epsilon,max2);
        P
        k
    else
        [P,k]=newton(f,R(i),delta,epsilon,max2,1);
        P
        k
    end
end