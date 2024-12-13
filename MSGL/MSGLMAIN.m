 clear;

%addpath('./datasets');
% load('Caltech101-7.mat');
load('F:\对比实验\datasets\MUUFL\MUUFLGfportGT.mat')
load('F:\对比实验\datasets\MUUFL\MUUFLGfportHSI.mat')
hsi = data;
hsi = reshape(hsi, [],64);
hsi = double(hsi);
load('F:\对比实验\datasets\MUUFL\MUUFLGfportLiDAR_data_first_return.mat')
lidar = data;
lidar = reshape(lidar, [], 2);
lidar = double(lidar);
x={};
x{1} = hsi;
x{2} = lidar;
Y=double(reshape(gt, [], 1));
nv=length(x);
ns=length(unique(Y));

for i=1:nv
    x{i}=(x{i})';
end
numanchor=[100 110 120 130 ];
alpha=[1 10];
beta=[5*1e4 1e5 5*1e5];
gamma=[-5 -4 -3 -2 -1];
for j=1:length(numanchor)
%     rand('twister',5489);
    rng(5489,'twister');
    for i=1:nv
        [~, H{i}] = litekmeans((x{i})',numanchor(j),'MaxIter', 100,'Replicates',10);
       
        
        H{i}=(H{i})';
    end
    
    for i=1:length(alpha)
        for m=1:length(beta)
            for p=1:length (gamma)
            fprintf('params:\tnumanchor=%d\t\talpha=%f\tbeta:%d\n',numanchor(j), alpha(i), beta(m));
            tic;
            [result]=unifiedclusternew(x',H,Y,alpha(i),beta(m),gamma(p),nv);
            t=toc;
            
            fprintf('result:\t%12.6f %12.6f %12.6f %12.6f\n',[result t]);
            dlmwrite('Caltech101-7.txt',[numanchor(j) alpha(i) beta(m) gamma(p) result t],'-append','delimiter','\t','newline','pc');
            
            
        end
    end
    end
end
