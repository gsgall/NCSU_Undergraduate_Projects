function [s, R] = error_analysis(n, x_bar, x2_bar)
% Function calculated the sample standard deviation and estimated the
% errror is a sample of quanity x
%
% Input: 
%            n: the number of events in the sample 
%        x_bar: the average value of quantity x for the set 
%       x2_bar: the average value of quantity x^2 for the set 
%
% Output: 
%        s: The sample standard deviation 
%        R: Estimation of error in the set, standard error 

    % calculating the variance using eqn 4.33 from the monte carlo handout 
    s2 = ( n / ( n - 1 ) ) * ( x2_bar - x_bar^2 );
    % calculating the standard deviation using eqn 4.31
    s = sqrt( s2 );
    % calculating the standard error using eqn 4.32 from the monte carlo 
    % handout 
    R = s / sqrt( n );
end 