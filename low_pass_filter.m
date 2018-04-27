
%% STAGE 5
%% ======  Low_Pass Filter 0 ~ 40 Hz  =======
function GGG = low_pass_filter
% Author: Ratana Lim
% Created date: 03/16/2018
wp = 40; 
ws = 160;
rp = 0.1; 
rs = 160; 
GG = base_line_drift_elimination;

Fs = 1000;
[N, Wn] = buttord(wp/(Fs/2), ws/(Fs/2), rp, rs);
[b, a] = butter(N, Wn);
GGG = filter(b,a,GG);
% figure(5)
% plot(GGG)
% title('Low pass filter signal')