% clear all;close all;clc
% load data.txt
% data_x=data(:,2:end);
% data_y=data(:,1);
function correct=knn(data_x,K,N1,N2,N3)%knn做好之后才将其变化为了函数
%data_x：利用knn算法测试类别的数据
%K：knn算法中k的取值
%N1:第一类数据的截止行数
%N2:第二类数据的截止行数
%N3:第三类数据的截止行数
[M,N]=size(data_x);
data_x1=data_x;%对原数据备份
sum=zeros(1,M-1);
correct=zeros(1,K);
for k=1:K
    sum_num=0;
    for i=1:M
        data_x=data_x1;
        data_now=data_x(i,:);%从数据中抽出一行
        data_x(i,:)=[];%从原数据中去掉抽出的那行数据
        for r=1:1:M-1
            for j=1:1:N
                sum(1,r)=sum(1,r)+((data_now(1,j)-data_x(r,j))^2);%计算抽出的行数据和剩余行之间的欧氏距离
            end
            sum(1,r)=sqrt(sum(1,r));
        end
        [z,Ind]=sort(sum);%对该行数据的欧式距离进行排序
        m1=0;
        m2=0;
        m3=0;
        if i<=N1
            for nn=1:k
                if Ind(1,nn)<=(N1-1)
                    m1=m1+1;
                elseif Ind(1,nn)>(N1-1)&&Ind(1,nn)<=(N2-1)
                    m2=m2+1;
                else
                    m3=m3+1;
                end
            end
        elseif i>N1&&i<=N2
            for nn=1:k
                if Ind(1,nn)<=N1
                    m1=m1+1;
                elseif Ind(1,nn)>N1&&Ind(1,nn)<=(N2-1)
                    m2=m2+1;
                else
                    m3=m3+1;
                end
            end
        else
            for nn=1:k
                if Ind(1,nn)<=N1
                    m1=m1+1;
                elseif Ind(1,nn)>N1&&Ind(1,nn)<=N2
                    m2=m2+1;
                else
                    m3=m3+1;
                end
            end
        end
        if m1>=m2&&m1>=m3
            m=1;
        elseif  m2>=m1&&m2>=m3
            m=2;
        elseif  m3>=m1&&m3>=m2
            m=3;
        end
%         if i<=N1
%             disp(sprintf('第%d组数据分类后为第%d类',i,m));
%         elseif i>N1&&i<=N2  
%             disp(sprintf('第%d组数据分类后为第%d类',i,m));
%         elseif i>N2&&i<=N3   
%             disp(sprintf('第%d组数据分类后为第%d类',i,m));
%         end
        if (i<=N1&&m==1)||(i>N1&&i<=N2&&m==2)||(i>N2&&i<=N3&&m==3)
            sum_num=sum_num+1;
        end
    end
    correct(1,k)=sum_num/N3;
%     disp(sprintf('%d-nn分类正确率为%4.2f',k,sum_num/N3));
end
% plot(1:60,correct);