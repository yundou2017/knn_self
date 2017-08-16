clear all;close all;clc
load data.txt
data_x=data(:,2:end);
% data_x=zscore(data_x);%��ԭ���ݽ��б�׼������

% stdr=std(data_x); %��������ı�׼��
% [n,m]=size(data_x); %�������������
% data_x=data_x./stdr(ones(n,1),: ); %��ԭʼ���ݲɼ���׼��

% data_y=data(:,1);
K=60;%�趨k�����ֵ

correct=knn(data_x,K,59,130,178);%��ԭ����ֱ�ӽ���knn�㷨����
figure
plot(1:K,correct);%���Ƴ���kֵȡ1��Kʱ��ȷ�ʵı仯���
xlabel('kֵ');ylabel('��ȷ��ȡֵ');
title('ԭ����ֱ�ӽ���knn�㷨����');
max_correct=correct(1,1);
max_kk=1;
for kk=2:K
    if correct(1,kk)>max_correct
        max_correct=correct(1,kk);
        max_kk=kk;
    end
end
disp(sprintf('ֱ�Ӷ�ԭ���ݽ���k-nn����ʱkȡֵΪ%dʱ��ȷ�������ֵΪ%4.2f',max_kk,max_correct))

max_correct_vec=zeros(1,13);
max_kk_vec=zeros(1,13);
[pc,score,latent,tsquare] = princomp(data_x);%��ԭ����ʹ��pca�㷨���н�ά����
latent=100*latent/sum(latent);
% cumsum(latent)./sum(latent)
for vec=1:13    %��1��13ά�������
     data_xx=score*pc(:,1:vec);
%    data_xx=score(:,1:vec);
    correct1=knn(data_xx,K,59,130,178);%�Խ�ά������ݽ���knn�㷨����
% figure
% plot(1:K,correct1);%���Ƴ���kֵȡ1��Kʱ��ȷ�ʵı仯���
% xlabel('kֵ');ylabel('��ȷ��ȡֵ');
% title('ԭ����ֱ�ӽ���knn�㷨����');
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
    disp(sprintf('ԭ���ݽ�Ϊ%dάʱkȡֵΪ%dʱ��ȷ�������ֵΪ%4.2f',vec,max_kk1,max_correct1))
end
max_num=max_correct_vec(1,1);
for mm=2:13
    if max_correct_vec(1,mm)>max_num
            max_num=max_correct_vec(1,mm);
            max_kk2=mm;
    end
end
disp(sprintf('RESULT����ʹ��ȷ�����Ӧʹԭ���ݽ�Ϊ%dά��kȡֵΪ%dʱ����ȷ��ֵΪ%4.2f',max_kk2,max_kk_vec(1,max_kk2),max_num))