function [t,label_F]=k_cluster(DATA,num,class,time_num)%����Ҫ��������ݺͶ����������classΪ1��ʾ��ַ��2��ʾ��С
%ѡȡ��ʼ������
label=zeros(num,5);%��һ��Ϊk�ĽǶȣ��ڶ��к͵�����Ϊ�е�,������Ϊ����,������Ϊ���ü��飬0Ϊ������1����
temp=[class 4];
data=DATA(:,temp);%����Ϊ����������ʱ�䣬���
temp=zeros(size(data,1),1);
data=[data temp];
count=200;
temp=floor((size(data,1)-2*count)/num);
for i=1:num
    temp1=0;
    temp2=0;
    temp3=0;
    temp4=0;
    for j=1:count/2
        temp1=data(temp*(i-1)+j,1)+temp1;
        temp2=data(temp*(i-1)+j,2)+temp2;
        data(temp*(i-1)+j,3)=i;
        label(i,4)=label(i,4)+1;
        temp3=data(temp*(i-1)+j+count/2,1)+temp3;
        temp4=data(temp*(i-1)+j+count/2,2)+temp4;
        data(temp*(i-1)+j+count/2,3)=i;
        label(i,4)=label(i,4)+1;
    end
    label(i,1)=atan((temp3-temp1)/(temp4-temp2));
    label(i,3)=(temp1+temp3)/6;
    label(i,2)=(temp2+temp4)/6;
end
for i=1:num
    label(i,5)=1;
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
        temp=zeros(num,1);%����8��б��
        for j=1:num
            if label(j,5)==0
                temp(j)=inf;
                continue;
            end
            temp_k=atan((data(i,1)-label(j,1))/(data(i,2)-label(j,1)));
            temp(j)=abs(label(j,1)-temp_k);
        end
        min_k=find(temp==min(temp), 1 );
        if data(i,3)~=min_k
            flag=1;
            if data(i,3)~=0
                label(data(i,3),4)=label(data(i,3),4)-1;
            end
            data(i,3)=min_k;
            label(min_k,4)=label(min_k,4)+1;
        end
    end
    %���¼���label����
    %���������
    for i=1:num
        if label(i,5)==0
            continue;
        end
        if label(i,4)<=1
            label(i,5)=0;
            label(i,1)=inf;
        end
    end
    for i=1:num
        if label(i,5)==0
            continue;
        end
        temp1=0;
        temp2=0;
        temp3=0;
        temp4=0;
        count=0;
        for j=1:size(data,1)
            if data(j,3)==i
                count=count+1;
                if count<=label(i,4)/2
                    temp1=data(j,1)+temp1;
                    temp2=data(j,2)+temp2;
                else
                    temp3=data(j,1)+temp3;
                    temp4=data(j,2)+temp4;
                end
            end
        end
        label(i,1)=atan((temp3-temp1)/(temp4-temp2));
        label(i,3)=(temp1+temp3)/6;
        label(i,2)=(temp2+temp4)/6;
    end
end
t=cell(num,1);
count=zeros(num,1);
for i=1:size(data,1)
    count(data(i,3))=count(data(i,3))+1;
    t{data(i,3)}(count(data(i,3)),:)=data(i,:);
end
label_F=label;

