function phi = random_phi()
% Function calcuates a random azimuthal angle 
% 
% Output: 
%        phi: the random azimuthal angle in radians 
    % getting the random number 
    xi = rand;
    % calculating the random angle using equation 4.16 from the monte carlo
    % handout 
    phi = 2 * pi * xi;
end

