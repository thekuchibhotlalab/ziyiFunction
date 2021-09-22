function S = fn_catStructField(dim, varargin)

if length(varargin) <= 1
    disp('WARNING -- CHECK NUMBER OF STRUCTURE INPUT')
else 
    S = varargin{1};
    fields = fieldnames(S);
end



for i = 2:length(varargin)
    fields = fieldnames(S);
    tempStruct = varargin{i};
    newFields = fieldnames(tempStruct);
    allFields = unique(cat(1,fields,newFields));
    
    % DEAL WITH UNIQUE FIELD THAT ONLY ONE OF S OR NEWS HAVE
    for j = 1:length(allFields)
        tempField = allFields{j};         
        % If S does not contain the unique field, create an empty field in S
        if ~contains(tempField,fields) 
            disp(['WARNING -- ' tempField ' DOES NOT EXIST IN ALL STRUCTS'])
            if iscell(S.(fields{1}))
                S.(tempField) = cell(size(S.(fields{1})));
            else
                error([fields ' FIELD IS NOT A CELL, CANNOT CONCATENATE BETWEEN CELLS'])
            end
        end
        % If newS does not contain the unique field, create an empty field in newS
        if ~contains(tempField,newFields)
            disp(['WARNING -- ' tempField ' DOES NOT EXIST IN ALL STRUCTS'])
            if iscell(tempStruct.(fields{1}))
                tempStruct.(tempField) = cell(size(tempStruct.(newFields{1})));
            else
                error([fields ' FIELD IS NOT A CELL, CANNOT CONCATENATE BETWEEN CELLS'])
            end
        end
        
    end
    
    for j = 1:length(allFields)
        tempField = allFields{j}; 
        S.(tempField) = cat(dim, S.(tempField), tempStruct.(tempField));
    end
end

S.sortIdx = num2cell(1:length(S.(fields{1}))); 

end
