function [SRmat,quad,err]=adapt(f,a,b,tol1,tol2)
SRmat=zeros(3,6);
iterating=0;
done=1;
left=a;
right=b;
SRvec=zeros(1,7);
if(f(a)==f(b)) && (f(b)==f((a+b)/2)) && (f((a+b)/2)==f((3*a+b)/4)) && (f((3*a+b)/4)==f((a+3*b)/4)) &&(f((a+3*b)/4)==0)
    SRvec=srule38(f,a,b,tol2);
else
    SRvec=srule(f,a,b,tol2);
end
SRmat(1,2:7)=SRvec;
m=1;
state=iterating;
while(state==iterating)
    n=m;
    for j=n:-1:1
        p=j;
        SR0vec=SRmat(p,2:7);
        err=SR0vec(5);
        tol=SR0vec(6);
        if(tol<=err)
            state=done;
            SR1vec=SR0vec;
            SR2vec=SR0vec;
            a=SR0vec(1);
            b=SR0vec(2);
            c=(a+b)/2;
            err=SR0vec(5);
            tol3=tol2/2;
            if(f(a)==f(b)) && (f(b)==f((a+b)/2)) && (f((a+b)/2)==f((3*a+b)/4)) && (f((3*a+b)/4)==f((a+3*b)/4)) &&(f((a+3*b)/4)==0)
                SR1vec=srule38(f,a,c,tol3);
                SR2vec=srule38(f,c,b,tol3);            
            else
                SR1vec=srule(f,a,c,tol3);
                SR2vec=srule(f,c,b,tol3);
            end
            err=abs(SR0vec(3)-SR1vec(3)-SR2vec(3))/10;
            if(err<tol1)
                SRmat(p,1)=int8(p);
                SRmat(p,2:7)=SR0vec;
                [~,quad,err]=romber(f,a,b,5,tol2);
                SRmat(p,5)=quad;
                SRmat(p,6)=err;
            else
                SRmat(p+1:m+1,:)=SRmat(p:m,:);
                m=m+1;
                SRmat(p,2:7)=SR1vec;
                SRmat(p+1,2:7)=SR2vec;
                state=iterating;
            end
        end
    end
end
quad=sum(SRmat(:,5));
err=sum(abs(SRmat(:,6)));
cnames={'迭代次数','细分区间左端点','细分区间右端点','单个辛普森公式积分结果S1','两个辛普森公式积分结果S2','误差','容差'};
SRmat=array2table(SRmat,"VariableNames",cnames);
hold on
grid on
fplot(f,'r',[left,right])
for i=1:m
    X=[SRmat{i,2},(SRmat{i,2}+SRmat{i,3})/2,SRmat{i,3}];
    P=@(x)f(x)*(x-X(2))*(x-X(3))/((X(1)-X(2))*(X(1)-X(3)));
    fplot(P,[SRmat{i,2},SRmat{i,3}])
end
