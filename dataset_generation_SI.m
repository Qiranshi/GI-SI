%% Load optical model in CodeV. Test model: 'lens\cassrc_2M.seq'
current_folder = pwd;
model_path  = '\lens\cassrc_2M.seq';
full_path = fullfile(current_folder,model_path);
cvon;
cvin(full_path);

%% Load misalignments of the GI-aligned systems
label_file = fullfile(current_folder,'\data\GI_dataset_example.mat');
load(label_file)
prediction_file = fullfile(current_folder,'\data\network_predicted_misalignments_for_GI.mat');
load(prediction_file)

%% Set parameters
datanum = 100; % data number of training dataset
train_data = zeros(datanum,5); % 5 is the number of DOFs needed to be aligned
train_label = train_label - network_predicted_misaligments; % misalignments of the GI-aligned systems
alignment_field = 1;

%% Get sensitivity matrix and the nominal WFE
read_sensitivity
nominal_wfe = getZernike_choose_field(alignment_field);

%% Dataset generation
for i = 1:datanum
    % input misalignments in CodeV, generating an IMS
    label = train_label(i,:);
    inputMisalignment_dof5(label);
    % read the Zernike coefficients of the IMS
    zernike_data = getZernike_choose_field(alignment_field);
    SM_approximate = sen_cal(zernike_data(5:36),sensitivity_temp_matrix(5:36,:),nominal_wfe(5:36));
    train_data(i,:) = SM_approximate';
    i
end
cvoff;