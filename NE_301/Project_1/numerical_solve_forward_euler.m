function results = numerical_solve_forward_euler(N, half_lives, source, dt, t_initial, t_final, out_file)
% function runs the forward euler method for numerical solution of a decay
% chain of an arbitary length
% The data is returned in the results matrix where data from each time step
% is saved
% The first three rows in the first column of the matrix contain the time
% information needed to recover time of each time step in the order 
% results(1, 1) = ininial time 
% results(2, 1) = dt 
% results(3, 1) = final time 
% This was done to improve performance for saving nuclide data

% N_0 = starting amounts as a column vector 
% half_lives = half lives as a column vector
% dt = the time step for the solve
% t_initial = initial time 
% t_final = final time 
% out_file = the location you want to print the results to 
    fid = fopen(out_file, 'W+');
    
    % getting the number of nuclides in the system 
    n = numel(N);
    % Creating decay constants from half-lives
    lambdas = log(2) ./ half_lives;
    
    % Creating the decay and production matricies for the nuclides 
    d_rate = eye(n) - lambdas .* dt .* eye(n) ;
    p_rate = lambdas(1:end-1) .* dt .* eye(n-1);
    
    % Expanding the source matrix so that it can be added the decay matrix 
    p_rate = [zeros(1, n-1) ; p_rate]; 
    p_rate = [p_rate, zeros(n, 1)];
    
    % combinging the decay and source matricies 
    rate = d_rate + p_rate;
    
    source =  source * dt;
    % Creating the time that goes along with each time step 
    t = t_initial:dt:t_final;
    
    % Variable initialization and to allow for printing of initial
    % conditions to files 
    % pre allocating the memory for the results 
    % saving the time information needed to recover time of each step 
    results = zeros(numel(t) + 3, n);
    results(1:3, 1) = [t_initial, dt, t_final];
    for i = 4:numel(t) + 3
        results(i, :) = N';
        % taking updating the values for the step
         N = rate * N + source;
    end
    % adding the final time step to the data
    results(numel(t) + 3, :) = N';
    
   % printing the matrix to a file
   save(out_file, 'results','-ascii','-double')
   %writematrix(results, out_file);
   fclose(fid);
end 