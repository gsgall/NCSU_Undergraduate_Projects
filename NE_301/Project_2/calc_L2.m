function L2 = calc_L2(sigma_a, sigma_t)
% Function calculates the diffusion area for a one energy group set up 
% 
% Input: 
%       sigma_a: the abasorption cross section 
%       sigma_t: the transport cross section 
% 
% Output: 
%        L2: the diffusion area for the cross sections 
 
    % calcualting the diffusion coefficient 
    D = 1 / ( 3 * sigma_t );
    % calculating the diffusion area using the equation given at the end of
    % secion 4.1 of the monte carlo handout 
    L2 = D / sigma_a;

end 

