% fixpt.m
function [P,err,k,y]=fixpt(g,p0,tol,max1)% 不动点迭代
P(1)=p0;
for k=2:max1
    P(k)=feval(g,P(k-1));
    err=abs(P(k)-P(k-1));
    relerr=err/(abs(P(k))+eps);
    y=P(k);
    if (err<tol)|(relerr<tol)
        break
    end
end
if(k==max1)
    disp("最大迭代次数溢出");
end
P=P';