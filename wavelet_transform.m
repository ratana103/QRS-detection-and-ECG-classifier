
%% STAGE 3
%% ======  Wavelet transform  ======
function [A10, D3, D4] = wavelet_transform
% Author: Ratana Lim
% Created date: 03/16/2018
G = getting_db;
wname = 'db6'; %wavelet name
[Lo_D,Hi_D,Lo_R,Hi_R] = wfilters(wname); %wavelet transform

dec = mdwtdec('r',G,10,'db6');
CD = mdwtrec(dec,'cd','descend');
D1 = mdwtrec(dec,'d',1);
A1 = mdwtrec(dec,'a',1);
D2 = mdwtrec(dec,'d',2);
A2 = mdwtrec(dec,'a',2);
D3 = mdwtrec(dec,'d',3);
A3 = mdwtrec(dec,'a',3);
D4 = mdwtrec(dec,'d',4);
A4 = mdwtrec(dec,'a',4);
D5 = mdwtrec(dec,'d',5);
A5 = mdwtrec(dec,'a',5);
D6 = mdwtrec(dec,'d',6);
A6 = mdwtrec(dec,'a',6);
D7 = mdwtrec(dec,'d',7);
A7 = mdwtrec(dec,'a',7);
D8 = mdwtrec(dec,'d',8);
A8 = mdwtrec(dec,'a',8);
D9 = mdwtrec(dec,'d',9);
A9 = mdwtrec(dec,'a',9);
D10 = mdwtrec(dec,'d',10);
A10 = mdwtrec(dec,'a',10);
% figure(2)
% plot(A2)
% title('A2')
% figure(3)
% plot(D2)
% title('D2')
