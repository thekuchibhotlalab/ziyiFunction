function matOut = fn_logistic(matIn,k,x0)
if nargin == 1; matOut = (1+exp(-matIn)).^(-1);
elseif nargin == 2;  matOut = (1+exp(-matIn.*k)).^(-1); 
elseif nargin == 3;  matOut = (1+exp(-(matIn-x0).*k)).^(-1); 
end

end