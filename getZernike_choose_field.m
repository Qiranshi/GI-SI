function [wfe] = getZernike_choose_field(field)
for i = 1:36
    %cvcmd(['^return == ZERNIKEGQ(1,1, 1,' num2str(i) ', 0,  ''exp'', 0,''phase'',''zfr'')']);
    cvcmd(['^return == ZERNIKE(1,' num2str(field) ', 1,' num2str(i) ',0, 0,  ''exp'', 0,''phase'',''zfr'')']);
    cvcmd(['buf put b1 i1 j' num2str(i) ' ^return']);
end
wfe(1,:) = cvbuf(1,1,1:36);
end