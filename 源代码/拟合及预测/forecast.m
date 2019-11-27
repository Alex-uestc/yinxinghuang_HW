function result=forecast(input_t,num,p,data,mean,std)%input为待预测值，num为向前看设置权重的统计量，p为区间加上四个系数，data为聚类后的数据
input_t1=(input_t-mean(1))/std(1);
size_num=size(p,1);
count_point=zeros(1,size_num);
count=0;
for i=1:size_num
    if input_t<=p(i,2) && input_t>=p(i,1)
        count=count+1;
        count_point(count)=i;
    end
end
count_point=count_point(1,1:count);
p_used=p(count_point,:);
weight=zeros(1,count);
for i=1:count
    temp_data=data{count_point(i)};
    [~,index]=min(abs(temp_data(:,1)-input_t));
    for j=1:num
        weight(1,i)=weight(1,i)+temp_data(index-j,1);
    end
end
result=0;
for i=1:count
    result=result+(weight(i)/sum(weight))*(p_used(i,3)*input_t1^3+p_used(i,4)*input_t1^2+p_used(i,5)*input_t1+p_used(i,6));
end
result=result*std(2)+mean(2);

