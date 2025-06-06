function color = fn_colorAlpha(color,colorAlpha)
%color = [color colorAlpha];  
color = [1 1 1] * (1-colorAlpha) + color*colorAlpha;   
    
end