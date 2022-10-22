function cdf_mat = calc_cdf_mat(pdf_mat)
% Function calculated the cummulative probability distribution matrix for
% any number of energy groups and events 
% 
% Input: 
%       pdf_mat: The probaility distriubution function matrix for all of 
%                the possible events 
%                Formatting of this matrix should be (n, n + 1) Where n is
%                the number of energy groups and the absorbtion cross
%                sections should be in position (n, 1)
% 
% Output:
%        cdf_mat: The cummulative probability distribution function matrix
%                 this matrix will have the same dimension and size as the 
%                 given pdf
        
    % Getting the number of groups from the size of the matrix 
    [groups, reactions] = size(pdf_mat);
    % Preallocating the cdf matrix 
    cdf_mat = zeros(groups, reactions);
    % looping through all of the energy groups 
    for i = 1:groups
        % looping through each event in the given energy group
        for j = 1:reactions
            % calcualting the cdf for each event by summing all of the
           % Assinging the cdf for the given event to its given position 
           cdf_mat(i, j) = sum( pdf_mat( i, 1:j ));
        end 
    end 
end 