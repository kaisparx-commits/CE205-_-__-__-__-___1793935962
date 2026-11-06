
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Supervised Machine Learning System 
% CE205
% Lab4
% Prepared By Dr. Zulfiqar
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clear % to clear worspace
clc % to clear command window
close all % close all figures

load fisheriris % load dataset

%$$$$$$$$$$$$$$$ Divide DATASet $$$$$$$$$$$$$$$$$$$$$$$
%---------------- Setosa --------------------------------
S_train=meas(1:30, 3:4); % first 30 samples of setosa
S_lab=species(1:30);

S_test=meas(31:50, 3:4); % remaining 20 samples of setosa
S_test_lab=species(1:30);


%---------------- Versicolor --------------------------------
V_train=meas(51:80, 3:4); % first 30 samples of versicolor
V_lab=species(51:80);

V_test=meas(81:100, 3:4); % remaining 20 samples of versicolor
V_test_lab=species(81:100);


%----------------- Verginca -----------------------------

G_train=meas(101:130, 3:4); % first 30 samples of versicolor
G_lab=species(101:130);

G_test=meas(101:130, 3:4); % remaining 20 samples of versicolor
G_test_lab=species(101:130);

%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$




%$$$$$$$$$$$$$$$ Generate Reference Models $$$$$$$$$$$$$$$$$$$$$

No_clusters=3; % you can change it
opts = statset('Display','final');

%-------- Generate model for the first class (setosa) -----------

[idxS,CS] = kmeans(S_train,No_clusters,'Options',opts);

%-------- Generate model for the second class (versicolor) -----------

[idxV,CV] = kmeans(V_train,No_clusters,'Options',opts);

%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


%------------ Visualise Clusters -------------------
color={'bd', 'b*', 'bo'};
figure;

for i=1:No_clusters
    x_axis=S_train(idxS==i,1);
    y_axis=S_train(idxS==i,2);
    plot(x_axis,y_axis,color{i},'MarkerSize',12)
    hold on
    plot(CS(i,1),CS(i,2),color{i},...
        'MarkerSize',15,'LineWidth',3)
    xlim([0 8])
    ylim([0 8])
    
    clear x_axis y_axis
end


color={'gd', 'g*', 'go'};

for i=1:No_clusters
    x_axis=V_train(idxV==i,1);
    y_axis=V_train(idxV==i,2);
    plot(x_axis,y_axis,color{i},'MarkerSize',12)
    hold on
    plot(CV(i,1),CV(i,2),color{i},...
        'MarkerSize',15,'LineWidth',3)
    xlim([0 8])
    ylim([0 8])
    
    clear x_axis y_axis
end
title 'Cluster Assignments and Centroids'
xlabel('Petal length');
ylabel('Petal width');

%----------------------------

%$$$$$$$ Consider a test sample and plot it $$$$$$
test_Sample=S_test(1,:);
plot(test_Sample(1,1),test_Sample(1,2), 'kx',...
    'MarkerSize',15,'LineWidth',3)


%$$$$$$ Compute distances with centriods of model of Setosa $$$$$
DS1  = sqrt(sum((test_Sample - CS(1,:)) .^ 2));
DS2  = sqrt(sum((test_Sample - CS(2,:)) .^ 2));
DS3  = sqrt(sum((test_Sample - CS(3,:)) .^ 2));
mDS=(DS1+DS2+DS3)/3;

%$$$$$$ Compute distances with centriods of model of verginica $$$$$
DV1  = sqrt(sum((test_Sample - CV(1,:)) .^ 2));
DV2  = sqrt(sum((test_Sample - CV(2,:)) .^ 2));
DV3  = sqrt(sum((test_Sample - CV(3,:)) .^ 2));
mDV=(DV1+DV2+DV3)/3;

%$$$$$$$$$$$$ Decision about test sample $$$$$$$$$$$$$$$
if mDS<mDV
    %if mean distance of test sample is smaller for setosa
    disp('Setoa') %
    
elseif mDV<mDS
    %if mean distance of test sample is smaller for verginica
    disp('Verginica')
end


hold off



