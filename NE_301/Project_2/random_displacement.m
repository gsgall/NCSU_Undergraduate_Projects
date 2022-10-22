function r = random_displacement(sigma_t)
% Function calculated the random displacement vector for a particle 
% 
% Input: 
%       sigma_t: the transport cross section for the event 
% 
% Output: 
%        r: the random displacement vector 
    
    % calculating the magnitude of the vector 
    r = random_r( sigma_t );
    % calculating the azimuthal angle 
    phi = random_phi();
    % calculating the polar angle 
    theta = random_theta();
    % transforming the spherical parameters into a cartesian vector 
    x = r * sin(theta) * cos(phi);
    y = r * sin(theta) * sin(phi);
    z = r * cos(theta);
    % Storing each of the coordinated into one vector 
    r = [x, y, z];
    
end 