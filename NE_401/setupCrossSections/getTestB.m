function [Sigma_t, Sigma_tr, Sigma_s, Sigma_f, nu, chi] = getTestB()
%{
    Generates the Material Properties needed to run the finite volume
    implementation of the P-1 diffusion equations for Test B
    Output: 
        Sigma_t: Total Crosssection as an ( N * Ng ) x 1 column vector 
        Sigma_tr: Transport Crosssection as an ( N * Ng ) x 1 column vector 
        Sigma_s: Scattering Crosssection as an ( N * Ng ) x Ng Matrix 
        Sigma_f: Fission Crosssection as an ( N * Ng ) x 1 column vector
        nu: number of neutrons per fussion as an an ( N * Ng ) x 1 column vector
        chi: neutron spectrum as an ( N * Ng ) x 1 column vector
%} 
    N = 128; 
    Ng = 2; 
    h = 0.15625; 
    currentMesh = 0:h:( h * N );
    fluxMesh = ( currentMesh( 1:end - 1 ) + currentMesh( 2:end ) ) / 2;

    Sigma_t = zeros( Ng * N, 1); 
    Sigma_tr = zeros( Ng * N, 1 ); 
    Sigma_s = zeros( Ng * N, Ng );
    Sigma_f = zeros( Ng * N, 1 );
    nu = zeros( Ng * N, 1 );
    chi = zeros( Ng * N, 1 );

    pinWidth = sum( fluxMesh < ( 0.3125 + 0.625 + 0.3125 ) );

    uPin_t = zeros( Ng * pinWidth, 1 );
    uPin_tr = zeros( Ng * pinWidth, 1 );
    uPin_s = zeros( Ng * pinWidth, Ng );
    uPin_f = zeros( Ng * pinWidth, 1 );
    uPin_nu = zeros( Ng * pinWidth, 1 );
    uPin_chi = zeros( Ng * pinWidth, 1 );

    moxPin_t = zeros( Ng * pinWidth, 1 );
    moxPin_tr = zeros( Ng * pinWidth, 1 );
    moxPin_s = zeros( Ng * pinWidth, Ng );
    moxPin_f = zeros( Ng * pinWidth, 1 );
    moxPin_nu = zeros( Ng * pinWidth, 1 );
    moxPin_chi = zeros( Ng * pinWidth, 1 );
    
    waterLeft = find( fluxMesh( 1:pinWidth ) < 0.3125 ); 
    waterRight = find( fluxMesh( 1:pinWidth ) > ( 0.3125 + 0.625 ) );

    fuelRegion = find( fluxMesh( 1:pinWidth ) > 0.3125 & fluxMesh( 1:pinWidth ) < ( 0.3125 + 0.625 ) );
    % generating the fuel pin combintation needed for mox 8.7 and U02
    % adding water cross sections 
    for i = 1:numel( waterLeft )
        range = ( Ng * ( waterLeft( i ) - 1 ) + 1 ):( Ng * waterLeft( i ) );      
        [uPin_t( range ), uPin_tr( range ), uPin_s( range, 1:Ng ), ...
         uPin_f( range ), uPin_nu( range ), uPin_chi( range )] = getWater2();

        [moxPin_t( range ), moxPin_tr( range ), moxPin_s( range, 1:Ng ), ...
         moxPin_f( range ), moxPin_nu( range ), moxPin_chi( range )] = getWater2();
    end 
    % adding fuel cross sections 
    for i = 1:numel( fuelRegion )
        range = ( Ng * ( fuelRegion( i ) - 1 ) + 1 ):( Ng *  fuelRegion( i ) );      
        [uPin_t( range ), uPin_tr( range ), uPin_s( range, 1:Ng ), ...
         uPin_f( range ), uPin_nu( range ), uPin_chi( range )] = getU2();

        [moxPin_t( range ), moxPin_tr( range ), moxPin_s( range, 1:Ng ), ...
         moxPin_f( range ), moxPin_nu( range ), moxPin_chi( range )] = getMOX2();
    end 
    % adding water cross sections 
    for i = 1:numel( waterRight )
        range = ( Ng * ( waterRight( i ) - 1 ) + 1 ):( Ng * waterRight( i ) );      
        [uPin_t( range ), uPin_tr( range ), uPin_s( range, 1:Ng ), ...
         uPin_f( range ), uPin_nu( range ), uPin_chi( range )] = getWater2();

        [moxPin_t( range ), moxPin_tr( range ), moxPin_s( range, 1:Ng ), ...
         moxPin_f( range ), moxPin_nu( range ), moxPin_chi( range )] = getWater2();
    end 
    
    numPins = ( N / pinWidth );
    % assembling into the Mox 8.7 U02 domain 
    for i = 1:numPins
        range = ( numPins * ( i  - 1 ) + 1 ):( numPins * i );
        if i <= numPins / 2
            Sigma_t( range ) = moxPin_t ;
            Sigma_tr( range ) = moxPin_tr; 
            Sigma_s( range, : ) = moxPin_s; 
            Sigma_f( range ) = moxPin_f; 
            nu( range ) = moxPin_nu;
            chi( range ) = moxPin_chi; 
        end

        if i > numPins / 2
            Sigma_t( range ) = uPin_t ;
            Sigma_tr( range ) = uPin_tr; 
            Sigma_s( range, : ) = uPin_s; 
            Sigma_f( range ) = uPin_f; 
            nu( range ) = uPin_nu;
            chi( range ) = uPin_chi; 
        end 
    end 
end

