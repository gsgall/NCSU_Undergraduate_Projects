function [actual_r2_bar, average_r2, s, R, actual_error, in_range] = monte_carlo_1_group(n, mu, sigma_a, sigma_s)
% Function is the hard coded version of the one group monte carlo 
% calculation     
% 
% Input: 
%             n: an integer, the number of particles for the calculation 
%            mu: the average scattering angle for the group 
%       sigma_a: the absorption cross section 
%       sigma_s: the scattering cross section 
%
% Output:
%      actual_r2_bar: analytic solution for the average r^2 value 
%         average_r2: the monte carlo calculated average value of r^2
%                  s: the sample standard deviation 
%                  R: the sample average error
%       actual_error: the average error is absolute value of the difference
%                     between the actual solution and the analytic solution 

    % calculating the transport cross section 
    sigma_t = calc_sigma_t( mu, sigma_a, sigma_s );
    % calculating the probalility of absorption 
    p_abs = abs_prob( sigma_a, sigma_t );
    % calculating the diffusion area 
    L2 = calc_L2( sigma_a, sigma_t );
    % initializing the sums 
    sum_r2 = 0;
    sum_r4 = 0;
    % looping through every particle 
    parfor i = 1:n 
        % intializing the position vector 
        position = zeros( 1, 3 );
        % setting the random number above 1 to start the loop atleast once 
        xi = 1.1;
        % While loop to calculate until the particle is absorbed 
        while xi > p_abs 
            % calculating the random displacement vector 
            disp = random_displacement( sigma_t );
            % adding the displacement to the position vector 
            position = position + disp;
            % generating the new random number 
            xi = rand;  
        end 
        % calculating magnitude of r2 for a particle 
        r2 = dot( position, position );
        % adding the values to the totals
        sum_r2 = sum_r2 + r2;
        sum_r4 = sum_r4 + r2^2;
    end 
    % calculating the average values for the error analysis 
    average_r2 = sum_r2 ./ n;
    average_r4 = sum_r4 ./ n; 
    % doing the error analysis 
    [s, R] = error_analysis( n, average_r2, average_r4 );
    % calculating the analytic solution 
    actual_r2_bar = actual_r2(  L2 );
    % calculating the error
    actual_error =  abs( average_r2 - actual_r2_bar );
    % checking is the calculated error is within the actual error 
    if R >= actual_error
        in_range = "yes"; 
    else 
        in_range = "no"; 
    end
end 