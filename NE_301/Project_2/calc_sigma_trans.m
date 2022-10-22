function sigma_t = calc_sigma_trans(mu, cross_sections)
% Function calculates the transport cross section for multiple groups 
% 
% Input: 
%                   mu: the average scattering angle matrix. Dimensions 
%                       should be (n, 1)
%       cross_sections: The cross section matrix for a given number of
%                       energy groups. 
%                       Dimensions of the matrix should be (n, n+1) where n
%                       is the number of energy groups
%                       Absorption cross sections should be in position 
%                       (n, 1)
%                       The cross sections should be laid out so that the
%                       cross section in position (n, m) is the cross
%                       section of energy group n going to energy group m-1
% Output: 
%        sigma_t: an (n, 1) matrix of transport cross sections for each
%                 energy group

    % Getting the the number of groups 
    [groups, ~] = size( cross_sections );
    % pre allocating the transport matrix 
    sigma_t = zeros(groups, 1);
    % looping through all of the energy groups 
    for i = 1:groups
        % Calculating the total cross section for the energy group 
        sigma_t(i) = sum( cross_sections( i , : ) );
        % Subtracting the total scattering cross section time the average
        % deflection angle 
        sigma_t(i) = sigma_t(i) - mu(i) * sum( cross_sections( i , 2:end ) );
    end 
end 