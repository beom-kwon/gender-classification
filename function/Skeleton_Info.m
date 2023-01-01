function [num_joints, limb_info] = Skeleton_Info(kinect_ver)
if kinect_ver == 1
    num_joints = 20;
    limb_info = [02,03; % 01. shoulder right 
                 03,05; % 02. arm right
                 05,07; % 03. forearm right
                 07,09; % 04. hand right
                 12,13; % 05. hip right
                 13,15; % 06. thigh right
                 15,17; % 07. leg right
                 17,19; % 08. foot right
                 01,02; % 09. neck
                 02,11; % 10. upper spine
                 11,12; % 11. lower spine
                 02,04; % 12. shoulder left
                 04,06; % 13. arm left
                 06,08; % 14. forearm left
                 08,10; % 15. hand left
                 12,14; % 16. hip left
                 14,16; % 17. thigh left
                 16,18; % 18. leg left
                 18,20]; % 19. foot left
elseif kinect_ver == 2
    num_joints = 25;
    limb_info = [01,02; % 01. R_shoulder - R_elbow
                 02,03; % 02. R_elbow - R_wrist
                 03,04; % 03. R_wrist - R_hand
                 04,05; % 04. R_hand - R_hand_tip
                 05,06; % 05. R_hand_tip - R_thumb
                 07,08; % 06. R_hip - R_knee
                 08,09; % 07. R_knee - R_ankle
                 09,10; % 08. R_ankle - R_foot
                 11,12; % 09. L_shoulder - L_elbow
                 12,13; % 10. L_elbow - L_wrist
                 13,14; % 11. L_wrist - L_hand
                 14,15; % 12. L_hand - L_hand_tip
                 15,16; % 13. L_hand_tip - L_thumb
                 17,18; % 14. L_hip - L_knee
                 18,19; % 15. L_knee - L_ankle
                 19,20; % 16. L_ankle - L_foot
                 21,22; % 17. head - neck
                 22,23; % 18. neck - spine_shoulder
                 23,24; % 19. spine_shoulder - spine_mid
                 24,25; % 20. spine_mid - spine_base
                 01,23; % 21. R_shoulder - spine_shoulder
                 11,23; % 22. L_shoulder - spine_shoulder
                 07,25; % 23. R_hip - spine_base
                 17,25]; % 24. L_hip - spine_base
end
end
