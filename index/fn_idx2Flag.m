function flag= fn_idx2Flag(idx, len)
    if nargin == 1; len = max(idx);end
    flag = zeros(1,len);
    flag(idx) = 1;
end