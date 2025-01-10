%% Load optical model in CodeV. Test model: 'lens\cassrc_2M.seq'
current_folder = pwd;
model_path  = '\lens\cassrc_2M.seq';
full_path = fullfile(current_folder,model_path);
cvon;
cvin(full_path);

%% Set parameters
datanum = 100; % data number of training dataset
train_data = zeros(datanum,32 * 6); 
train_label = zeros(datanum,5); % 5 is the number of DOFs needed to be aligned
mis_decenter = 1; % misalignment range of decenter DOFs e.g mis_decenter = 1, range:[-0.5,0.5]
mis_tilt = 0.5; % misalignment range of tilt DOFs
increment = 0.05; % increment of PTSs
alignment_field = 1;

%% Generate misalignments for all the IMSs using the Monte Carlo method
rng('shuffle');
x_decenter2 = (rand([1 datanum])-0.5)*mis_decenter;
rng('shuffle');
y_decenter2 = (rand([1 datanum])-0.5)*mis_decenter;
rng('shuffle');
z_decenter2 = (rand([1 datanum])-0.5)*mis_decenter; 
rng('shuffle');
x_tilt2 = (rand([1 datanum])-0.5)*mis_tilt;
rng('shuffle');
y_tilt2 = (rand([1 datanum])-0.5)*mis_tilt;


%% Dataset generation
for i = 1:datanum
    % load a set of misalignments from above
    misalignment_dof5 = [x_decenter2(i) y_decenter2(i) z_decenter2(i) x_tilt2(i) y_tilt2(i)];
    % input misalignments in CodeV, generating an IMS
    inputMisalignment_dof5(misalignment_dof5);
    % read the Zernike coefficients of the IMS
    zernike_data = getZernike_choose_field(alignment_field);
    train_data(i,1:32) = zernike_data(5:36);
    for j = 1 : 5
        % generate a PTS along different DOFs
        misalignment_dof5(j) = misalignment_dof5(j) + increment;
        inputMisalignment_dof5(misalignment_dof5);
        % read the Zernike coefficients of the PTS 
        data = getZernike_choose_field(alignment_field);
        train_data(i,j * 32 + 1 : j * 32 + 32) = (data(5:36) - zernike_data(5:36));
    end
    train_label(i,:) = misalignment_dof5;
    i
end
cvoff;