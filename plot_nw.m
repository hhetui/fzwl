clc;clear;
% N=input('请输入最近邻耦合网络中节点的总数N:');%%参数输入
% K=input('请输入最近邻耦合网络中每个节点的邻居数K:');
A=nw(10,4,0.2);
function [A]=nw(N,K,p)
if K>floor(N-1) || mod(K,2)~=0
    disp('参数输入错误：K值必须是小于网络节点总数且为偶数的整数');
    return;
end%%参数输入
angle=0:2*pi/N:2*pi-2*pi/N;
x=100*sin(angle);
y=100*cos(angle);%%生成各节点的坐标
plot(x,y,'ro','MarkerEdgeColor','g','MarkerFaceColor','r','markersize',8);
hold on;
A=zeros(N);
for i=1:N
    for j=i+1:i+K/2
        jj=j;
        if j>N
            jj=mod(j,N);
        end
        A(i,jj)=1;A(jj,i)=1;
    end
end
%p=input('请输入随机化加边的概率p:');
[m,n]=find(A==0);

for i=1:length(m)
    if m(i)~=n(i)
        pl=rand(1,1);
        if p>pl
            A(m(i),n(i))=1;
            A(n(i),m(i))=1;
        end
    end
end
for i=1:N  %开始画最近邻耦合网络
    for j=i+1:N
        if A(i,j)~=0
            plot([x(i),x(j)],[y(i),y(j)],'linewidth',1.2);
            hold on;
        end
    end
end
axis equal;
hold off


end

