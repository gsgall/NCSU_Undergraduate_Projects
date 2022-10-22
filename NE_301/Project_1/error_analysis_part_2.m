function dt = error_analysis_part_2(in_file, out_file, desired_error, toi, nuclide, folder)
% Function implements the Richardson Error Extrapolation technique for a given nuclide in the decay chain centered at given time, toi  
%
% in_file = the input file for the simulation 
% out_file = the file where you want to write the results
% desired_error = the max error you want in Bq
% toi = the time where you want to base the error calculations on 
% nuclide = the nuclide which you want to base the error on 
% folder = folder for output calculations 
% 
% dt the time step needed to acheive the desired error at the given toi 
    % setting error to abitrary large number for while loop to begin 
    error = 1e6;
    % creating output folder if it doesn't exist 
    if ~exist(folder, 'dir')
        mkdir(folder)
    end
    
    % getting tehe input data from the input file 
    [N, source, half_lives, t_initial, t_final, dt, units] = read_input(in_file);
    
    % setting up the qoi to calculate the error approximations 
    curr_qoi = 0;
    prev_qoi = 0;
    
    
    % converting half_lives to decay constants   
    lambdas = decayConstant(half_lives);
    % converting decay constants to seconds 
    lambdas_sec = lambda_conversion(lambdas, units);
    
    % counter to remove base case 
    runs = 0;
    % creating error matrix 
    errors = [];
    % creating dt matrix 
    dts = [];
    while error > desired_error
        % running the calculations at the given dt
        results = numerical_solve_forward_euler(N, half_lives, source, dt, t_initial, t_final, out_file);
        % removing the time information from the results 
        results = results(4:end, :);
        % creating the times to find qoi at toi 
        t = t_initial:dt:toi;
        n_steps = numel(t);
        % searching for qoi at toi 
        if t_final == toi
            curr_qoi = lambdas_sec(nuclide) * results(n_steps, nuclide);
        else 
            idx_below = n_steps; 
            idx_above = n_steps + 1;
                
            t_below = t(end);
            t_above = t(end) + dt;
                
            N_below = results(idx_below, nuclide);
            N_above = results(idx_above, nuclide);
                
            curr_qoi = (N_above - N_below) / (t_above - t_below) * (toi - t_below) + N_below;        
            curr_qoi = lambdas_sec(nuclide) * curr_qoi;
        end 
        % printing the activity for a given dt 
        fprintf("Using a dt of %d %s the activity of Nuclide %d at t = %d %s is %e Bq\n", dt, units, nuclide, toi, units, curr_qoi)
        % doing the error calculations starting at the second run 
        if runs ~= 0            
            error = abs(curr_qoi - prev_qoi);
            errors = [errors; error];
            dts = [dts; dt];
        end  
        
        % if desired error is not met cut dt in half and run again 
        if error > desired_error
            dt = dt / 2;
        end 
        % upating the qoi for error calculations 
        prev_qoi = curr_qoi;
        % adding to the run counter 
        runs = runs + 1;
    end 
    % fitting the errors to a line 
    error_fit = fit(dts, errors, 'power1');
    % setting up the dts to plot the error fit line     
    dts_fit = 1e-3:1e-5:1;
    fprintf("\n")
    % printing the error for each dt 
    for i = 1:numel(dts)
        fprintf("The error for a time step of %e %s for nuclide %d at t = %d %s is approximately %e Bq\n", dts(i), units, nuclide, toi, units, errors(i));
    end 
    % printing the needed dt 
    fprintf("\nThe time step needed for an error of %d Bq is %e %s\n\n", desired_error, dt, units);
    % plotting the errors and the fit 
    figure()
    hold on 
        loglog(dts, errors, '*--')
        loglog(dts_fit, error_fit(dts_fit));
  
        title("Error by Richarson Extrapolation")
        xlabel(sprintf("dt (%s)", units))
        ylabel("Error Bq")
        
        legend({'Calculated Errors', 'Error Fit'});
        
        text(.5, error_fit(.5) + 2, sprintf("Fit = %.2f x^{%.2f}", error_fit.a, error_fit.b)) 
    hold off
end 


