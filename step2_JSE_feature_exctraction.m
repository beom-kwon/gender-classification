close all;
clear;
clc;

addpath 'function';

dataset_type = 'A'; % <-- Control parameter

if dataset_type == 'A';     dataset_name = '\Dataset A'; kinect_ver = 1;
elseif dataset_type == 'B'; dataset_name = '\Dataset B'; kinect_ver = 2;
elseif dataset_type == 'C'; dataset_name = '\Dataset C'; kinect_ver = 1;
elseif dataset_type == 'D'; dataset_name = '\Dataset D'; kinect_ver = 2;
end

[num_joints, limb_info] = Skeleton_Info(1);

dataset_path_in = strcat(pwd,dataset_name,'\kinect gait csv dataset\');
dataset_path_out = strcat(pwd,dataset_name,'\feature\');
if ~exist(dataset_path_out, 'dir')
    mkdir(dataset_path_out);
end

if dataset_type == 'A'
    gender_info_path_in = strcat(pwd, '\Dataset A\person-data.csv');
    gender = readtable(gender_info_path_in, 'HeaderLines', 1);

    person_lists = dir(dataset_path_in);
    p_max = length(person_lists);
    dataset = {};
    idx = 1;
    for p = 3:1:p_max
        person_path_in = strcat(dataset_path_in, person_lists(p).name);        
        if contains(gender{p-2, 5}, 'M')
            label = 0; % Male
        elseif contains(gender{p-2, 5}, 'F')
            label = 1; % Female
        end

        walk_list = dir(person_path_in);
        w_max = length(walk_list);
        for w = 3:1:w_max
            file_path_in = strcat(person_path_in,'\',walk_list(w).name);
            motion = importdata(file_path_in);

            D_T = zeros(size(motion,1),17); % Transverse plane
            D_F = zeros(size(motion,1),17); % Frontal plane
            D_M = zeros(size(motion,1),17); % Median plane
            for frm = 1:1:size(motion,1)
                pose = reshape(motion(frm,:),3,num_joints)'; % current pose
                pose = [pose(:,3) pose(:,1) pose(:,2)];
                % Target Joint of this feature
                % 1	Head
                % 2	Shoulder-Center
                % 3	Shoulder-Right
                % 4	Shoulder-Left
                % 5	Elbow-Right
                % 6	Elbow-Left
                % 7	Wrist-Right
                % 8	Wrist-Left
                % 9	Hand-Right
                %10	Hand-Left
                %11	Spine
                %12	Hip-centro <--- Not target
                %13	Hip-Right  <--- Not target
                %14	Hip-Left   <--- Not target
                %15	Knee-Right
                %16	Knee-Left
                %17	Ankle-Right
                %18	Ankle-Left
                %19	Foot-Right
                %20	Foot-Left

                J = [1:1:11, 15:1:20];
                cnt = 1;
                for j_idx = J
                    D_T(frm, cnt) = cal_dist_T(pose, j_idx);
                    D_F(frm, cnt) = cal_dist_F(pose, j_idx);
                    D_M(frm, cnt) = cal_dist_M(pose, j_idx);
                    cnt = cnt + 1;
                end
            end
            % NaN check
            for frm = size(motion,1):-1:1
                if sum(isnan(D_T(frm,:))) ~= 0; D_T(frm,:) = []; end
                if sum(isnan(D_F(frm,:))) ~= 0; D_F(frm,:) = []; end
                if sum(isnan(D_M(frm,:))) ~= 0; D_M(frm,:) = []; end
            end
            R_T = mean(D_T);
            R_F = mean(D_F);
            R_M = mean(D_M);

            JSE = [R_T R_F R_M];

            data = [JSE, label];
            
            dataset(idx,:) = {p-2, data};
            idx = idx + 1;
        end
    end
    save(strcat(dataset_path_out,'JSE_feature.mat'), 'dataset');
elseif dataset_type == 'B'
    gender_info_path_in = strcat(pwd,dataset_name,'\1_Participants information.csv');
    raw = importdata(gender_info_path_in);
    gender = raw.textdata(:,4);
    person_lists = dir(dataset_path_in);
    p_max = length(person_lists);
    dataset = {};
    idx = 1;
    for p = 3:1:p_max
        file_path_in = strcat(dataset_path_in, person_lists(p).name);
        if contains(gender{p-1}, 'MASCULINO')
            label = 0; % Male
        elseif contains(gender{p-1}, 'FEMENIN')
            label = 1; % Female
        end

        raw = importdata(file_path_in);
        motion_v2 = raw.data(:,2:1:76); % kinect v2
        re_arr = [3*21-2:3*21, ... % 01. Head
                  3*23-2:3*23, ... % 02. Spine Shoulder (Shoulder-Center)
                  3*1-2:3*1, ...   % 03. R-Shoulder 
                  3*11-2:3*11, ... % 04. L-Shoulder    
                  3*2-2:3*2, ...   % 05. R-Elbow
                  3*12-2:3*12, ... % 06. L-Elbow
                  3*3-2:3*3, ...   % 07. R-Wrist
                  3*13-2:3*13, ... % 08. L-Wrist
                  3*4-2:3*4, ...   % 09. R-Hand
                  3*14-2:3*14, ... % 10. L-Hand
                  3*24-2:3*24, ... % 11. Spine mid (Spine)
                  3*25-2:3*25, ... % 12. Spine Base (Hip-centro)
                  3*7-2:3*7, ...   % 13. R-Hip
                  3*17-2:3*17, ... % 14. L-Hip
                  3*8-2:3*8, ...   % 15. R-Knee
                  3*18-2:3*18, ... % 16. L-Knee
                  3*9-2:3*9, ...   % 17. R-Ankle
                  3*19-2:3*19, ... % 18. L-Ankle
                  3*10-2:3*10, ... % 19. R-Foot
                  3*20-2:3*20];    % 20. L-Foot
        
        motion = motion_v2(:,re_arr);
        frame_len = size(motion,1);
        D_T = zeros(frame_len,17); % Transverse plane
        D_F = zeros(frame_len,17); % Frontal plane
        D_M = zeros(frame_len,17); % Median plane
        for frm = 1:1:frame_len
            pose = reshape(motion(frm,:),3,num_joints)'; % current pose
            pose = [pose(:,3) pose(:,1) pose(:,2)];

            J = [1:1:11, 15:1:20];
            cnt = 1;
            for j_idx = J
                D_T(frm, cnt) = cal_dist_T(pose, j_idx);
                D_F(frm, cnt) = cal_dist_F(pose, j_idx);
                D_M(frm, cnt) = cal_dist_M(pose, j_idx);
                cnt = cnt + 1;
            end
        end
        % NaN check
        for frm = frame_len:-1:1
            if sum(isnan(D_T(frm,:))) ~= 0; D_T(frm,:) = []; end
            if sum(isnan(D_F(frm,:))) ~= 0; D_F(frm,:) = []; end
            if sum(isnan(D_M(frm,:))) ~= 0; D_M(frm,:) = []; end
        end
        R_T = mean(D_T);
        R_F = mean(D_F);
        R_M = mean(D_M);

        JSE = [R_T, R_F, R_M];

        data = [JSE, label];
        
        dataset(idx,:) = {p-2, data};
        idx = idx + 1;
    end
    save(strcat(dataset_path_out,'JSE_feature.mat'), 'dataset');
elseif dataset_type == 'C'
    load(strcat(pwd,dataset_name,'\MatlabFormat\UPCVgait.mat'));
    dataset = {};
    idx = 1;
    for p = 1:1:30
        if p <= 15
            label = 0; % first 15 persons are male
        else
            label = 1; % last 15 persons are female
        end
        for w = 1:1:5
            seg = upcv{p,w};
            whole_len = size(seg,1)/20;
            motion_tmp = zeros(whole_len,60);
            for len = 1:1:whole_len
                motion_tmp(len,:) = reshape(seg(20*len-19:20*len,:)', [1,60]);
            end
            
            re_arr = [3*1-2:3*1, ... % 01. Head
                  3*2-2:3*2, ...   % 02. C-Shoulder
                  3*3-2:3*3, ...   % 03. R-Shoulder 
                  3*4-2:3*4, ...   % 04. L-Shoulder    
                  3*8-2:3*8, ...   % 05. R-Elbow
                  3*5-2:3*5, ...   % 06. L-Elbow
                  3*9-2:3*9, ...   % 07. R-Wrist
                  3*6-2:3*6, ...   % 08. L-Wrist
                  3*10-2:3*10, ... % 09. R-Hand
                  3*7-2:3*7, ...   % 10. L-Hand
                  3*11-2:3*11, ... % 11. Spine
                  3*12-2:3*12, ... % 12. C-Hip
                  3*13-2:3*13, ... % 13. R-Hip
                  3*14-2:3*14, ... % 14. L-Hip
                  3*18-2:3*18, ... % 15. R-Knee
                  3*15-2:3*15, ... % 16. L-Knee
                  3*19-2:3*19, ... % 17. R-Ankle
                  3*16-2:3*16, ... % 18. L-Ankle
                  3*20-2:3*20, ... % 19. R-Foot
                  3*17-2:3*17];    % 20. L-Foot
            
            motion = motion_tmp(:,re_arr);
            
            D_T = zeros(size(motion,1),17); % Transverse plane
            D_F = zeros(size(motion,1),17); % Frontal plane
            D_M = zeros(size(motion,1),17); % Median plane
            for frm = 1:1:size(motion,1)
                pose = reshape(motion(frm,:),3,num_joints)'; % current pose
                pose = [pose(:,3) pose(:,1) pose(:,2)];
                J = [1:1:11, 15:1:20];
                cnt = 1;
                for j_idx = J
                    D_T(frm, cnt) = cal_dist_T(pose, j_idx);
                    D_F(frm, cnt) = cal_dist_F(pose, j_idx);
                    D_M(frm, cnt) = cal_dist_M(pose, j_idx);
                    cnt = cnt + 1;
                end
            end
            % NaN check
            for frm = size(motion,1):-1:1
                if sum(isnan(D_T(frm,:))) ~= 0; D_T(frm,:) = []; end
                if sum(isnan(D_F(frm,:))) ~= 0; D_F(frm,:) = []; end
                if sum(isnan(D_M(frm,:))) ~= 0; D_M(frm,:) = []; end
            end
            R_T = mean(D_T);
            R_F = mean(D_F);
            R_M = mean(D_M);

            JSE = [R_T, R_F, R_M];

            dataset(idx,:) = {p,[JSE, label]};
            idx = idx + 1;
        end
    end
    save(strcat(dataset_path_out,'JSE_feature.mat'), 'dataset');
elseif dataset_type == 'D'
    load(strcat(pwd,dataset_name,'\MatlabFormat\KinectK2gait.mat'));
    upcv2 = data; clear data;
    dataset = {};
    idx = 1;
    for p = 1:1:30
        if gender(p,1) == 0
            label = 0; % male
        else
            label = 1; % female
        end
        for w = 1:1:10
            td = upcv2{p,w};
            whole_len = size(td,1)/25;
            motion_v2 = zeros(whole_len,75);
            for len = 1:1:whole_len
                motion_v2(len,:) = reshape(td(25*len-24:25*len,:)', [1,75]);
            end
            re_arr = [3*4-2:3*4, ... % 01. Head
                  3*21-2:3*21, ... % 02. Spine Shoulder (Shoulder-Center)
                  3*5-2:3*5, ...   % 03. R-Shoulder 
                  3*9-2:3*9, ...   % 04. L-Shoulder    
                  3*6-2:3*6, ...   % 05. R-Elbow
                  3*10-2:3*10, ... % 06. L-Elbow
                  3*7-2:3*7, ...   % 07. R-Wrist
                  3*11-2:3*11, ... % 08. L-Wrist
                  3*8-2:3*8, ...   % 09. R-Hand
                  3*12-2:3*12, ... % 10. L-Hand
                  3*2-2:3*2, ...   % 11. Spine mid (Spine)
                  3*1-2:3*1, ...   % 12. Spine Base (Hip-centro)
                  3*13-2:3*13, ... % 13. R-Hip
                  3*17-2:3*17, ... % 14. L-Hip
                  3*14-2:3*14, ... % 15. R-Knee
                  3*18-2:3*18, ... % 16. L-Knee
                  3*15-2:3*15, ... % 17. R-Ankle
                  3*19-2:3*19, ... % 18. L-Ankle
                  3*16-2:3*16, ... % 19. R-Foot
                  3*20-2:3*20];    % 20. L-Foot
            
            motion = motion_v2(:,re_arr);
            
            D_T = zeros(size(motion,1),17); % Transverse plane
            D_F = zeros(size(motion,1),17); % Frontal plane
            D_M = zeros(size(motion,1),17); % Median plane
            for frm = 1:1:size(motion,1)
                pose = reshape(motion(frm,:),3,num_joints)'; % current pose
                pose = [pose(:,3) pose(:,1) pose(:,2)];
                J = [1:1:11, 15:1:20];

                cnt = 1;
                for j_idx = J
                    D_T(frm, cnt) = cal_dist_T(pose, j_idx);
                    D_F(frm, cnt) = cal_dist_F(pose, j_idx);
                    D_M(frm, cnt) = cal_dist_M(pose, j_idx);
                    cnt = cnt + 1;
                end
            end
            % NaN check
            for frm = size(motion,1):-1:1
                if sum(isnan(D_T(frm,:))) ~= 0; D_T(frm,:) = []; end
                if sum(isnan(D_F(frm,:))) ~= 0; D_F(frm,:) = []; end
                if sum(isnan(D_M(frm,:))) ~= 0; D_M(frm,:) = []; end
            end
            R_T = mean(D_T);
            R_F = mean(D_F);
            R_M = mean(D_M);

            JSE = [R_T, R_F, R_M];

            dataset(idx,:) = {p,[JSE, label]};
            idx = idx + 1;
        end
    end
    save(strcat(dataset_path_out,'JSE_feature.mat'), 'dataset');
end
rmpath 'function';

function dist = cal_dist_T(pose, idx)
dist = abs(pose(12, 3) - pose(idx, 3));
end

function dist = cal_dist_F(pose, idx)
numerator = abs((pose(14,2)-pose(13,2))*(pose(idx,1)-pose(12,1)) +...
                (pose(13,1)-pose(14,1))*(pose(idx,2)-pose(12,2)));
denominator = sqrt((pose(14,2)-pose(13,2))^2 + (pose(13,1)-pose(14,1))^2);

dist = numerator / denominator;
end

function dist = cal_dist_M(pose, idx)
numerator = abs((pose(14,1)-pose(13,1))*(pose(idx,1)-pose(12,1)) + ...
                (pose(14,2)-pose(13,2))*(pose(idx,2)-pose(12,2)) + ...
                (pose(14,3)-pose(13,3))*(pose(idx,3)-pose(12,3)));
denominator = sqrt((pose(14,1)-pose(13,1))^2 + ...
                   (pose(14,2)-pose(13,2))^2 + ...
                   (pose(14,3)-pose(13,3))^2);
dist = numerator / denominator;
end