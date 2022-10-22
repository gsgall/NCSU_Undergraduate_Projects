function r = random_r(sigma_t)
% Function calculated the magnitude of the displacement vector for a given
% group 
% 
% Input: 
%       sigma_t: the transport cross section for the energy group 
% 
% Output: 
%        r: the magnitude of the randon displacement vector units of this
%           will be the inverse units of the transport cross section 

    % generating the random number 
    xi = rand; 
    % calculating the random displacement magnitude using equation 4.21
    % from the monte carlo handout 
    r = - log(1 - xi) / sigma_t;
end 