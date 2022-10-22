function theta = random_theta()
% Function calculats a random polar angle 
% 
% Output: 
%        theta: a random polar angle in radians 
    % generating the random number 
    xi = rand;
    % calculating the random angle in radians using eqn 4.17 from the monte
    % carlo handout 
    theta = pi * xi;
end 