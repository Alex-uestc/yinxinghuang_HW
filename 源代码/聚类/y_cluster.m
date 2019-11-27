function [t,label_F]=y_cluster(DATA,num,class,time_num)%输入要聚类的数据和定义的类数；class为1表示地址，2表示大小
%选取初始迭代点
label=zeros(num,3);%第一列为y，第二列为数量,第三列为可用检验，0为不可用1可用
temp=[class 4];
data=DATA(:,temp);%数据为聚类特征，时间，类别
temp=zeros(size(data,1),1);
data=[data temp];
count=200;
temp=floor((size(data,1)-2*count)/num);
for i=1:num
    temp1=0;
    for j=1:count/2
        temp1=data(temp*(i-1)+j,1)+temp1;
        label(i,2)=label(i,2)+1;
        data(temp*(i-1)+j,3)=i;
    end
    label(i,1)=temp1/(count/2);
end
for i=1:num
    label(i,3)=1;
end
flag=1;
time=0;
while flag==1
    time=time+1;
    if time>time_num
        break;
    end
    fprintf('time%d\n',time);
    flag=0;
    for i=1:size(data,1)
        temp=zeros(num,1);%计算8个y
        for j=1:num
            if label(j,3)==0
                temp(j)=inf;
                continue;
            end
            temp(j)=abs(label(j,1)-data(i,1));
        end
        min_y=find(temp==min(temp),1);
        if data(i,3)~=min_y
            flag=1;
            if data(i,3)~=0
                label(data(i,3),2)=label(data(i,3),2)-1;
            end
            data(i,3)=min_y;
            label(min_y,2)=label(min_y,2)+1;
        end
    end
    %重新计算label数组
    %检查分类情况
    for i=1:num
        if label(i,3)==0
            continue;
        end
        if label(i,2)<=1
            label(i,3)=0;
            label(i,1)=inf;
        end
    end
    for i=1:num
        if label(i,3)==0
            continue;
        end
        temp1=0;
        for j=1:size(data,1)
            if data(j,3)==i
                temp1=temp1+data(j,1);
            end
        end
        label(i,1)=temp1/label(i,2);
    end
end
t=cell(num,1);
count=zeros(num,1);
for i=1:size(data,1)
    count(data(i,3))=count(data(i,3))+1;
    t{data(i,3)}(count(data(i,3)),:)=data(i,:);
end
label_F=label;

