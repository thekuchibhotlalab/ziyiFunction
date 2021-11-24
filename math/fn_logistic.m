function matOut = fn_logistic(matIn)

matOut = (1+exp(-matIn)).^(-1);
end