plot_num=50;
plot_start=100000;

for i=1:plot_num
    count=0;
    for j=1:result_before
        count=count+temp(i-1+j);
    end
    temp(result_before+i)=count/result_before;
end
result=temp(1,(result_before+1):size(temp,2));
orign=t(plot_start:(plot_start+plot_num-1),1)';
x=1:1:50;
figure(1);
plot(x,orign,'g');
hold on;
plot(x,result,'r');
temp1=result-orign;
figure(2);
plot(x,temp1);