function curve=main_curve(data,nb_num,stop)%�����data�Ƕ�ά��������ǰʱ���ں�,nb_num���������,stop��ֱ����ֵ,curve��xΪʱ�䣬yΪ����ֵ
[m,~]=size(data);
mv=mean(data);
st=std(data);
X=(data-repmat(mv,m,1))./repmat(st,m,1); 
R=corrcoef(X);
[V,~]=eig(R);       %�������R��������������V������ֵ����D,����ֵ��С����
V=(rot90(V))';      %��������������V�Ӵ�С����
V=V(:,1);
k=V(1)/V(2);
dist=zeros(m,1);
for i=1:m
    dist(i)=abs(data(i,1)-k*data(i,2))/sqrt(2);
end
[~,rank]=sort(dist);%��������
flag=1;
f_0=sum(dist)/m;
curve=zeros(floor(m/nb_num),2);
curve_num=size(curve,1);
while flag==1
    for i=1:curve_num
        temp_x=0;
        temp_y=0;
        for j=1:nb_num
            temp_x=temp_x+data(rank((i-1)*nb_num+j),2);
            temp_y=temp_y+data(rank((i-1)*nb_num+j),1);
        end
        curve(i,1)=temp_x/nb_num;
        curve(i,2)=temp_y/nb_num;
    end
    [curve,~]=sortrows(curve,1);
    %����dist����
    for i=1:m
        %��x�����������temp1��temp2
        temp=inf;
        for j=1:curve_num
            if data(i,2)<curve(j,1)
               temp=j-1;
               break;
            end
        end
        if temp==0
            temp1(1)=data(1,2);
            temp1(2)=data(1,1);
            temp2(1)=data(2,2);
            temp2(2)=data(2,1);
        elseif temp==inf
            temp1(1)=data(m-1,2);
            temp1(2)=data(m-1,1);
            temp2(1)=data(m,2);
            temp2(2)=data(m,1);
        else
            temp1(1)=data(temp,2);
            temp1(2)=data(temp,1);
            temp2(1)=data(temp+1,2);
            temp2(2)=data(temp+1,1);
        end
        if temp1(1)==temp2(1)
            dist(i)=abs(data(i,2)-temp1(1));
        elseif temp2(2)==temp1(2)
            dist(i)=abs(data(i,1)-temp1(2));
        else
            dist(i)=abs(data(i,1)/(temp1(2)-temp2(2))-data(i,2)/(temp1(1)-temp2(1))+temp2(1)/(temp1(1)-temp2(1))-temp2(2)/(temp1(2)-temp2(2)))/sqrt(1/(temp1(2)-temp2(2))^2+1/(temp1(1)-temp2(1))^2);
        end
    end
    f_t=sum(dist)/m;
    if (1-f_t/f_0)<=stop
        flag=0;
    end
    f_0=f_t;
end


