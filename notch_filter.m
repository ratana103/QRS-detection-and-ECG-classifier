
%% STAGE 6
%% ======  Notch filter  =======
function GGGG = notch_filter
% Author: Ratana Lim
% Created date: 03/16/2018
GGG = low_pass_filter;
wo =50/(1000/2);  
bw = wo/55;
[b,a] = iirnotch(wo,bw);  
GGGG = filter(b,a,GGG);
% figure(6)
% plot(GGGG)
% title('Notch filter signal')