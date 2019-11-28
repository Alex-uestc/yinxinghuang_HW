plot_num=50;
plot_start=100000;
temp=zeros(plot_num,3);%第二行为原始数据，第三行为预测值
for i=1:plot_num
    temp(1,i)=i;
    temp(2,i)=t{5}((plot_start+i-1),1);%1为地址
    temp(3,i)=forecast(t{6}((plot_start+i-1),4),100,p,result,mean,std);
end
figure(1);
plot(temp(1,:),temp(2,:),'g.');
hold on;
plot(temp(1,:),temp(3,:),'r.');
temp1=abs(temp(3,:)-temp(2,:))./temp(2,:);
for i=1:plot_num
    if abs(temp1(i))>=1
        temp1(i)=-1;
    end
end
figure(2);
plot(temp(1,:),temp1,'r.');