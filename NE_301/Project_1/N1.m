function N = N1(lambda, N_0, t)
% function is calcuates the analytic solution for the decay of the first 
% nuclide in a decay chain with no sources 
% 
% lambda1 = the decay constant of the first nuclide 
% N1_0 = the intial number density of the first nuclide 
    N = N_0 * exp(-lambda * t);
end 

