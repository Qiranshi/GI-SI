%% Get the RMS WFE values of the aligned systems
%  suitable for evaluate GI/GI-SI/GI-SI-SM
%% Load optical model in CodeV. Test model: 'lens\cassrc_2M.seq'
current_folder = pwd;
model_path  = '\lens\cassrc_2M.seq';
full_path = fullfile(current_folder,model_path);
cvon;
cvin(full_path);
alignment_field = 1;

%% Load misalignment labels and the network predicted misalignments
    % Evalution for the GI method
    label_file = fullfile(current_folder,'\data\GI_dataset_example.mat');
    load(label_file)
    prediction_file = fullfile(current_folder,'\data\network_predicted_misalignments_for_GI.mat');
    load(prediction_file)
%     % Evalution for the GI-SI method
%     label_file = fullfile(current_folder,'\data\SI_dataset_example.mat');
%     load(label_file)
%     prediction_file = fullfile(current_folder,'\data\network_predicted_misalignments_for_SI.mat');
%     load(prediction_file)
%     % Evalution for the GI-SI-SM method
%     label_file = fullfile(current_folder,'\data\SM_dataset_example.mat');
%     load(label_file)
%     prediction_file = fullfile(current_folder,'\data\network_predicted_misalignments_for_SM.mat');
%     load(prediction_file) 
%% Set parameters
datanum = 100;
WFE_record = ones(1,datanum);

%% Get RMS WFE values and record them in WFE_record
for i = 1:datanum
    % Caluculate misalignments for an aligned system
    misalignment = train_label(i,:) - network_predicted_misaligments(i,:);
    inputMisalignment_dof5(misalignment);
    % Get the RMS WFE for the aligned system
    field_map = getWFE();
    WFE_record(1,i) =str2double(field_map(18,15:22));
    WFE_record(1,i)
    i
end
cvoff;