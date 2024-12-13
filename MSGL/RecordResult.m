classdef RecordResult
    properties
        results_history % 用于存储所有的结果历史
    end
    
    methods
        % 构造函数
        function obj = RecordResult()
            obj.results_history = {}; % 初始化为一个空 cell 数组
        end
        
        % 添加历史记录
        function obj = add_history(obj, result_history)
            % 将新结果添加到历史记录中
            obj.results_history{end + 1} = result_history; 
        end
        
        % 获取最佳结果
        function best_result = best_result(obj, metric)
            % 检查是否有历史记录
            if isempty(obj.results_history)
                error('No results history to evaluate.');
            end
            
            % 遍历所有结果，提取 metric 的最大值
            metrics_values = cellfun(@(x) x.(metric), obj.results_history);
            [~, best_index] = max(metrics_values); % 找到最大值的索引
            best_result = obj.results_history{best_index}; % 返回最佳结果
        end
    end
end
