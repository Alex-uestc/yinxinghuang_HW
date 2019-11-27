num=3;
for i =1:num
    eval(strcat('X',num2str(i),'=result_curve{i};'));
    eval(strcat('X',num2str(i),'_x','=X',num2str(i),'(:,1);'));
    eval(strcat('X',num2str(i),'_y','=X',num2str(i),'(:,2);'));
end
for i =1:num
    eval(strcat('[X',num2str(i),',mean',num2str(i),',std',num2str(i),']=zscore(X',num2str(i),');'));
    eval(strcat('[p',num2str(i),',S',num2str(i),']=polyfit(X',num2str(i),'(:,1),X',num2str(i),'(:,2),3);'));
end
p=zeros(num,6);
for i=1:num
    temp=result_curve{i};
    size_num=size(temp,1);
    p(i,1)=result_curve{i}(1,1);
    p(i,2)=result_curve{i}(size_num,1);
end
%%%
p(1,3:6)=p1;
p(2,3:6)=p2;
p(3,3:6)=p3;