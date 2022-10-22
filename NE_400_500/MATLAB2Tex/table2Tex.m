function table2Tex(table, fileName, caption, format, permission, maxCols, count)
%{  
    Function for converting a matlab table into a latex table that uses the
    tabu package 

    table:    The table to be converted to a latex table 
              Function currently only supports tables of purely numeric data 
    fileName: The location where the table latex script will be written to 
    caption:  The caption you want the table to have as a string or char
              array
    format:   Options are long or short 
              long:  prints in scientific notation with an 8 digit mantissa
              short: prints 4 sigfigs after the decimal place behavior 
                     is slighlly magnitude dependant
%} 
    [ ~, cols ] = size( table );
    len = maxCols;
    if cols > len
        trim = table( :, 1:len );
        rest = table( :, ( len + 1 ):end );
        if count == 0 
            p = permission;
        else 
            p = 'a';
        end 
        count = count + 1; 
        table2Tex( trim, fileName, caption, format, p, maxCols, count );
        table2Tex( rest, fileName, caption, format, 'a', maxCols, count );
    else 
        fid = fopen(fileName, permission);
        vars = table.Properties.VariableNames;
        data = table.Variables;
        [sets, numVars] = size(data);
        % Printing the headers for starting the table
        fprintf(fid, "\\begin{table}[H]\n");
        fprintf(fid, "\t\\centering\n");
        fprintf(fid, "\t\\begin{tabu}{|");
    % printing the column characters for the number of variables in the
    % table
        for i = 1:numVars
            fprintf(fid, "c|");
        end 
        fprintf(fid, "}\n\t\t\\hline\n");

        %fprintf(fid, "\t\tTrial\n");
        for i = 1:numVars
            if i == 1 
                fprintf(fid, "\t\t%s \\(\\left[ \\frac{\\text{}}{\\text{}} \\right]\\)\n", vars{i});
            else 
                fprintf(fid, "\t\t& %s \\(\\left[ \\frac{\\text{}}{\\text{}} \\right]\\)\n", vars{i});
            end 
            
        end 
        fprintf(fid, "\t\t\\\\\n\t\t\\hline\n");

        if isequal(format, "long")
            for i = 1:sets
                %fprintf(fid, "\t\t%d ", i);
                for j = 1:numVars
                    if j == 1 
                        fprintf(fid, "\t\t%.4f ", data(i, j));
                    else 
                        fprintf(fid, "& %.4f ", data(i, j));
                    end
                end 
                fprintf(fid, "\\\\\n\t\t\\hline\n");
            end
        elseif isequal(format, "short")
            for i = 1:sets
                %fprintf(fid, "\t\t%d ", i);
                for j = 1:numVars
                    if j == 1 
                        fprintf(fid, "\t\t%.4f ", data(i, j));
                    else 
                        fprintf(fid, "& %.4f ", data(i, j));
                    end
                end 
                fprintf(fid, "\\\\\n\t\t\\hline\n");
            end
        end 
    
        fprintf(fid, "\t\\end{tabu}\n");
        fprintf(fid, "\t\\caption{%s}\n", caption);
        %fprintf(fid, "\t\\label{table:Number}\n");
        fprintf(fid, "\\end{table}\n\n\n");
    
        fclose(fid);
    end 
end