
%% ECG PROJECT
% Title: ECG signal obtained using MITDB, EUROPEAN ST_T, AHA and CU database
% Author: Ratana Lim
% Created date: 03/16/2018
clc;
clear all;
close all;

%%
% %% #######   Getting DB   #######
% fprintf('=======  KINDS OF DATABASES  =======\n');
% fprintf('1. mitdb\n');
% fprintf('2. edb\n');
% fprintf('4. cudb\n')
% fprintf('3. ahadb\n');
% prompt = 'Please insert the kind of database: ';
% kind_db = input(prompt);
% fprintf('=====================================\n');
% if kind_db == 1
%     [signal,Fs,tm] = rdsamp('mitdb/100',[],5900);
% elseif kind_db == 2
%     [signal,Fs,tm] = rdsamp('edb/e0103',[],5900);
% elseif kind_db == 3
%     [signal,Fs,tm] = rdsamp('ahadb/0001',[],5900);
% elseif kind_db == 4
%     [signal,Fs,tm] = rdsamp('cudb/cu01',[],5900);
% end
% g = signal(:,2);
% g = g(1:5900);
% G = g';
% 
% %% #######   Wavelet Transform   #######
% wname = 'db6'; %wavelet name
% [Lo_D,Hi_D,Lo_R,Hi_R] = wfilters(wname); %wavelet transform
% dec = mdwtdec('r',G,10,'db6');
% CD = mdwtrec(dec,'cd','descend');
% D1 = mdwtrec(dec,'d',1);
% A1 = mdwtrec(dec,'a',1);
% D2 = mdwtrec(dec,'d',2);
% A2 = mdwtrec(dec,'a',2);
% D3 = mdwtrec(dec,'d',3);
% A3 = mdwtrec(dec,'a',3);
% D4 = mdwtrec(dec,'d',4);
% A4 = mdwtrec(dec,'a',4);
% D5 = mdwtrec(dec,'d',5);
% A5 = mdwtrec(dec,'a',5);
% D6 = mdwtrec(dec,'d',6);
% A6 = mdwtrec(dec,'a',6);
% D7 = mdwtrec(dec,'d',7);
% A7 = mdwtrec(dec,'a',7);
% D8 = mdwtrec(dec,'d',8);
% A8 = mdwtrec(dec,'a',8);
% D9 = mdwtrec(dec,'d',9);
% A9 = mdwtrec(dec,'a',9);
% D10 = mdwtrec(dec,'d',10);
% A10 = mdwtrec(dec,'a',10);
% % figure(2)
% % plot(A2)
% % title('A2')
% % figure(3)
% % plot(D2)
% % title('D2')
% 
% %% #######   Base line drift elimination   #######
% [A10, D3, D4] = wavelet_transform;
% GG = G - A10;
% % figure(4)
% % plot(GG)
% % title('Base line drift elimination')
% 
% %% #######   Low pass filter signal   #######
% wp = 40; 
% ws = 160;
% rp = 0.1; 
% rs = 160; 
% Fs = 1000;
% [N, Wn] = buttord(wp/(Fs/2), ws/(Fs/2), rp, rs);
% [b, a] = butter(N, Wn);
% GGG = filter(b,a,GG);
% % figure(5)
% % plot(GGG)
% % title('Low pass filter signal')
% 
% %% #######   Notch filter signal   #######
% wo =50/(1000/2);  
% bw = wo/55;
% [b,a] = iirnotch(wo,bw);  
% GGGG = filter(b,a,GGG);
% % figure(6)
% % plot(GGGG)
% % title('Notch filter signal')
% 
% %% ######   R_peak_detection   ######
% QRS_DET = D3 + D4;
% % figure(7)
% % plot(QRS_DET)
% % title('QRS detection')
% 
% sum = 0;
% for i = 1 : length(D3)
%     sum = sum + abs(QRS_DET(i));
% end
% Threshold = sum/length(D3)*3;
% % Threshold = 0.2;
% k = 1;
% i = 1;
% % QRS_START(i): start point of QRS complex
% % R_max(i)    : R - peak values
% % R(i)        : position of each R-peak
% 
% while (i <= length(D3))
%    if QRS_DET(i) >= Threshold 
%        QRS_START(k) = i;
%        i = i + 200;
%        k = k + 1;
%    end
%    i = i + 1;
% end
% 
% k = 1;
% for i = 1 : 20
%     R_max(i) = GGGG(QRS_START(i));
%     for j = QRS_START(i) : QRS_START(i) + 200
%         if R_max(i) < GGGG(j) 
%             R_max(i) = GGGG(j);
%         end
%     end
%     
%     for j = QRS_START(i) : QRS_START(i) + 150
%         if GGGG(j) == R_max(i) 
%             R(i) = j;
%         end
%     end
% end
% 
% %% #######   Q and S point detection#######
% % Q(i) : position of Q-point
% % S(i) : position of S-point
% for i = 2 : 20
%     for j = R(i) : -1 : R(i) - 70
%         if GGGG(j) < GGGG(j-1) 
%             Q(i) = j;
%             break;
%         end
%     end
% end
% 
% for i = 2 : 20
%     for j = R(i) : R(i) + 70
%         if GGGG(j) <  GGGG(j+1) 
%             S(i) = j;
%             break;
%         end
%     end
% end
% 
% %% #######   P and T point detection   #######
% for i = 2 : 20
%     for j = Q(i) : -1 : Q(i) - 60
%         diff(j) = QRS_DET(j) - QRS_DET(j - 1);
%     end
%     min_diff(i) = abs(diff(Q(i))); 
%     
%     for j = Q(i) : -1 :Q(i) - 60
%         if min_diff(i) > abs(diff(j)) 
%             min_diff(i) = abs(diff(j));
%         end
%     end
%     
%     for j = Q(i) : -1 : Q(i) - 60
%         if min_diff(i) == abs(diff(j)) 
%             QRS_on(i) = j;
%         end
%     end
% end
% 
% for i = 2 : 20
%     for j = S(i) : S(i) + 60
%         diff(j) = QRS_DET(j) - QRS_DET(j - 1);
%     end
%     max_diff(i) = abs(diff(S(i))); 
%     
%     for j = S(i) : S(i) + 60
%         if max_diff(i) < abs(diff(j)) 
%             max_diff(i) = abs(diff(j));
%         end
%     end
%     slope_Threshold = 0.8 * max_diff(i);
%     
%     for j = S(i) : S(i) + 40
%         if abs(diff(j)) > slope_Threshold 
%             QRS_off(i) = j;
%             break;
%         end
%     end
%       QRS_off(i) = S(i) + 12;
% end
% 
% % P,T -point detection
% % Detection Method
%   %1.divide the QRS_off(k):QRS_on(k+1) interval in a ratio of 2:1=T_zone:P_zone
%   %2.T wave detection region estimated
%   %3. Find absolute maximum amplitude value in this zone
%   
%   %     variables for R,T detection
%   %     T_max(i)  :   maximum peak value at T_zone
%   %     P_max(i)  :   maximum peak value at P_zone
%   %     T(i)      :   position of T-point peak value
%   %     P(i)      :   position of P-point peak value
% for i = 2 : 19
%     R_R_interval(i) = QRS_on(i+1) - QRS_off(i);
%     T_zone(i) = round(R_R_interval(i) * 2/3);
%     P_zone(i) = round(R_R_interval(i) / 3);
%     T_max(i) = QRS_DET(QRS_off(i)); 
%     %intialize the maximum peak value at T_zone
%     
%     %  T_peak Detection
%     for j = QRS_off(i) : QRS_off(i) + T_zone(i)
%         if QRS_DET(j) > T_max(i) 
%             T_max(i) = QRS_DET(j);
%         end
%     end
%     
%     for j = QRS_off(i) : QRS_off(i) + T_zone(i)
%         if QRS_DET(j) == T_max(i) 
%             T(i) = j;
%         end
%     end
%  
%     %  P peak Detection
%     P_max(i+1) = QRS_DET(QRS_on(i+1) - round(P_zone(i))); 
%     %intialize the maximum peak value at T_zone
%     for j = QRS_on(i+1) - round(P_zone(i)) : QRS_on(i+1)
%         if QRS_DET(j) > P_max(i+1) 
%             P_max(i+1) = QRS_DET(j);
%         end
%     end
%     
%     for j = QRS_on(i+1)-round(P_zone(i)):QRS_on(i+1)
%         if QRS_DET(j) == P_max(i+1) 
%             P(i+1)=j;
%         end
%     end        
% end

%% #######   PLOTTING   #######
[R, GGGG] = R_peak_detection;
[Q,S] = q_s_detection;
[P,T] = p_t_detection;
QRS_on(1) = 1;
QRS_off(1) = 1;
Q(1) = 1;
S(1) = 1;
P(1) = 1;
P(2) = 1;
T(1) = 1;
plot(GGGG)
hold on;
plot(R,GGGG(R),'or')
plot(Q,GGGG(Q),'or')
plot(S,GGGG(S),'or')
grid on;
title('QRS detection')
