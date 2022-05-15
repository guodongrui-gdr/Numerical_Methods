function main(f,X,delta)
% 输出迭代序列、迭代次数和图像
syms x
df=diff(f,x);
epsilon=10^(-10);
max2=100;
if ~strcmp(class(f),'function_handle') 
    error("输入函数类型错误,应输入函数句柄类型")
end
if length(X)==1
    c=num2str(X(1));
    weishu=length(c)-find(c=='.');
    if isempty(weishu)
        a=X(1)-0.5*X(1);
        b=X(1)+0.5*X(1);
    else
        a=X(1)-5*10^(-weishu);
        b=X(1)+5*10^(-weishu);
    end
elseif length(X)==2
    if X(1)<=X(2)
        a=X(1);
        b=X(2);
    else
        error("区间错误")
         
    end
else
    error("初始值错误,应输入一个数或一个区间")
     
end
R=approot(f,a,b,10^(-20));
if isempty(R)
    if length(X)==1
        error("初始值附近没有根,考虑结合图像给出更靠近根的初始值")
         
    elseif length(X)==2
        error("区间内没有根,考虑结合图像给出根的区间")
         
    end
end
figure(2);
subplot(2,1,1);
fplot(f,[a,b])
grid on
hold on
for i=1:length(R)
    if (limit(df,x,0,'left')~=limit(df,x,0,'right'))
        [P,k,err]=muller(f,a,b,R(i),delta,epsilon,max2);
        P
        k
    elseif abs(subs(df,x,R(i)))<epsilon
        [P,k,err]=muller(f,a,b,R(i),delta,epsilon,max2);
        P
        k
    else
        [P,k,err]=newton(f,R(i),delta,epsilon,max2,1);
        P
        k
    end
    for j=1:length(P)
        c=num2str(j);
        c=['p' c];
        subplot(2,1,1);
        hold on
        text(P(j),0,c,'fontsize',10)
        scatter(P(j),0,6,"red")
    end
    j=1:length(err);
    subplot(2,1,2)
    grid on
    hold on
    plot(j,err,'r',Marker='.')
    for j=1:length(P)
        c=num2str(j);
        c=['p' c];
        text(j,err(j),c,'fontsize',10)
    end

end


