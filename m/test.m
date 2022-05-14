function test(f,X,delta)
syms x
df=diff(f,x);
epsilon=10^(-10);
max2=100;
if length(X)==1
    c=num2str(X(1));
    weishu=length(c)-find(c==".");
    if isempty(weishu)
        a=X(1)-0.5*X(1);
        b=X(1)+0.5*X(1);
    else
        a=X(1)-5*weishu;
        b=X(1)+5*weishu;
    end
elseif length(X)==2
    if X(1)<=X(2)
        a=X(1);
        b=X(2);
    else
        disp("区间错误")
    end
else
    disp("初始值错误,应输入1个数或一个区间")
end
R=approot(f,a,b,10^(-20));
if isempty(R)
    if length(X)==1
        disp("初始值附近没有根")
    elseif length(X)==2
        disp("区间内没有根")
    end
end
fplot(f,[a,b])
grid on
hold on
m=0;
for i=1:length(R)
    if (limit(df,x,0,'left')~=limit(df,x,0,'right'))
        [P,k]=muller(f,a,b,R(i),delta,epsilon,max2);
        P
        k
    elseif abs(subs(df,x,R(i)))<epsilon
        [P,k]=muller(f,a,b,R(i),delta,epsilon,max2);
        P
        k
    else
        [P,k]=newton(f,R(i),delta,epsilon,max2,1);
        P
        k
    end
    for i=1:length(P)
    c=num2str(i);
    c=['p' c];
    text(P(i),0,c,'fontsize',10)
    scatter(P(i),0,6,"red")
    end
end


