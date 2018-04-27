
%% STAGE 8
%% ======  Q , S point detection  =======
function [Q,S] = q_s_detection
% Project title: ECG signal obtained using MITDB database
% Author: Ratana Lim
% Created date: 03/16/2018
[R, GGGG] = R_peak_detection;
%%% Q(i) : position of Q-point
%%% S(i) : position of S-point

for i = 2 : 20
    for j = R(i) : -1 : R(i) - 70
        if j == 0 
            j = 2;
        end
        if GGGG(j) < GGGG(j-1) 
            Q(i) = j;
            break;
        end
    end
end

for i = 2 : 20
    for j = R(i) : R(i) + 70
        if j == 0 
            j = 1;
        end
        if GGGG(j) <  GGGG(j+1) 
            S(i) = j;
            break;
        end
    end
end
