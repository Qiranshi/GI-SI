function [wfe] = getWFE()
%UNTITLED4 此处提供此函数的摘要
%   此处提供详细说明
cvcmd('BUF DEL B1');
cvcmd('FMA');
cvcmd('CAN');
cvcmd('FMA2');
cvcmd('FFD RWE');
cvcmd('FCO CIR ANG');
cvcmd('WBF B1');
cvcmd('GO');
wfe = cvbuf(1);
end