close all;
clear variables;
clc;

dataset_type = 'D';
if dataset_type == 'A';     dataset_name = '\Dataset A';
elseif dataset_type == 'B'; dataset_name = '\Dataset B';
elseif dataset_type == 'C'; dataset_name = '\Dataset C';
elseif dataset_type == 'D'; dataset_name = '\Dataset D';
end

output_path = strcat(pwd,dataset_name,'\trained_model\');
if ~exist(output_path, 'dir')
    mkdir(output_path);
end

input_file  = strcat(pwd,dataset_name,'\lopo cv dataset\lopo_dataset.mat');
output_file = strcat(output_path,'fitcsvm_JSE.mat');

load(input_file);

optimized_model = {};
cnt = 0;
person_list = transpose(cell2mat(LOPO(:,1)));
training_dataset = LOPO(:,2);
for p = person_list
    tic
    fprintf("%d / %d\n", p, max(person_list));
    training = training_dataset{p};
    
    Y = training(:,size(training,2));     % label
    X = training(:,1:size(training,2)-1); % features
    
    svm_model = fitcsvm(X,Y,'OptimizeHyperparameters','all',...
        'HyperparameterOptimizationOptions',...
        struct('AcquisitionFunctionName','expected-improvement-plus',...
        'Verbose',0,'ShowPlots',0));
    
%     svm_model = compact(svm_model); % If you use MATLAB R2020b
    cnt = cnt + 1;
    optimized_model(cnt,:) = {p,svm_model};
    toc
end
save(output_file,'optimized_model');