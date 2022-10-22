function rhs = getRhs( Sigma_s, Sigma_f, chi, nu, h, k, phi )
%{
    Gets the righthand side of the multigroup P-1 Difussion equations based
    on the previous solution to the system 

    Input: 
        Sigma_s: Scattering Crosssection as an ( N * Ng ) x Ng Matrix 
        Sigma_f: Fission Crosssection as an ( N * Ng ) x 1 column vector
        nu: number of neutrons per fussion as an an ( N * Ng ) x 1 column vector
        chi: neutron spectrum as an ( N * Ng ) x 1 column vector
        h: The cell width in for each cell in an Ng N x 1 coulmn vector 
        k: the previous iterations multiplication factor 
        phi: the previous iterations multiplication flux solution 
    Output: 
        rhs: the Right handside of the P-1 diffusion equation as a Ng ( 2 N
        + 1 ) x 1 column vector 
%}

    [ ~, Ng ] = size( Sigma_s );
    N = numel( Sigma_f ) / Ng; 

    rhsCoef =  zeros( N * Ng );
    % generating the up scatter and fission source terms along a large
    % block diagonal 
    for i = 1:N 
        range = ( Ng * ( i - 1 ) + 1 ):( Ng * i );       
        rhsCoef( range, range ) = triu( Sigma_s( range, : ), 1 ) + ...
                            chi( range, :) * transpose( nu( range, :) .* Sigma_f( range, :) / k );
    end 
    rhsCoef = rhsCoef .* h;
    rhsCoef = [rhsCoef; zeros( Ng * ( N + 1 ),  Ng * N )];
    
    rhs = rhsCoef * phi;
end

