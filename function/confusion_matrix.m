function CF_matrix = confusion_matrix(Ypred,Ytrue)
% Ypred: Predicted result
% Ytrue: Ground truth

% label (0: Male, 1: Female)
%        | Female |  Male |
% Female |  (1,1) | (1,2) |
% Male   |  (2,1) | (2,2) |

% Confusion matrix
Num_Class = size(unique(Ytrue),1);
CF_matrix = zeros(Num_Class, Num_Class);
for i = 1:1:length(Ypred)
    if Ypred(i,1) == 0; Ypred(i,1) = 2; end
    if Ytrue(i,1) == 0; Ytrue(i,1) = 2; end
    CF_matrix(Ypred(i,1),Ytrue(i,1)) = CF_matrix(Ypred(i,1),Ytrue(i,1)) + 1;
end
end
