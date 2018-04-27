
%% STAGE 2
%% ======  Getting mitdb  =======
function G = getting_db
% Author: Ratana Lim
% Created date: 03/16/2018

% db_num = get(handles.db_menu, 'string');
% index = get(handles.db_menu, 'value');
% db_number = uint8(str2double(db_num{index}));
% fprintf("%d", db_number);
% %=================  getting mitdb  ======================
% [signal,Fs,tm] = rdsamp(['mitdb/', num2str(db_number)],[],5900);
% [signal,Fs,tm] = rdsamp('mitdb/100',[],5900); % OK
% [signal,Fs,tm] = rdsamp('edb/e0103',[],4900); % OK
[signal,Fs,tm] = rdsamp('ahadb/0201',[],4350);  % OK
% [signal,Fs,tm] = rdsamp('cudb/cu01',[],7000); % need to fix
g = signal(:,1);
g = g(1:4350);
G = g';
% figure(1)
% plot(G)
% title('Original ECG signal')
