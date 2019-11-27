clc;
clear;
t=importdata('C:\Users\32609\Desktop\ÒøÐÓ»Æ11.27\data_processed\DATA_F.mat');
t=t{7}(:,4);
m=size(t,1);
dis_t=zeros(1,m-1);
for i=1:m-1
    dis_t(i)=t(i+1)-t(i);
end
size=size(dis_t,2);
result_temp=inf;
num=0;
for nb_num=50:200
    count=0;
    for i=1:size-nb_num
        count=count+abs(sum(dis_t(i:i+nb_num-1))/nb_num-dis_t(i+nb_num));
    end
    count=count/(size-nb_num);
    if count<result_temp
        result_temp=count;
        num=nb_num;
    end
end