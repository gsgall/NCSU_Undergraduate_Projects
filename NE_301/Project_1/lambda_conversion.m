function lambdas = lambda_conversion(lambdas, units)
% function converts a decay constant from its base units to seconds for
% activity calculation 
% 
% lambdas = the decay constants in their base units 
% units = the units of the constants
%         Unit options: sec, min, hr, day, yr 

    if isequal("sec", units)
        % this block does nothing units are correct here;
    elseif isequal("min", units)
        lambdas = lambdas / 60;
    elseif isequal("hr", units)
        lambdas = lambdas / (60 * 60);
    elseif  isequal("day", units)
        lambdas = lambdas / (24 * 60 * 60);
    elseif isequal("yr", units)
        lambdas = lambdas / (365.25 * 24 * 60 * 60);
    end 
end 