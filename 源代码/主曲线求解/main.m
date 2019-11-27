clear;
clc;
t=importdata('C:\Users\32609\Desktop\银杏黄11.27\data_processed\DATA_F.mat');
[a,label]=y_cluster(t{6},8,1,10000);
num=sum(label(:,3));
result=cell(num,1);
count=1;
for i=1:8
    if label(i,3)==1
        result{count}=a{i};
        count=count+1;
    end
end
figure(1);
for i=1:num
    plot(result{i}(:,2),result{i}(:,1),'.');
    hold on;
end
fprintf('聚类成%d类\n',num);
result_curve=cell(num,1);
minizen=7;
for i=1:num
    result_curve_temp1{i}=main_curve(result{i}(:,1:2),minizen,0.1);
end
figure(2);
for i=1:num
    plot(result_curve_temp1{i}(:,1),result_curve_temp1{i}(:,2),'.');
    hold on;
end
%
for i=1:num
    result_curve_temp2{i}=main_curve(result_curve_temp1{i},minizen,0.1);
end
figure(3);
for i=1:num
    plot(result_curve_temp2{i}(:,2),result_curve_temp2{i}(:,1),'.');
    hold on;
end
%
for i=1:num
    result_curve{i}=main_curve(result_curve_temp2{i},minizen,0.1);
end
figure(4);
for i=1:num
    plot(result_curve{i}(:,1),result_curve{i}(:,2),'.');
    hold on;
end