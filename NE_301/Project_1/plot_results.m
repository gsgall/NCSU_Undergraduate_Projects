function plot_results(results, half_lives, units)
% Function plots the results of a given run of the forward euler method
% implementation. Plots both all nuclides one graph and each on there own
% graph. Also plots the analytic solution for nuclides 1 and 2 with plots
% of the numeric solutions 

% results = the results matrix from the forward euler run 
% half_lives = the half life data of the nuclides 
% units = the units of the half_lifes 
    
    % convering half_lifes to decay constants 
    lambdas = decayConstant(half_lives);
    % converting decay constants to seconds 
    lambdas_sec = lambda_conversion(lambdas, units);
    
    % collecting the time information from the results matrix 
    t_info = results(1:3, 1);
    % creating the times for each time step 
    t_plot = t_info(1):t_info(2):t_info(3);
    % creating the time steps to plot the analytic solution 
    t_actual_plot = t_info(1):1e-3:t_info(3);
    % getting the number of nuclides 
    [~, n] = size(results);
    % removing the time information from the results 
    results = results(4:end, :);
    % analytic solution for nuclide 1 
    A1 = lambdas_sec(1) .* N1(lambdas(1), results(1, 1), t_actual_plot);
    
    % analytic solution for nuclide 2 
    if n > 1
        A2 = lambdas_sec(2) .* N2(lambdas(1), results(1, 1), lambdas(2), results(1, 2), t_actual_plot);
    end 
    % plotting all of the nulcides on seperate plots 
    for i = 1:n
        figure()
        plot(t_plot', lambdas_sec(i) .* results(:, i));
        title(sprintf("Nuclide %d", i));
        xlabel(sprintf("Time (%s)", units));
        ylabel("Activity Bq");
        
        if i == 1
            hold on 
                plot(t_actual_plot, A1)
                legend({'Forward Euler Result', 'Analytic Result'});
            hold off 
            
        elseif i == 2
            hold on 
                plot(t_actual_plot, A2)
                legend({'Forward Euler Result', 'Analytic Result'});
            hold off 
        end 
    end
    
    % pre allocating for legend information 
    legend_names = cell(n, 1);
    figure()
    hold on 
    % plotting all of the nuclides on one graph 
    for i = 1:n
        plot(t_plot', lambdas_sec(i) .* results(:, i));
        legend_names{i} = sprintf("Nuclide %d", i);
    end
    title("Activity of all nuclides")
    xlabel(sprintf("Time (%s)", units));
    ylabel("Activity Bq");
    legend(legend_names, 'Location', 'southeast');
    hold off 
end 