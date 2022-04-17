%forsub.m 前向替换法
function X = forsub(A,B)
% 输入参数   A为N*N下三角矩阵
%           B为N*1矩阵
% 输出参数   X为线性方程组AX=B的解
n=length(B);
X=zeros(n,1);
X(1)=B(1)/A(1,1);
for k=2:n
    X(k)=(B(k)-A(k,1:k-1)*X(1:k-1))/A(k,k);
end