function r2 = actual_r2(L2)
% Function calculated the analytical solution of the average value of r^2
% for a partcile scattered in one energy group
%
% Input: 
%       L2: The diffusion area of the particle 
%
% Output: 
%        r2: the analytic average value of r^2

    % calculating the average value using equation 4.10 from the monte
    % carlo handout 
    r2 = 6 * L2;
end 