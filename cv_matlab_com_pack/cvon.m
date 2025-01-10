%CVON starts the COM link between Matlab and CODE V
%      and generates the workspace variable 'CodeV'
%
%   See also CVOFF, CVCMD, CVDB, CVIN, CVOPEN, CVSAVE 

if exist('CodeV','var')
    disp('CODE V appears to be running.');
    disp('This version of the CODE V toolkit runs only one instance of CodeV.'); 
    return
end

global CodeV %put global variable onto workspace
disp('Starting CODE V...');
CodeV = actxserver('CodeV.Command.110'); %start COM link
%************************！！！修改此处为本地CODEV文件夹位置！！！*****************************************
invoke(CodeV,'SetStartingDirectory','D:\Program_files\CODEV11'); %set current directory as starting directory
invoke(CodeV,'StartCodeV');%start session of CODE V

disp(['CodeV is now running version: ' invoke(CodeV,'GetCodeVVersion')]);

% Copyright ?2004-2005 United States Government as represented by the Administrator of the 
% National Aeronautics and Space Administration.  No copyright is claimed in the United States 
% under Title 17, U.S. Code. All Other Rights Reserved.
% 
% Authors: Joseph M. Howard, Blair L. Unger, Mark E. Wilson, NASA
% Revision Date: 2007.08.22       