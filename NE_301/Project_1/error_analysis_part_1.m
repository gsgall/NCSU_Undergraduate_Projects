function error_analysis_part_1(in_file, n_runs, dt_min, dt_max, toi, desired_error, folder)
% This function does the forward euler calculations for the case of 2
% nuclides with n_runs different times steps then plots the results for
% each solution at a given dt and for the error lines for both local error
% at speciic point and maximum error over the entire time domain 
% Also gives the user the qoi at the give toi for nuclide b

% in_file = the path to the input file that contains the intial conditions
% n_runs = the number of time steps to run the error calculations for 
% dt_min = the lower bound on the time steps to collect error data 
% dt_max = the uppoer bound on the time steps to collect error data 
% toi = the time at which you are interested in the nuclides activity 
% desired_error = the error level you want in your simulation in Bq
% folder = the folder to which you will be writing the output data to 
    
    % getting the intial conditions to begin the calculations 
    [N, source, half_lives, t_initial, t_final, ~, units] = read_input(in_file);

    % creating the output folder if it doesn't exist 
    if ~exist(folder, 'dir')
        mkdir(folder)
    end
    
    % calculing n_runs dts linearly spaced between the dt_min and dt_max
    dts = linspace(dt_min, dt_max, n_runs);
    % converting the half_lives to decay constants 
    lambdas = decayConstant(half_lives);
    % converting the decay constants from given units to seconds for
    % activity calculations 
    lambdas_sec = lambda_conversion(lambdas, units);
    % creating the time steps over which the analytical solution will be
    % plotted 
    t_plot = t_initial:1e-5:t_final;
    % finding the analytic solution for the number densty of nuclide B 
    qoi_actual = N2(lambdas(1), N(1), lambdas(2), N(2), toi);
    % creating the analytic solution data to plot of Nuclide A and B 
    N1_actual = N1(lambdas(1), N(1), t_plot);
    N2_actual = N2(lambdas(1), N(1), lambdas(2), N(2), t_plot); 
    % pre allocating to collect the qoi data from each run 
    qoi = zeros(numel(N), 1);
    % pre allocating the cell to collect legend titles 
    line_names = cell(numel(N) + 1, 1);
    % pre allocating for the max absolute error calculations 
    max_errors = zeros(numel(N), 1);
    % setting calc error to arbitrary large number to begin while loop
    calc_error = 1e6;
    % letting the first name of the legend for analytic solution 
    line_names{1} = 'Analytic Solution';
    % plotting the analytic solution for nuclide A 
    hold on 
        figure(1)
        plot(t_plot, lambdas_sec(1) .* N1_actual)
    hold off
    % plotting the analytic solution for nuclide B
    hold on 
        figure(2) 
        plot(t_plot, lambdas_sec(2) .* N2_actual)
    hold off 
    
   
    % looping through calculations for the numebr of runs 
    for i = 1:n_runs
        % collecting legend information 
        line_names{i + 1} = sprintf("dt = %E", dts(i));
        % creating the name of the outfile 
        out_file = sprintf("%s/%E_dt.csv", folder, dts(i));
        % calculating the number density for the given dt 
        results = numerical_solve_forward_euler(N, half_lives, source, dts(i), t_initial, t_final, out_file);
        % setting up times to search for qoi 
        t = t_initial:dts(i):toi;
        % setting up times for plotting 
        t_plot = t_initial:dts(i):t_final;
            
        % beginning the toi search 
        n_steps = numel(t);
        final_time = t(end);
        
        % plotting the solution for given dt of nuclide A 
        hold on 
            figure(1)
            plot(t_plot, lambdas_sec(1) .* results(4:end, 1))
        hold off 
        % plotting the solution for given dt of nuclide B
        hold on 
            figure(2)
            plot(t_plot, lambdas_sec(2) .* results(4:end, 2))
        hold off 
        
        % case for if the toi is already calculated 
        if final_time == toi
            qoi(i) = results(n_steps + 3, 2);
        % case for if a linear interpolation is needed 
        else 
            idx_below = n_steps + 3; 
            idx_above = n_steps + 4;
                
            t_below = t(end);
            t_above = t(end) + dts(i);
                
            N_below = results(idx_below, 2);
            N_above = results(idx_above, 2);
                
            qoi(i) = (N_above - N_below) / (t_above - t_below) * (toi - t_below) + N_below;                  
        end 
        % calculating the analytic solution at every time step         
        N2_max_error = N2(lambdas(1), N(1), lambdas(2), N(2), t_plot)';
        % finding the maximum absolute error for the given dt
        max_errors(i) = max(abs(results(4:end, 2) - N2_max_error));
    end 
    % converting number density errors to activity errors 
    abs_error = lambdas_sec(2) .* abs(qoi_actual - qoi);
    max_errors = lambdas_sec(2) .* max_errors;
    
    % creating dts to plot the fitted lines with 
    dts_fit = dts(1):1e-5:dts(end);
    % fitting the absolute error at the toi 
    error_fit = fit(dts', abs_error, 'power1');
    % fitting the maximum absolute error 
    max_error_fit = fit(dts', max_errors, 'power1');
    % adding details to plots 
    hold on 
        figure(1)
        title("Nuclide A")
        xlabel("time (hr)")
        ylabel("Activity (Bq)")
        legend(line_names{:, :})
    hold off
    
    hold on 
        figure(2)
        title("Nuclide B")
        xlabel("time (hr)")
        ylabel("Activity (Bq)")
        legend(line_names{:})
    hold off
    
    % Plotting absolute error at toi 
    figure(3)
    hold on 
        loglog(dts', abs_error, '*-')
        loglog(dts_fit, error_fit(dts_fit));
        
        title(sprintf("Absolute Error at t = %d %s of Nuclide B", toi, units));
        xlabel("dt (hr)")
        ylabel("Error (Bq)")
        text(0.15, 2000, sprintf("Line = %.4f x^{%.4f}", error_fit.a, error_fit.b))
        legend('Actual Error', 'Error Fit');
    hold off
    
    % plotting maximum aboslute error 
    figure(4)
    hold on 
        loglog(dts', max_errors, '*-')
        loglog(dts_fit, max_error_fit(dts_fit));
        text(0.15, 1e5, sprintf("Line = %.0f x^{%.4f}", max_error_fit.a, max_error_fit.b))
        
        title("Maximum Absolute Error of Nuclide B")
        xlabel("dt (hr)")
        ylabel("Error (Bq)")
        legend('Actual Error', 'Error Fit');
    hold off 
    
    % creating the dts to find max dts needed for desired error
    dts_fit = 1e-5:1e-5:10;
    errors = error_fit(dts_fit);
    % searchgin for desired error 
    n = sum(errors == desired_error);
    if n == 1
        dt_needed = dts_fit(errors == 5);
    else 
        idx_less = sum(errors < desired_error);
        idx_greater = idx_less + 1;
        
        dt_less = dts_fit(idx_less);
        dt_greater = dts_fit(idx_greater);
        
        error_less = errors(idx_less);
        error_greater = errors(idx_greater); 
        
        dt_needed = (dt_greater - dt_less) / (error_greater - error_less) * (desired_error - error_less) + dt_less;
        
    end 
    
    % searching for desired error of maximum absolute error 
    while calc_error > desired_error
        calc_error = max_error_fit(dt_max);
        
        if calc_error > desired_error
            dt_max = dt_max / 2;
        end 
    end 
    
    % printing all the use ful information to the user 
    fprintf("The dt needed for an error of %d Bq at t = %d is %e hr\n", desired_error, toi, dt_needed);
    fprintf("The dt needed to achieve a maximum absolute error of %d Bq is %e hr\n\n", desired_error, dt_max);
    
    
    for i = numel(qoi):-1:1
        fprintf("The the ativity of Nuclide B at t = %d hrs is %e Bq using a time step of %e hr\n", toi, lambdas_sec(2) * qoi(i), dts(i));
    end 
    fprintf("\n")
    for i = numel(qoi):-1:1
        fprintf("Absolute error in activity of Nuclide B at t = %d %s is %e Bq and has a maximum absolute error of %e Bq\n", toi, units, abs_error(i), max_errors(i));
    end 
    fprintf("\n")
    fprintf("The the ativity of Nuclide B at t = %d hrs is %e Bq using the analytic solution\n\n", toi, lambdas_sec(2) * qoi_actual);
end 