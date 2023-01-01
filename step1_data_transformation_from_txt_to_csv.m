close all;
clear variables;
clc;

dataset_path_in = strcat(pwd,'\Dataset A\kinect gait raw dataset\');
dataset_path_out = strcat(pwd,'\Dataset A\kinect gait csv dataset\');
if ~exist(dataset_path_out, 'dir')
    mkdir(dataset_path_out);
end

person_list = dir(dataset_path_in);
p_max = length(person_list);

num_joints = 20; % Kinect V1
for p = 3:1:p_max
    person_path_in = strcat(dataset_path_in, person_list(p).name);
    person_path_out = strcat(dataset_path_out, person_list(p).name);
    if ~exist(person_path_out, 'dir')
        mkdir(person_path_out);
    end
    fprintf('%d / %d\n', (p-2),(p_max-2));
    walk_list = dir(person_path_in);
    w_max = length(walk_list);
    for w = 3:1:w_max
        file_path_in = strcat(person_path_in,'\',walk_list(w).name);
        file_path_out = strcat(person_path_out,'\',strrep(walk_list(w).name,'txt','csv'));
        fileID = fopen(file_path_in,'r');
        txt = textscan(fileID,'%s','delimiter','\n');
        fclose(fileID);
        txt = txt{1};
        sklt = [];
        for line = 1:1:size(txt,1)
            A = strsplit(txt{line},';');
            val1 = A{1};             % joint name
            val2 = str2double(A{2}); % x-coordinate
            val3 = str2double(A{3}); % y-coordinate
            val4 = str2double(A{4}); % z-coordinate
            sklt = [sklt val2 val3 val4];
        end
        sklt = reshape(sklt,3*num_joints,size(txt,1)/num_joints);
        sklt = sklt';
        csvwrite(file_path_out, sklt);
    end
end