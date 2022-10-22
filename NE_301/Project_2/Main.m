clc; clear; 
%% Part 1
runs = 6;

mu = 0; 
sigma_a = 0.006;
sigma_s = 0.050;

results = cell(runs, 8);
names = ["Case", "Number of Particles", "actual <r^2> (cm^2)", "<r^2> (cm^2)", "Sdev (cm^2)", "Est err (cm^2)", "Actual err (cm^2)", "actual in range?"];

for i = 1:runs
    tic
    n = 100 * ( 10^( i - 1 ) );
    [actual_r2, average_r2, std_deviation, est_error, actual_error, in_range] = monte_carlo_1_group(n, mu, sigma_a, sigma_s);
    
    results{i, 1} = i;
    results{i, 2} = n;
    results{i, 3} = actual_r2;
    results{i, 4} = average_r2;
    results{i, 5} = std_deviation;
    results{i, 6} = est_error;
    results{i, 7} = actual_error;
    results{i, 8} = in_range;
    toc
    fprintf("%d partciles done\n\n", n);
end 
fprintf("Hard Coded 1 Group\n")
Table = cell2table(results, 'VariableNames', names);
disp(Table);
 
%% Part 2 Test
mu = 0; 
cross_sections = [0.006, 0.050];
fprintf("\nGeneral Solution 1 Group\n")
[results, table] = multi_run(runs, mu, cross_sections);
%% Part 2
fprintf("\n4 Groups\n")
cross_sections = [4.3708e-4, 1.82647e-1, 8.77074e-2, 3.71651e-5, 7.00404e-7; ...
                  5.7416e-3, 0         , 4.19655e-1, 1.63779e-1, 4.15248e-3; ...
                  1.5010e-2, 0         , 1.46487e-5, 6.34985e-1, 4.39694e-1; ... 
                  3.7309e-2, 0         , 0         , 1.32440e-1, 2.48066e00];

[groups, ~] = size(cross_sections);
mu = zeros(groups, 1);

[results, table] = multi_run(runs, mu, cross_sections);
%% Part 3
fprintf("\n7 Groups\n")
runs = 6;

cross_sections = [6.0105e-4, 4.44777e-2, 1.13400e-1, 7.23470e-4, 3.74990e-4, 5.31840e-8, 0         , 0         ; ...
                  1.5793e-5, 0         , 2.82334e-1, 1.29940e-1, 6.23400e-4, 4.80020e-5, 7.44860e-6, 1.04550e-6; ...
                  3.3716e-4, 0         , 0         , 3.45256e-1, 2.24570e-1, 1.69990e-2, 2.64430e-3, 5.03440e-4; ... 
                  1.9406e-3, 0         , 0         , 0         , 9.10284e-2, 4.15510e-1, 6.37320e-2, 1.21390e-2; ...
                  5.7416e-3, 0         , 0         , 0         , 7.14370e-5, 1.39138e-1, 5.11820e-1, 6.12290e-2; ...
                  1.5001e-2, 0         , 0         , 0         , 0         , 2.21570e-3, 6.99913e-1, 5.37320e-1; ...
                  3.7239e-2, 0         , 0         , 0         , 0         , 0         , 1.32440e-1, 2.48070e00];

[groups, ~] = size(cross_sections);
mu = zeros(groups, 1);
[results, table] = multi_run(runs, mu, cross_sections);