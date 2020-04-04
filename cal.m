% clc;clear;
% A=[0,1,0,0,0,0,1,1,0,1;
%     1,0,1,0,0,0,0,0,0,1;
%     0,1,0,1,0,1,0,0,0,0;
%     0,0,1,0,1,1,0,1,0,0;
%     0,0,0,1,0,1,0,0,0,0;
%     0,0,1,1,1,0,1,0,0,0;
%     1,0,0,0,0,1,0,1,1,1;
%     1,0,0,1,0,0,1,0,1,1;
%     0,0,0,0,0,0,1,1,0,1;
%     1,1,0,0,0,0,1,1,1,0];
Dis=Distance(A);
D=MaxD(Dis);
meanD=MeanD(Dis);
C=calC(A);
P=calP(A);
function [Dis]=Distance(A)%通过邻接矩阵计算距离矩阵D
sizeA=size(A);
Dis=zeros(sizeA);
num=1;
while(sum(sum(Dis==0))>sizeA(1))
    A_n=A^num;
    [m,n]=find(Dis==0);
    for i=1:length(m)
        %A的num次方才使得该位置不为0时即为最短距离
       if(m(i)~=n(i) && A_n(m(i),n(i))~=0)
           Dis(m(i),n(i))=num;
           Dis(n(i),m(i))=num;
       end 
    end
    if(num>=sizeA(1))
        [m,n]=find(Dis==0);
        %如果循环超过点个数仍然没有距离的即为无穷大
        %也就是没有路径相通
        for i=1:length(m)
            if(m(i)~=n(i))
                Dis(m(i),n(i))=inf;
                Dis(n(i),m(i))=inf;
            end 
        end
        break;
    end
    num=num+1;
end


end

function [D]=MaxD(Dis)
D=max(max(Dis));
end%计算直径

function [L]=MeanD(Dis)%计算平均距离
sizeDis=size(Dis);
L=sum(sum(Dis))/sizeDis(1)^2;
end

function [C]=calC(A)
sizeA=size(A);
sizeA=sizeA(1);
A2=A^2;
A3=A^3;
C=zeros(1,sizeA);
for i=1:sizeA
   C(i)=A3(i,i)/(A2(i,i)*(A2(i,i)-1));
end
end%计算聚集系数

function [P]=calP(A)%计算度分布
sizeA=size(A);
sizeA=sizeA(1);
p=sum(A);
P=[];
for i=1:sizeA
    P=[P,sum(p<=i)/sizeA]; 
end

end