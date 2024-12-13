function ca = class_acc(y_true, y_pre)
    % CLASS_ACC Calculate accuracy for each class.
    % Input:
    %   y_true: Ground truth labels (vector)
    %   y_pre: Predicted labels (vector)
    % Output:
    %   ca: Array of accuracies for each class
    
    % 获取所有唯一类别
    classes = unique(y_true);
    
    % 初始化结果数组
    ca = zeros(length(classes), 1);
    
    % 遍历每个类别，计算分类准确率
    for i = 1:length(classes)
        c = classes(i);
        
        % 找到当前类别的索引
        indices = (y_true == c);
        
        % 提取当前类别的真实标签和预测标签
        y_c = y_true(indices);
        y_c_p = y_pre(indices);
        
        % 计算当前类别的准确率
        accuracy = sum(y_c == y_c_p) / length(y_c);
        ca(i) = accuracy;
    end
    end
    