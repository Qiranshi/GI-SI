%load_presets;
clc
current_folder = pwd;
model_path  = '\lens\cassrc_2M.seq';
full_path = fullfile(current_folder,model_path);
cvon;
cvin(full_path);
zoom_number=1;
for i=1:zoom_number-1
    cvcmd('DEL Z0+1');
end

field = 1; % Modify the alignment field if needed
surf_idx = [2];% Modify the surfaces you need to calculate
cvcmd('BUF DEL B0; BUF DEL B1;');
for surf_cnt = 1: length(surf_idx)
    cvcmd(['BUF PUT B1 I',int2str(surf_cnt),' J1..6 (XDE S', int2str(surf_idx(surf_cnt)),') (YDE S', int2str(surf_idx(surf_cnt)),') (ZDE S', int2str(surf_idx(surf_cnt)),') (ADE S', int2str(surf_idx(surf_cnt)),') (BDE S', int2str(surf_idx(surf_cnt)),') (CDE S', int2str(surf_idx(surf_cnt)),')']);
end
decenterAll.initial = cvbuf(1, 1:length(surf_idx), 1:6);

%%计算每个自由度灵敏度
wfe_nominal = getZernike_choose_field(field);
dof_idx = ['XDE';'YDE';'ZDE';'ADE';'BDE']; % 考虑列表中的自由度
l=length(dof_idx);
dof_num = length(surf_idx) * length(dof_idx);
dof_range = [0.001 0.001 0.001 0.001 0.001 0.001];
sensitivity_plus_matrix = zeros(36,dof_num);
sensitivity_minus_matrix = zeros(36,dof_num);
sensitivity_temp_matrix = zeros(36,dof_num);
for surf_cnt = 1: length(surf_idx)
    for dof_cnt = 1: length(dof_idx)
        cvcmd([dof_idx(dof_cnt,:) ' S' num2str(surf_idx(surf_cnt)) ' ' num2str(dof_range(dof_cnt) + decenterAll.initial(surf_cnt,dof_cnt))]);
        sensitivity_plus_matrix(:,dof_cnt + l * (surf_cnt-1)) = (getZernike_choose_field(field)) ;
        cvcmd([dof_idx(dof_cnt,:) ' S' num2str(surf_idx(surf_cnt)) ' ' num2str(-dof_range(dof_cnt) + decenterAll.initial(surf_cnt,dof_cnt))]);
        sensitivity_minus_matrix(:,dof_cnt +l * (surf_cnt-1)) = (getZernike_choose_field(field));
        cvcmd([dof_idx(dof_cnt,:) ' S' num2str(surf_idx(surf_cnt)) ' ' num2str(decenterAll.initial(surf_cnt,dof_cnt))]);
        sensitivity_temp_matrix(:,dof_cnt +l * (surf_cnt-1)) = (sensitivity_plus_matrix(:,dof_cnt + l * (surf_cnt-1)) - sensitivity_minus_matrix(:,dof_cnt + 5 * (surf_cnt-1))) ./(2*dof_range(dof_cnt));
    end
end

% %%
% % close all
% figure
% sumall=sum(sensitivity_temp_matrix);
% close all
% cmap=colormap("cool");
% s1=1;
% e1=0.99;
% s2=0.1;
% e2=0.9;
% s3=0.6;
% e3=0.61;
% cmap(:,1)=s1:(e1-s1)/255:e1;
% cmap(:,2)=s2:(e2-s2)/255:e2;
% cmap(:,3)=s3:(e3-s3)/255:e3;
% bar_num=length(sumall);%柱子数量
% map_length=length(cmap);
% Step=floor(map_length/bar_num);
% for i=1:length(sumall)
%     bar(i,sumall(i)','BarWidth',0.6,'facecolor',cmap(i*Step,:))
%     hold on
% end
% grid off
% xticks(0:1:bar_num);
% figure
% bar(sensitivity_temp_matrix','BarWidth',1)
% grid on
