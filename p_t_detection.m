
%% STAGE 9
%% =====  P,T point detection  ======
function [P,T] = p_t_detection
% Author: Ratana Lim
% Created date: 03/16/2018

% QRS_on(i) : onset point of QRS complex
% QRS_off(i): offset point of QRS complex
% diff(i)   : difference between adjacent points
[R, QRS_DET] = R_peak_detection;
[Q,S] = q_s_detection;
for i = 2 : 20
    for j = Q(i) : -1 : Q(i) - 60
        diff(j) = QRS_DET(j) - QRS_DET(j - 1);
    end
    min_diff(i) = abs(diff(Q(i))); 
    
    for j = Q(i) : -1 :Q(i) - 60
        if min_diff(i) > abs(diff(j)) 
            min_diff(i) = abs(diff(j));
        end
    end
    
    for j = Q(i) : -1 : Q(i) - 60
        if min_diff(i) == abs(diff(j)) 
            QRS_on(i) = j;
        end
    end
end

for i = 2 : 20
    for j = S(i) : S(i) + 60
        diff(j) = QRS_DET(j) - QRS_DET(j - 1);
    end
    max_diff(i) = abs(diff(S(i))); 
    
    for j = S(i) : S(i) + 60
        if max_diff(i) < abs(diff(j)) 
            max_diff(i) = abs(diff(j));
        end
    end
    slope_Threshold = 0.8 * max_diff(i);
    
    for j = S(i) : S(i) + 40
        if abs(diff(j)) > slope_Threshold 
            QRS_off(i) = j;
            break;
        end
    end
      QRS_off(i) = S(i) + 12;
end

% P,T -point detection
% Detection Method
  %1. divide the QRS_off(k):QRS_on(k+1) interval in a ratio of 2:1=T_zone:P_zone
  %2.T wave detection region estimated
  %3. Find absolute maximum amplitude value in this zone
  
  %     variables for R,T detection
  %     T_max(i)  :   maximum peak value at T_zone
  %     P_max(i)  :   maximum peak value at P_zone
  %     T(i)      :   position of T-point peak value
  %     P(i)      :   position of P-point peak value
for i = 2 : 19
    R_R_interval(i) = QRS_on(i+1) - QRS_off(i);
    T_zone(i) = round(R_R_interval(i) * 2/3);
    P_zone(i) = round(R_R_interval(i) / 3);
    T_max(i) = QRS_DET(QRS_off(i)); %intialize the maximum peak value at T_zone
    
    %  T_peak Detection
    for j = QRS_off(i) : QRS_off(i) + T_zone(i)
        if QRS_DET(j) > T_max(i) 
            T_max(i) = QRS_DET(j);
        end
    end
    
    for j = QRS_off(i) : QRS_off(i) + T_zone(i)
        if QRS_DET(j) == T_max(i) 
            T(i) = j;
        end
    end
 
    %  P peak Detection
    P_max(i+1) = QRS_DET(QRS_on(i+1) - round(P_zone(i))); %intialize the maximum peak value at T_zone
    for j = QRS_on(i+1) - round(P_zone(i)) : QRS_on(i+1)
        if QRS_DET(j) > P_max(i+1) 
            P_max(i+1) = QRS_DET(j);
        end
    end
    
    for j = QRS_on(i+1)-round(P_zone(i)):QRS_on(i+1)
        if QRS_DET(j) == P_max(i+1) 
            P(i+1)=j;
        end
    end        
end