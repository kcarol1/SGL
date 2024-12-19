 clear;

% addpath('../..');
% load('Caltech101-7.mat');
% win
% load('..\..\..\datasets\MUUFL\MUUFLGfportGT.mat')
% load('..\..\..\datasets\MUUFL\MUUFLGfportHSI.mat')

% linux
load('../../datasets/Houston/HoustonGT.mat')
load('../../datasets/Houston/HoustonHSI.mat')


% hsi = data; % Houston不需要这一步
hsi = reshape(hsi, [],size(hsi,3));
hsi = double(hsi);

% win
% load('..\..\..\datasets\MUUFL\MUUFLGfportLiDAR_data_first_return.mat')

% linux
load('../../datasets/Houston/HoustonLidar.mat')

% lidar = data;
lidar = Lidar; % Houston
lidar = reshape(lidar, [], size(lidar,3));
lidar = double(lidar);
x={};
x{1} = hsi;
x{2} = lidar;

% Y=double(reshape(mask_test, [], 1)); % Trento
Y=double(reshape(gt, [], 1));


indx_labeled = find(Y ~= 0);  % 找到非零元素的索引
Y = Y(indx_labeled); % 提取非零元素
% class_num = numel(unique(Y)) - 1;  % 计算唯一类别数并减去1

nv=length(x);
ns=length(unique(Y));
record = RecordResult();
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
    parfor i=1:nv
    [~, H{i}] = litekmeans((x{i})',numanchor(j),'MaxIter', 100,'Replicates',10);
    
    
    H{i}=(H{i})';
    end
    
    for i=1:length(alpha)
        for m=1:length(beta)
            for p=1:length (gamma)
            fprintf('params:\tnumanchor=%d\t\talpha=%f\tbeta:%d\n',numanchor(j), alpha(i), beta(m));
            tic;
            [result, ca, y_pre]=unifiedclusternew(x',H,Y,alpha(i),beta(m),gamma(p),nv,indx_labeled);
            t=toc;
            record = record.add_history(struct('acc', result(1), 'kappa', result(2), 'nmi', result(3), 'ari', result(4), 'Purity', result(5),'time', t, 'ca', ca, 'y_pre', y_pre));
            fprintf('result:\t%12.6f %12.6f %12.6f %12.6f %12.6f\n',[result]);
            % dlmwrite('Caltech101-7.txt',[numanchor(j) alpha(i) beta(m) gamma(p) result t],'-append','delimiter','\t','newline','pc');
            
            
        end
    end
    end
end
best = record.best_result('acc');
disp(best);
% 将结果保存为mat
save('result.mat','best')