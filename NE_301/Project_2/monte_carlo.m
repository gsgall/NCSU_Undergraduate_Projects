function [r2_bar, s, R] = monte_carlo(n, mu, cross_sections)
% Function does a monte carlo calculation for n particles with the 
% number of groups and events determined by the cross section matrix given
% 
% Input: 
%                   n: an integer, the number of partciles to do monte 
%                      carlo for 
%                  mu: a column vector, the average scattering angle for 
%                      each group 
%                      dimensions should be (n, 1) n -> number of groups 
%       cross_section: a matrx, the first column will be the absorption 
%                      cross section and the each column should be the 
%                      scattering cross
%                      dimensions should be (n, n+1)
%                      n -> number of groups 
%                      if potision is (n, m) the scattering event will be 
%                      from group n to group m - 1
%
% Output: 
%        r2_bar: the average sqaure of the partciles displacement 
%        s: the sample standard deviation 
%        R: the estimated error in the calculation 


    % Calculating the transport cross-section for each group
    sigma_t = calc_sigma_trans(mu, cross_sections);
    % Calculating the PDF matrix for each event 
    pdf_mat = calc_pdf_mat(cross_sections);
    % Caclulating the CDF matric for each event 
    cdf_mat = calc_cdf_mat(pdf_mat);
    % initiating sums for collection
    sum_r2 = 0; 
    sum_r4 = 0;
    % looping through all of the partciles 
    % par loop runs the loops in parallel for speed 
    parfor i = 1:n 
        % assumption is that every particle starts in group 1 
        group = 1; 
        % The particles starting position is at the origin 
        position = zeros( 1, 3 );   
        % set the random number equal to group 1 absorption so while loop
        % starts
        % While loop to that will execute until an absorption 
        while group ~= 0
            % calculating the displacement after a scattering / first event
            disp = random_displacement( sigma_t(group) );
            % updating the partcles position 
            position = position + disp;
            % creating a new random number for the next event 
            xi = rand;
            % updating the group of the particle 
            group = sum( cdf_mat( group, :) <= xi);
        end 
        % calculating the magnitude of r^2
        r2 = dot( position, position );
        % adding the particles displacement to the sum 
        sum_r2 = sum_r2 + r2;
        % adding the particles displacement squared to the sum 
        sum_r4 = sum_r4 + r2^2;
    end 
    % calculating the avergages for r^2 and r^4
    r2_bar = sum_r2 / n;
    r4_bar = sum_r4 / n;
    % calcuating the standard deviation and error estimations 
    [s, R] = error_analysis(n, r2_bar, r4_bar);
end 