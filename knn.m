% clear all;close all;clc
% load data.txt
% data_x=data(:,2:end);
% data_y=data(:,1);
function correct=knn(data_x,K,N1,N2,N3)%knn����֮��Ž���仯Ϊ�˺���
%data_x������knn�㷨������������
%K��knn�㷨��k��ȡֵ
%N1:��һ�����ݵĽ�ֹ����
%N2:�ڶ������ݵĽ�ֹ����
%N3:���������ݵĽ�ֹ����
[M,N]=size(data_x);
data_x1=data_x;%��ԭ���ݱ���
sum=zeros(1,M-1);
correct=zeros(1,K);
for k=1:K
    sum_num=0;
    for i=1:M
        data_x=data_x1;
        data_now=data_x(i,:);%�������г��һ��
        data_x(i,:)=[];%��ԭ������ȥ���������������
        for r=1:1:M-1
            for j=1:1:N
                sum(1,r)=sum(1,r)+((data_now(1,j)-data_x(r,j))^2);%�������������ݺ�ʣ����֮���ŷ�Ͼ���
            end
            sum(1,r)=sqrt(sum(1,r));
        end
        [z,Ind]=sort(sum);%�Ը������ݵ�ŷʽ�����������
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
%             disp(sprintf('��%d�����ݷ����Ϊ��%d��',i,m));
%         elseif i>N1&&i<=N2  
%             disp(sprintf('��%d�����ݷ����Ϊ��%d��',i,m));
%         elseif i>N2&&i<=N3   
%             disp(sprintf('��%d�����ݷ����Ϊ��%d��',i,m));
%         end
        if (i<=N1&&m==1)||(i>N1&&i<=N2&&m==2)||(i>N2&&i<=N3&&m==3)
            sum_num=sum_num+1;
        end
    end
    correct(1,k)=sum_num/N3;
%     disp(sprintf('%d-nn������ȷ��Ϊ%4.2f',k,sum_num/N3));
end
% plot(1:60,correct);