close all; 
clear variables; 
clc;

% Leave-one-participant-out (LOPO) cross validation
dataset_type = 'C';
if dataset_type == 'A';     dataset_name = '\Dataset A';
elseif dataset_type == 'B'; dataset_name = '\Dataset B';
elseif dataset_type == 'C'; dataset_name = '\Dataset C';
elseif dataset_type == 'D'; dataset_name = '\Dataset D';
end

output_path = strcat(pwd,dataset_name,'\lopo cv dataset\');
if ~exist(output_path, 'dir')
    mkdir(output_path);
end

input_file = strcat(pwd,dataset_name,'\feature\JSE_feature.mat');
output_file = strcat(output_path,'lopo_dataset.mat');

load(input_file);
    
LOPO = {};

idx = cell2mat(dataset(:,1));
data = dataset(:,2);
person_list = transpose(unique(idx));
for p = person_list
    training_dataset = [];
    for k = transpose(find(idx ~= p))
        training_dataset = [training_dataset; data{k}];
    end
    
    testing_dataset = [];
    for k = transpose(find(idx == p))
        testing_dataset = [testing_dataset; data{k}];
    end
    LOPO(p,:) = {p, training_dataset, testing_dataset};
end

save(output_file, 'LOPO');