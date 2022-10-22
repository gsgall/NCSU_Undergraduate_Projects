function p_abs = abs_prob(sigma_a, sigma_t)
% Function calculates the probabilty of an absorption event taking place
% for one energy group 
%
% Input: 
%       sigma_a: The partciles absorption cross section 
%       sigma_t: The particles total cross section 
% 
% Output: 
%        p_abs: the probability of an absorption event taking place for the
%               given partcile

    % Calculating the probability of absorption using equation 4.24 from
    % the monte carlo handout 
    p_abs = sigma_a / sigma_t;
end 

