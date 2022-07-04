function [SRmat,quad1,err]=adapt(f,a,b,tol1,tol2)
SRmat=zeros(3,6);
left=a;
right=b;
SRvec=zeros(1,6);
if(f(a)==f(b)) && (f(b)==f((a+b)/2)) && (f((a+b)/2)==f((3*a+b)/4)) && (f((3*a+b)/4)==f((a+3*b)/4)) &&(f((a+3*b)/4)==0)
    SRvec=srule38(f,a,b,tol1);
else
    SRvec=srule(f,a,b,tol1);
end
SRmat(1,:)=SRvec;
m=1;
while(sum(abs(SRmat(:,5)))>=tol2)
    n=m;
    for j=n:-1:1
        p=j;
        SR0vec=SRmat(p,:);
        err=SR0vec(5);
        tol=SR0vec(6);
        if(tol<=err)
            
            SR1vec=SR0vec;
            SR2vec=SR0vec;
            a=SR0vec(1);
            b=SR0vec(2);
            c=(a+b)/2;
            err=SR0vec(5);
            tol3=tol/2;
            if(f(a)==f(b)) && (f(b)==f((a+b)/2)) && (f((a+b)/2)==f((3*a+b)/4)) && (f((3*a+b)/4)==f((a+3*b)/4)) &&(f((a+3*b)/4)==0)
                SR1vec=srule38(f,a,c,tol3);
                SR2vec=srule38(f,c,b,tol3);            
            else
                SR1vec=srule(f,a,c,tol3);
                SR2vec=srule(f,c,b,tol3);
            end
            if(err<tol1)
                SRmat(p,:)=SR0vec;
                [~,quad1,err]=romber(f,a,b,10,tol2);
                SRmat(p,4)=quad1;
                SRmat(p,5)=err;
            else
                SRmat(p+1:m+1,:)=SRmat(p:m,:);
                m=m+1;
                SRmat(p,:)=SR1vec;
                SRmat(p+1,:)=SR2vec;
            end
        end
    end
end
quad1=sum(SRmat(:,4));
err=sum(abs(SRmat(:,5)));
cnames={'细分次数','细分区间左端点','细分区间右端点','单个辛普森公式积分结果S1','自适应积分结果S2','误差界','容差'};
k=[1:size(SRmat)]';
SRmat=[k SRmat];
SRmat=SRmat(1:m,:);
SRmat=array2table(SRmat,"VariableNames",cnames);
hold on
grid on
fplot(f,'r',[left,right])
