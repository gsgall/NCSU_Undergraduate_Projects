function [fluxMesh, currentMesh, h, hbar, Dbar] = getHandMesh( h, N, Sigma_tr )
%{
    Function generated the mesh, cell averaged and cell edge averaged
    properties needed for the P-1 multigroup diffusion equation 
    Input: 
        h: the cell width as a scalar 
        N: the number of cells 
        Sigma_tr: Transport Crosssection as an ( N * Ng ) x 1 column vector 
    Output: 
       fluxMesh: A 1 x N array of each location where the cell average
                  scalar flux was solved 
       currentMesh: A 1 x N + 1 array of each location where the cell edge
                     current was solved 
       h: The cell width in for each cell in an Ng N x 1 coulmn vector 
       Dbar: the cell edge averaged diffusion coefficient in an Ng ( N + 1 ) x 1
              column vector 
       hbar: The cell edge averaged cell width in an Ng ( N + 1 ) x 1
%}
    Ng = numel( Sigma_tr ) / N; 
    D = 1 ./ ( 3 .* Sigma_tr );

    currentMesh = 0:h:( h * N );
    fluxMesh = ( currentMesh( 1:end - 1 ) + currentMesh( 2:end ) ) / 2;
   
    hTemp = diff( currentMesh );
    
    h = zeros( Ng * N, 1 );
    hbar = zeros( Ng * ( N + 1 ), 1 );
    Dbar = zeros( Ng * ( N + 1 ), 1 );

    for i = 1:( N + 1 ) 
        range = ( Ng * ( i - 1 ) + 1 ):( Ng * i );
        range2 = ( Ng * ( i - 2 ) + 1 ):( Ng * ( i - 1 ) );

        if i < N + 1 
            h( range ) = ones( Ng, 1 ) .* hTemp( i );
        end 
        

        if i == 1
            hbar( range ) = 0.5 .* h( range );
            Dbar( range ) = D( range );
        elseif i == N + 1 
            hbar( range ) = 0.5 .* h( range2 );
            Dbar( range ) = D( range2 );
        else 
            hbar( range ) = 0.5 .* ( h( range ) + h( range2 ) );
            Dbar( range ) = D( range ) .* D( range2 ) .* ( ...
                                h( range ) + h( range2 ) ...
                             ) ./ ...
                             ( ...
                                D( range2 ) .* h ( range ) + ...
                                D( range ) .* h( range2 ) ...
                             );
        end 
    end 
end 