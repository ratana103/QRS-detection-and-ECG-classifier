
%% STAGE 4
%% =======  Base line drift elimination  =======
function GG = base_line_drift_elimination
% Author: Ratana Lim
% Created date: 03/16/2018
G = getting_db;
[A10, D3, D4] = wavelet_transform;
GG = G - A10;
figure(4)
plot(GG)
title('Base line drift elimination')