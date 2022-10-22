function currk = getk( prevk, nu, Sigma_f, prevPhi, currPhi, fluxMesh, N, Ng )
%{
    Generates the next iteration of the multiplication factor based on the
    previous solution 
    Input: 
        prevk: the previous multiplication factor solution 
        nu: number of neutrons per fussion as an an ( N * Ng ) x 1 column vector
        Sigma_f: Fission Crosssection as an ( N * Ng ) x 1 column vector
        prevPhi: The previous normalized solution the equations 
                 as an Ng N x 1 column vector 
        currPhi: The current non-normalized solution to the equations 
                 as an Ng N x 1 column vector 
        fluxMesh: A 1 x N array of each location where the cell average
                  scalar flux was solved 
        N: the number of cells in the mesh 
        Ng: the number of groups being used 
    Output: 
        The next iteration of the solution for the multiplication factor 
        
%}
    currk = prevk * sum ( trapz( fluxMesh, reshape( nu .* Sigma_f .* currPhi, Ng, N ), 2 ) )...
                 ./ sum ( trapz( fluxMesh, reshape( nu .* Sigma_f .* prevPhi, Ng, N ), 2 ) );
end

