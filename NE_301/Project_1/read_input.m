function [N, source, half_lives, t_initial, t_final, dt, units] = read_input(filename)
% function reads inital condition and simulation parameters from an input
% file and returns each qauntity in the needed format for my forward euler
% function
% 
% filename is the name of file that stores the information needed for
% simulation 
% The file must be formatted in the following manner 
% N_0 = initial number densities seperated by commas ex. 1, 2, 3
% half_lives = the half life for each nuclide in the same order ex. 1, 2, 3
% t_iniial = the inital time step ex. 0
% t_final = the final time step to reach ex. 1e4
% dt = the time step of simulation ex. 9e-4
% units = the units of your half lifes 
%
% Note that all half_lives and time steps must be consisten in units

    % reading the text file into matlab as a cell array 
    values = readcell(filename);
    
    % getting the number of rows in the input file 
    [rows, ~] = size(values);
    
    % looping through every row to find the values next to the = 
    for i = 1:rows
       % converting that value to a number and storing it 
       if i < 4
            values{i, 1} = cell2mat(cellfun(@str2num,values(i, 2),'uniform',0));
       end 
    end 
    
    % this is just seperating each quantity that has been read from the
    % file into groups.
    N = values{1, 1}';
    half_lives = values{2, 1}';
    source = values{3, 1}';
    t_initial = values{4, 2};
    t_final = values{5, 2};
    dt = values{6, 2};
    units = values{7, 2};
end 
