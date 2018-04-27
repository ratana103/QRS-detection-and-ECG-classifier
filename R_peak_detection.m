
%% STAGE 7
%% ======  R peak detection  ======
function [R, GGGG] = R_peak_detection
% Author: Ratana Lim
% Created date: 03/16/2018
GGGG = notch_filter;
[A10, D3, D4] = wavelet_transform;
QRS_DET = D3 + D4;
% figure(7)
% plot(QRS_DET)
% title('QRS detection')

sum = 0;
for i = 1 : length(D3)
    sum = sum + abs(QRS_DET(i));
end
Threshold = sum/length(D3)*3;
% Threshold = 0.2;
k = 1;
i = 1;
% QRS_START(i): start point of QRS complex
% R_max(i)    : R - peak values
% R(i)        : position of each R-peak

while (i <= length(D3))
   if QRS_DET(i) >= Threshold 
       QRS_START(k) = i;
       i = i + 200;
       k = k + 1;
   end
   i = i + 1;
end

k = 1;
for i = 1 : 20
    R_max(i) = GGGG(QRS_START(i));
    for j = QRS_START(i) : QRS_START(i) + 200
        if R_max(i) < GGGG(j) 
            R_max(i) = GGGG(j);
        end
    end
    
    for j = QRS_START(i) : QRS_START(i) + 150
        if GGGG(j) == R_max(i) 
            R(i) = j;
        end
    end
end
