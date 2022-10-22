function [results, table] = multi_run(runs, mu, cross_sections)
% Function runs a given number of monte carlo calculations for an
% increasing number of partciles with each run and prints a table of
% results 
%
% Input: 
%                runs: an integer, the number of monte carlo calculations 
%                      to run 
%                  mu: a column vector, the average scattering angle for 
%                      each group 
%                      dimensions should be (n, 1) n -> number of groups 
%       cross_section: a matrx, the first column will be the absorption 
%                      cross section and the each column should be the 
%                      scattering cross
%                      dimensions should be (n, n+1)
%                      n -> number of groups 
%                      if potision is (n, m) the scattering event will be 
%                      from group n to group m - 1
%
    % Preallocating the results matrix for all of the runs 
    results = cell(runs, 4);
    % Creating column titles 
    names = ["Number of Particles", ...
             "Average r2 (cm^2)", ...
             "Sample Standard Deviation (cm^2)", ...
             "Estimate of error (cm^2)"];
    % running the loop for each of the requested runs 
    for i = 1:runs
        % starting the timer
        tic
        % the number of partciles for each the given run 
        n = 100 * ( 10^( i - 1 ) );
        % running the monte carlo calculation 
        [r2_bar, s, R] = monte_carlo(n, mu, cross_sections);
        % ending the timer 
        toc
        % printing that the monte carlo calculation has finished 
        fprintf("%d partciles done\n\n", n);
        % starting the results in the cell array to be transformed to a
        % table 
        results{i, 1} = n; 
        results{i, 2} = r2_bar; 
        results{i, 3} = s;
        results{i, 4} = R;
    end 
    % Creating the table 
    table = cell2table(results, 'VariableNames', names);
    % displaying the table 
    disp(table);

end

