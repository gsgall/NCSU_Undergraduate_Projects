function [lhs, lhsInv] = lhsMatrix( Dbar, h, hbar, Sigma_t, Sigma_s )
%{
    Creates the Left hand side matrix for the group wise finite volume
    method for the 1D P-1 Diffusion equation 
    Input: 
        Dbar: the cell edge averaged diffusion coefficient in an Ng ( N + 1 ) x 1
              column vector 
        h: The cell width in for each cell in an Ng N x 1 coulmn vector 
        hbar: The cell edge averaged cell width in an Ng ( N + 1 ) x 1
        Sigma_t: Total Crosssection as an ( N * Ng ) x 1 column vector 
        Sigma_s: Scattering Crosssection as an ( N * Ng ) x Ng Matrix 
    Output: 
        lhs: the left hand side of the P-1 Diffusion equations in matrix
             form as a Ng ( 2 N + 1 ) square matrix 
        lhsInv: the invese of the left hand side of the P-1 Diffusion equations in matrix
                form as a Ng ( 2 N + 1 ) square matrix 
%}
    [ ~, Ng ] = size( Sigma_s );
    N = numel( Sigma_t ) / Ng; 
    % current terms for the main equation and flux current relation 
    current = -eye( N * Ng, ( N + 1 ) * Ng )  + ...
              [ zeros( N * Ng, Ng ), eye( N * Ng )]; 
    current = [ current; zeros( ( N + 1 ) * Ng  )] + ...
              [ zeros( N * Ng, ( N + 1) * Ng); eye( ( N + 1 ) * Ng) ];
    % flux terms for the main equations 

    flux = Sigma_t .* eye( Ng * N );
    
    % accoutning for the removal and down scattering 
    for i = 1:N 
        range = ( Ng * ( i - 1 ) + 1 ):( Ng * i );       
        flux( range, range ) = flux( Ng * ( i - 1 ) + 1:Ng * i, Ng * ( i - 1 ) + 1:Ng * i ) -...
                  tril( Sigma_s( Ng * ( i - 1 ) + 1:Ng * i, : ) );   
    end 
    
    flux = flux .* h; 
    flux = [flux; zeros( (N + 1 ) * Ng, Ng * N )];

    flux2 = zeros( ( N + 1 ) * Ng, Ng * N );
    flux3 = zeros( ( N + 1 ) * Ng, Ng * N );
    flux2 = [flux2; -eye( ( N -1 ) * Ng, Ng * N  ); zeros( Ng, Ng * N )];
    flux3 = [flux3;[ zeros( ( N -1 ) * Ng, Ng ), eye( ( N -1 ) * Ng )]; zeros( Ng, Ng * N )];
    


    flux = flux + ( flux2 + flux3 ) .* [ zeros( N * Ng, 1 ); Dbar ./ hbar]; 
    
    lhs = [current , flux];
    lhsInv = inv( lhs );
end     