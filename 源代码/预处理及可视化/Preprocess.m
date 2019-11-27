function DATA=Preprocess(DATA_INT)
num=size(DATA_INT,1);
local=0; 
v=0;
for i=1:num
    local=local+DATA_INT(i,1);
    v=v+DATA_INT(i,2);
end
av_local=local/num;
av_v=v/num;
local=0;
v=0;
for i=1:num
    local=local+(DATA_INT(i,1)-av_local)^2;
    v=v+(DATA_INT(i,2)-av_v)^2;
end
der_local=sqrt(local/num);
der_v=sqrt(v/num);
count=1;
for i=1:num
    if DATA_INT(i,1)<=av_local+3*der_local && DATA_INT(i,1)>=av_local-3*der_local && DATA_INT(i,2)<=av_v+3*der_v && DATA_INT(i,2)<=av_v+3*der_v
        if DATA_INT(i,3)==1
            DATA(count,:)=DATA_INT(i,:);
            count=count+1;
        end
        if DATA_INT(i,3)==0
            DATA(count,1)=-1*DATA_INT(i,1);
            DATA(count,2)=-1*DATA_INT(i,2);
            DATA(count,3)=DATA_INT(i,3);
            DATA(count,4)=DATA_INT(i,4);
            count=count+1;
        end
    end
end