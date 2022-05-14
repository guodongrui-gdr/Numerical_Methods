function R=approot(f,a,b,epsilon)
% 输入参数: f为函数表达式
%           X为向量形式的自变量
%           epsilon为最大误差
% 输出参数: R为根的近似值位置
X=a:10^(-5):b;
Y=f(X);
df=diff(f(X));
n=length(X);
m=0;
X(n+1)=X(n);
Y(n+1)=Y(n);
R=[];
for k=1:n-1
    if (Y(k+1)==0)
        m=m+1;
        R(m)=X(k+1);
    elseif (Y(k)==0)
        m=m+1;
        R(m)=X(k);
    elseif Y(k)*Y(k+1)<0
        m=m+1;
        R(m)=(X(k)+X(k+1))/2;
    end
    if(abs(Y(k+1))<epsilon)&& (df(k)*df(k+1)<=0)
        m=m+1;
        R(m)=X(k+1);
    end
    if m>=2
        if abs(R(m)-R(m-1))<=(X(k+1)-X(k))
            R(m)=[];
            m=m-1;
        end
    end
end