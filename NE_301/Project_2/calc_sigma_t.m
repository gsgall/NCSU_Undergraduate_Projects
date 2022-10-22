function sigma_t = calc_sigma_t(mu, sigma_a, sigma_s)
% Function calculated the transport cross section for one energy group 
% 
% Input: 
%            mu: the average scattering angle for the energy group 
%       sigma_a: the absorption cross section 
%       sigma_s: the scattering cross section 
% Output: 
%        sigma_t: The transport cross section 

    % calculating the total cross section for the group 
    sigma_total = sigma_a + sigma_s; 
    % calculating the transport cross section for the group 
    sigma_t = sigma_total - mu * sigma_s;
end 