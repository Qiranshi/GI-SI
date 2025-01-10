function [score] = sen_cal(data,sensitivity_temp_matrix,nominal_wfe)
%UNTITLED3 此处提供此函数的摘要
%   此处提供详细说明
    InvA = pseudoInverse_SVD(sensitivity_temp_matrix);
    score = InvA * (nominal_wfe - data)';
    %score = InvA * (data)';

end