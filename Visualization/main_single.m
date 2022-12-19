% path = "./mat";
% myFiles = dir(fullfile(path, "*.mat"));
% for k = 1:length(myFiles)
%     baseFileName = myFiles(k).name;
%     fullFileName = fullfile(path, baseFileName);
% end
% clear
% clc
input = "../data/HC_001.mat";
distance_tap = feature_calculation(input, 15, 0);

[~,~,~,amp, t] = subfigure_helper(distance_tap, 'on');

