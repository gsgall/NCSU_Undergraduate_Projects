function N = N2(lambda1, N1_0, lambda2, N2_0, t)
% function is calcuates the analytic solution for the decay of the second
% nuclide in a decay chain with no sources 
% 
% lambda1 = the decay constant of the first nuclide 
% N1_0 = the intial number density of the first nuclide 
% lambda2 = the decay constant of the second nuclide 
% N1_0 = the intial number density of the second nuclide 
    
    % the first term in the decay equation 
    N = N2_0 * exp(-lambda2 * t);
    % adding the second term in the decay equation 
    N = N + ((lambda1 * N1_0) / (lambda2 - lambda1)) * (exp(-lambda1 * t) - exp(-lambda2 * t));
end

