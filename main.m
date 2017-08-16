clear all;close all;clc
load data.txt
data_x=data(:,2:end);
% data_x=zscore(data_x);%对原数据进行标准化处理

% stdr=std(data_x); %求个变量的标准差
% [n,m]=size(data_x); %定义矩阵行列数
% data_x=data_x./stdr(ones(n,1),: ); %将原始数据采集标准化

% data_y=data(:,1);
K=60;%设定k的最大值

correct=knn(data_x,K,59,130,178);%对原数据直接进行knn算法分析
figure
plot(1:K,correct);%绘制出当k值取1到K时正确率的变化情况
xlabel('k值');ylabel('正确率取值');
title('原数据直接进行knn算法分析');
max_correct=correct(1,1);
max_kk=1;
for kk=2:K
    if correct(1,kk)>max_correct
        max_correct=correct(1,kk);
        max_kk=kk;
    end
end
disp(sprintf('直接对原数据进行k-nn分析时k取值为%d时正确率最大，其值为%4.2f',max_kk,max_correct))

max_correct_vec=zeros(1,13);
max_kk_vec=zeros(1,13);
[pc,score,latent,tsquare] = princomp(data_x);%对原数据使用pca算法进行降维分析
latent=100*latent/sum(latent);
% cumsum(latent)./sum(latent)
for vec=1:13    %对1到13维逐个分析
     data_xx=score*pc(:,1:vec);
%    data_xx=score(:,1:vec);
    correct1=knn(data_xx,K,59,130,178);%对降维后的数据进行knn算法分析
% figure
% plot(1:K,correct1);%绘制出当k值取1到K时正确率的变化情况
% xlabel('k值');ylabel('正确率取值');
% title('原数据直接进行knn算法分析');
    max_correct1=correct1(1,1);
    max_kk1=1;
    for kk=2:K
        if correct1(1,kk)>max_correct1
            max_correct1=correct1(1,kk);
            max_kk1=kk;
        end
    end
    max_correct_vec(1,vec)=max_correct1;
    max_kk_vec(1,vec)=max_kk1;
    disp(sprintf('原数据降为%d维时k取值为%d时正确率最大，其值为%4.2f',vec,max_kk1,max_correct1))
end
max_num=max_correct_vec(1,1);
for mm=2:13
    if max_correct_vec(1,mm)>max_num
            max_num=max_correct_vec(1,mm);
            max_kk2=mm;
    end
end
disp(sprintf('RESULT：欲使正确率最大，应使原数据降为%d维，k取值为%d时，正确率值为%4.2f',max_kk2,max_kk_vec(1,max_kk2),max_num))