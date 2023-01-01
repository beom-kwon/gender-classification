% TABLE 4 in the paper
close all;
clear variables;
clc;

dataset_type = 'A';
if dataset_type == 'A';     dataset_name = '\Dataset A';
elseif dataset_type == 'B'; dataset_name = '\Dataset B';
elseif dataset_type == 'C'; dataset_name = '\Dataset C';
elseif dataset_type == 'D'; dataset_name = '\Dataset D';
end

input_folder = strcat(pwd,dataset_name,'\results\');
results_lists = dir(input_folder);
file_num = length(results_lists);

TPR_results = [];
PPV_results = [];
for f = 3:1:file_num
    load(strcat(input_folder,results_lists(f).name));
    TPR_results = [TPR_results, TPR];
    PPV_results = [PPV_results, PPV];
    clear ACC CF NPV PPV TNR TPR;
end

% F1 = (1+beta^2) * TPR * PPV / (TPR + (beta^2 * PPV));
F1_results = zeros(4, 5);
cnt = 0;
for beta = [0.1, 0.5, 1, 1.5, 2]
    cnt = cnt + 1;
    for c = 1:1:4 % classifier
        F1_results(c, cnt) = (1+beta^2) * TPR_results(c) * PPV_results(c) /...
                             (TPR_results(c) + (beta^2 * PPV_results(c)));
    end
end

fprintf(strcat('< Dataset', dataset_type, ' >\n'));
fprintf('beta = 0.1\n');
fprintf('JSE-KNN: %.2f\n', F1_results(1,1));
fprintf('JSE-NB: %.2f\n',  F1_results(2,1));
fprintf('JSE-SVM: %.2f\n', F1_results(3,1));
fprintf('JSE-DT: %.2f\n',  F1_results(4,1));

fprintf('\nbeta = 0.5\n');
fprintf('JSE-KNN: %.2f\n', F1_results(1,2));
fprintf('JSE-NB: %.2f\n',  F1_results(2,2));
fprintf('JSE-SVM: %.2f\n', F1_results(3,2));
fprintf('JSE-DT: %.2f\n',  F1_results(4,2));

fprintf('\nbeta = 1\n');
fprintf('JSE-KNN: %.2f\n', F1_results(1,3));
fprintf('JSE-NB: %.2f\n',  F1_results(2,3));
fprintf('JSE-SVM: %.2f\n', F1_results(3,3));
fprintf('JSE-DT: %.2f\n',  F1_results(4,3));

fprintf('\nbeta = 1.5\n');
fprintf('JSE-KNN: %.2f\n', F1_results(1,4));
fprintf('JSE-NB: %.2f\n',  F1_results(2,4));
fprintf('JSE-SVM: %.2f\n', F1_results(3,4));
fprintf('JSE-DT: %.2f\n',  F1_results(4,4));

fprintf('\nbeta = 2\n');
fprintf('JSE-KNN: %.2f\n', F1_results(1,5));
fprintf('JSE-NB: %.2f\n',  F1_results(2,5));
fprintf('JSE-SVM: %.2f\n', F1_results(3,5));
fprintf('JSE-DT: %.2f\n',  F1_results(4,5));