% aitken.m
function [Q,err,k,y]=aitken(f,P,tol) %埃特金加速
for k=1:length(P)-2
    Q(k)=P(k)-(P(k+1)-P(k))^2/(P(k+2)-2*P(k+1)+P(k));
    err(k)=abs(Q(k)-P(length(P)));
    relerr=err/(abs(P(k))+eps);
    y(k)=feval(f,Q(k));
    if (err<tol)|(relerr<tol)|(abs(y(k))<tol)
        break
    end
end
Q=Q';