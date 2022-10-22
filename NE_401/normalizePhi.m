function [currPhi, factor] = normalizePhi( currPhi, h, currentMesh, N, Ng )
%{
    Normalizes the cell average scalar flux so that it satifies equation 4
    on the computational project assigment 

    Input: 
        currPhi: The current iterations solution for scalar flux as an 
                  Ng N x 1 array 
        fluxMesh: A 1 x N array of each location where the cell average
                  scalar flux was solved 
        currentMesh: A 1 x N + 1 array of each location where the cell edge
                     current was solved
        N: the number of cells in the mesh 
        Ng: the number of groups being used 
    Ouput: 
        currPhi: The current flux solution normalized 
        factor: The normalization factor used 
%}
        
    H = currentMesh( end ); 
    factor = H / sum( reshape( currPhi .* h,  Ng, N ), 'all' );

    currPhi = currPhi .* factor; 
end

