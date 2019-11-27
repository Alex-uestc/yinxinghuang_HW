clear;
clc;
DATA=importdata('C:\Users\32609\Desktop\银杏黄11.27\初始数据\DATA.mat');
t=cell(24,1);
for test_num=1:length(t)
    count=1;
    for j=1:size(DATA,1)
        if DATA(j,1)==test_num-1
            t{test_num}(count,1)=DATA(j,2);
            t{test_num}(count,2)=DATA(j,3);
            t{test_num}(count,3)=DATA(j,4);
            t{test_num}(count,4)=DATA(j,5);
            count=count+1;
        end
    end
    t{test_num}=Preprocess(t{test_num});
end
save('C:\Users\32609\Desktop\银杏黄11.27\data_processed\DATA_F.mat','t');