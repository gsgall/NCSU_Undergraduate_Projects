function pdf_mat = calc_pdf_mat(cross_sections)
% Function calculates the probability distribution function in matrix form 
% for a an abtritraty number of energy groups given the cross sections 
%
% Input: 
%       cross_sections: The cross section matrix for a given number of
%                       energy groups. 
%                       Dimensions of the matrix should be (n, n+1) where n
%                       is the number of energy groups
%                       Absorption cross sections should be in position 
%                       (n, 1)
%                       The cross sections should be laid out so that the
%                       cross section in position (n, m) is the cross
%                       section of energy group n going to energy group m-1
% 
% Output: 
%        pdf_mat: the probaility distribution function matrix for each  
%                 event 
%                 for m = 1                  
%                 formatting is such that the element in position (n, m) is
%                 the probility of absoprtion 
%                 for m > 1 
%                 formatting is such that element in position (n, m) is the 
%                 probability of scattering from group n to group m - 1

    % Getting the size number of groups and possible reactions
    [groups , reactions] = size(cross_sections);
    % preallocating the pdf matrix 
    pdf_mat = zeros(groups, reactions);
    % looping through all of the energy groups 
    for i = 1:groups
        % finding the probaility for each event by dividing each cross
        % section by the sum of all cross sections in each group
        pdf_mat( i, : ) = cross_sections( i , : ) ./ sum( cross_sections( i , : ) );
    end 
end 