function main(f,X,delta)
% 输出迭代序列、迭代次数和图像
syms x
df=diff(f,x);
epsilon=10^(-10); % 函数值最大允许误差
max2=100;
if ~strcmp(class(f),'function_handle') 
    error("输入函数类型错误,应输入函数句柄类型")
end
% 若输入的X是一个值,则将其扩充为区间;否则直接将区间放入approot函数
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
% approot函数,得到的R为根的近似值(若区间内有多个根,则给出多个近似值)
R=approot(f,a,b,10^(-20));
if isempty(R)
    if length(X)==1
        error("初始值附近没有根,考虑结合图像给出更靠近根的初始值")
         
    elseif length(X)==2
        error("区间内没有根,考虑结合图像给出根的区间")
         
    end
end
F=figure(2);
F.Position(3)=1000;
subplot(1,2,1);
fplot(f,[a,b],'b')
grid on
hold on
title("原函数与迭代点图像")
for i=1:length(R)
%   若在p0处导数值不存在或导数值等于0,则用米勒法,否则用牛顿法
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
%     画出函数图像和迭代点
    for j=1:length(P)
        c=num2str(j);
        c=['p' c];
        subplot(1,2,1);
        hold on
        text(P(j),0,c,'fontsize',10)
        scatter(P(j),0,6,"red")
    end
%     画出误差图
    j=1:length(err);
    subplot(1,2,2)
    title("误差-迭代次数图像")
    xlabel("迭代次数")
    ylabel("误差")
    grid on
    hold on
    plot(j,err,'r',Marker='.')
    for j=1:length(P)
        c=num2str(j);
        c=['p' c];
        text(j,err(j),c,'fontsize',10)
    end

end
fprintf('共找到%d个根\n',length(R));
