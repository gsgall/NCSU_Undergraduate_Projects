%% Part 1 
clc; clear; close 'all'
fprintf("Part 1\n\n")
% setting up the parameters for the error analysis to begin 
n_runs = 6;
dt_min = 1e-4;
dt_max = .5;
toi = 5;
in_file = "2_nuclides_input.txt";
desired_error = 5;
folder = "Part 1";


error_analysis_part_1(in_file, n_runs, dt_min, dt_max, toi, desired_error, folder)


%% 0 - 2001
% section finds the dt needed for an error of 1 Bq for the 7 nuclide decay
% chain 
fprintf("\n\nPart 2\n\n")
in_file = "7_nuclides_error.txt";
folder = "Part 2";
out_file = "Part 2/error_out.csv";

toi = 2000;

desired_error = 1;
% using the seventh nuclide to calculate the error 
nuclide = 7;

dt = error_analysis_part_2(in_file, out_file, desired_error, toi, nuclide, folder);

%% Part 2 0 - 10000 with plotting 
% running and plotting the full 0 - 10,000 time domain of the 7 nuclides 
in_file = "7_nuclides_input.txt";
[N,source, half_lives, t_initial, t_final, ~, units] = read_input(in_file);
results = numerical_solve_forward_euler(N, half_lives, source, dt, t_initial, t_final, out_file);
plot_results(results, half_lives, units);

%% Part 2 Finding QOI
% convering lambdas 
lambdas = decayConstant(half_lives);
lambdas_sec = lambda_conversion(lambdas, units);
% removing times data 
results = results(4:end, :);
% beginning the search for the qoi at the toi 
t = t_initial:dt:toi;

if t(end) == toi 
    idx = numel(t);
    qoi = results(idx, :);
else 
    idx_below = numel(t);
    indx_above = idx_below + 1;
    
    t_below = t(end);
    t_above = t_below + dt;
    
    N_below = results(idx_below, :);
    N_above = results(idx_above, :);
    
    qoi = (N_above - N_below) ./ (t_above - t_below) .* (toi - t_below) + N_below;
end 

qoi = lambdas_sec' .*  qoi;


N1_actual_qoi = lambdas_sec(1) * N1(lambdas(1), N(1), toi);
N2_actual_qoi = lambdas_sec(2) * N2(lambdas(1), N(1), lambdas(2), N(2), toi);

% printing the results for the user
for i = 1:numel(qoi)
    fprintf("The activty of nuclide %d is %e Bq at t = %d %s\n", i, qoi(i), toi, units);
end 

fprintf("\nThe difference in activity calculated and the actual activity of nuclide 1 is %e Bq\n", abs(qoi(1) - N1_actual_qoi));
fprintf("The difference in activity calculated and the actual activity of nuclide 2 is %e Bq\n", abs(qoi(2) - N2_actual_qoi));


fprintf("\nThe saturation activity of the decay chain is %e Bq\n", lambdas_sec(1) .* N(1))