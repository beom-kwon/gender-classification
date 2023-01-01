clear variables;
close all;
clc;

addpath 'function';

dataset_type = 'A';
if dataset_type == 'A';     dataset_name = '\Dataset A';
elseif dataset_type == 'B'; dataset_name = '\Dataset B';
elseif dataset_type == 'C'; dataset_name = '\Dataset C';
elseif dataset_type == 'D'; dataset_name = '\Dataset D';
end

output_path = strcat(pwd,dataset_name,'\results\');
if ~exist(output_path, 'dir')
    mkdir(output_path);
end

input_file1 = strcat(pwd,dataset_name,'\lopo cv dataset\lopo_dataset.mat');
input_file2 = strcat(pwd,dataset_name,'\trained_model\fitcsvm_JSE.mat');
output_file = strcat(output_path,'results_fitcsvm_JSE.mat');

load(input_file1); % LOPO
load(input_file2); % optimized_model

person_list = transpose(cell2mat(LOPO(:,1)));
GT = [];
PRED = [];
for p = person_list
    % Load testing dataset
    testing = LOPO{p,3};
    
    Y = testing(:,size(testing,2));   % label
    X = testing(:,1:1:size(testing,2)-1); % features

    svm_model = optimized_model{p,2};

    [label, score, cost] = predict(svm_model, X);
    
    GT = [GT; Y];
    PRED = [PRED; label];
end

% label (0: Male, 1: Female)
CF = confusion_matrix(PRED, GT);

ACC = (CF(1,1) + CF(2,2)) / (sum(sum(CF))) * 100;
TPR = CF(1,1) / (CF(1,1) + CF(2,1)) * 100;
PPV = CF(1,1) / (CF(1,1) + CF(1,2)) * 100;
TNR = CF(2,2) / (CF(1,2) + CF(2,2)) * 100;
NPV = CF(2,2) / (CF(2,1) + CF(2,2)) * 100;

save(output_file, 'CF', 'ACC', 'TPR', 'PPV', 'TNR', 'NPV');

fprintf(strcat('< Dataset', dataset_type, ' >\n'));
fprintf('ACC: %.2f\n', ACC);
fprintf('TPR: %.2f\n', TPR);
fprintf('PPV: %.2f\n', PPV);
fprintf('TNR: %.2f\n', TNR);
fprintf('NPV: %.2f\n', NPV);

rmpath 'function';