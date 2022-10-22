function [phi, current, k, count, kplot, fluxMesh, currentMesh, fluxResid, currentResid] = solveDiffusion(Sigma_t, Sigma_tr, Sigma_s, Sigma_f, nu, chi, h, epPhi, epk )
%{
    Main function for solving the 1D P-1 Diffusion equations with the
    finite volume and power iteration method
    
    Input: 
        Sigma_t: Total Crosssection as an ( N * Ng ) x 1 column vector 
        Sigma_tr: Transport Crosssection as an ( N * Ng ) x 1 column vector 
        Sigma_s: Scattering Crosssection as an ( N * Ng ) x Ng Matrix 
        Sigma_f: Fission Crosssection as an ( N * Ng ) x 1 column vector
        nu: number of neutrons per fussion as an an ( N * Ng ) x 1 column vector
        chi: neutron spectrum as an ( N * Ng ) x 1 column vector
        h: cell width for mesh 
        epPhi: Stopping factor for the cell averaged scalar flux 
        epk: Stopping factor for the multiplication factor 
    
    Output: 
        phi: The normalized cell average scalar flux as an Ng x N matrix 
        current: The normalized cell edge current as an Ng x N + 1 matrix 
        k: the final multiplication factor 
        count: the number of power iterations reequried until convergence 
        kplot: the figure handle for a plot of multiplication factor versus
               power iteration 
        fluxMesh: A 1 x N array of each location where the cell average
                  scalar flux was solved 
        currentMesh: A 1 x N + 1 array of each location where the cell edge
                     current was solved 
        fluxResid: The residuals from the last solution to the cell average
                   scalar flux 
        currentResid: The residuals from the last solution to the cell edge
                      current 
        also creates a plot of multiplication factor versus power
        iteration that will be displayed
%}
     % calculte number of groups and cells 
     [ ~, Ng ] = size( Sigma_s );
     N = numel( Sigma_t ) / Ng;
     % getting mesh and avereaged properties 
     [fluxMesh, currentMesh, h, hbar, Dbar] = getHandMesh( h, N, Sigma_tr );
     % forming the lhs matrix and takign its inversion 
     [lhs, lhsInv] = lhsMatrix( Dbar, h, hbar, Sigma_t, Sigma_s );
     % initial flux guess 
     currPhi = ones( Ng * N, 1 );
     [currPhi, ~] = normalizePhi( currPhi, h, currentMesh, N, Ng );
     prevPhi = zeros( Ng * N, 1 );
     % initial k guess 
     k = 1; 
     prevk = k;  
     count = 0; 
     current = zeros( Ng, N + 1 );
        
     allk = [];

     while norm( currPhi - prevPhi ) > epPhi * norm( prevPhi ) || abs( k - prevk ) > epk * k 

        allk = [allk; k];
        prevPhi = currPhi;
        prevk = k;
        % getting right hand side of equation 
        rhs = getRhs( Sigma_s, Sigma_f, chi, nu, h, prevk, prevPhi );
        % solving system 
        all = lhsInv * rhs; 
        currPhi = all( ( N + 1) * Ng + 1:end );
        % getting k 
        k = getk( prevk, nu, Sigma_f, prevPhi, currPhi, fluxMesh, N, Ng );
        % normalize flux 
        [currPhi, factor] = normalizePhi( currPhi, h, currentMesh, N, Ng );
        % calculate residuals 
        residual = lhs * all - rhs;
        fluxResid = reshape( residual( 1:Ng*N ), Ng, N );
        currentResid = reshape( residual( Ng * N + 1:end ) , Ng, N + 1 );
        % scale all flux and current for final reporting, unsude if loop
        % does not end 
        all = all * factor; 
        count = count + 1;
     end
     % getting final flux and current 
     current = reshape( all( 1:( Ng * ( N + 1 ) ) ), Ng, N + 1 );
     phi = reshape( currPhi, Ng, N );
     % multiplication factor plot 
     kplot = figure();
        plot( 1:numel(allk), allk );
        title( "Multiplication Factor Versus Power Iteration" )
        xlabel( "Power Iteration")
        ylabel( "Multiplication Factor")
        ylim([allk( 1 ) - 0.1, allk( end ) + 0.1]);
end

