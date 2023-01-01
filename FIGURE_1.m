% FIGURE 1 in the paper
close all;
clear variables; 
clc;

input_file = strcat(pwd,'\Dataset B\feature\JSE_feature.mat');
load(input_file);
    
male = [];
female = [];

idx = cell2mat(dataset(:,1));
data = dataset(:,2);
for p = 1:1:size(dataset,1)
    feature = data{p};
    if feature(end) == 0     % male
        male = [male; feature(1,1:end-1)];
    elseif feature(end) == 1 % female
        female = [female; feature(1,1:end-1)];
    end
end

V1 = [male(:, 1); female(:, 1); male(:, 2); female(:, 2); male(:,14); female(:,14);
      male(:,15); female(:,15); male(:,16); female(:,16); male(:,17); female(:,17)];
V2 = [male(:,37); female(:,37); male(:,38); female(:,38); male(:,39); female(:,39);
      male(:,40); female(:,40); male(:,46); female(:,46); male(:,47); female(:,47)]; 
 
g = [zeros(length(male(:,1)),1); ones(length(female(:,1)),1);
     2*ones(length(male(:,2)),1); 3*ones(length(female(:,2)),1);
     4*ones(length(male(:,3)),1); 5*ones(length(female(:,3)),1);
     6*ones(length(male(:,4)),1); 7*ones(length(female(:,4)),1);
     8*ones(length(male(:,5)),1); 9*ones(length(female(:,5)),1);
     10*ones(length(male(:,6)),1); 11*ones(length(female(:,6)),1)];

figure();
h = boxplot(V1, g,'Notch','on','Symbol','k*',...
    'ColorGroup',g, 'Labels',{'','','','','','','','','','','',''});

c1 = [241/255 85/255 98/255];
c2 = [20/255 160/255 219/255];
color = [c1; c2];

o1 = findobj(h,'Tag','Outliers');
set(o1,'Visible','off');

box_vars = findall(h,'Tag','Box');
for j = 1:length(h)
   patch(get(box_vars(j),'XData'),get(box_vars(j),'YData'),...
       color(mod(j,2)+1,:),'FaceAlpha',.7,...
       'EdgeColor','k');
end
lines = findobj(gcf,'type','line','Tag','Median');
set(lines,'linewidth',2,'Color','k');
ylabel('Join Swing Energy (cm)');

figure();
k = boxplot(V2, g,'Notch','on','Symbol','k*',...
    'ColorGroup',g, 'Labels',{'','','','','','','','','','','',''});

o2 = findobj(k,'Tag','Outliers');
set(o2,'Visible','off');

box_vars = findall(k,'Tag','Box');
for j = 1:length(k)
   patch(get(box_vars(j),'XData'),get(box_vars(j),'YData'),...
       color(mod(j,2)+1,:),'FaceAlpha',.7,...
       'EdgeColor','k');
end
lines = findobj(gcf,'type','line','Tag','Median');
set(lines,'linewidth',2,'Color','k');
ylabel('Join Swing Energy (cm)');