function [Sigma_t, Sigma_tr, Sigma_s, Sigma_f, nu, chi] = getTestC()
%{
    Generates the Material Properties needed to run the finite volume
    implementation of the P-1 diffusion equations for Test C 
    Output: 
        Sigma_t: Total Crosssection as an ( N * Ng ) x 1 column vector 
        Sigma_tr: Transport Crosssection as an ( N * Ng ) x 1 column vector 
        Sigma_s: Scattering Crosssection as an ( N * Ng ) x Ng Matrix 
        Sigma_f: Fission Crosssection as an ( N * Ng ) x 1 column vector
        nu: number of neutrons per fussion as an an ( N * Ng ) x 1 column vector
        chi: neutron spectrum as an ( N * Ng ) x 1 column vector
%}
    N = 224;
    Ng = 7;
    h = 0.09;
    currentMesh = 0:h:( h * N );
    fluxMesh = ( currentMesh( 1:end - 1 ) + currentMesh( 2:end ) ) / 2;

    Sigma_t = zeros( Ng * N, 1);
    Sigma_tr = zeros( Ng * N, 1 );
    Sigma_s = zeros( Ng * N, Ng );
    Sigma_f = zeros( Ng * N, 1 );
    nu = zeros( Ng * N, 1 );
    chi = zeros( Ng * N, 1 );

    guideWidth = sum( fluxMesh < 1.26 );
    pinWidth = sum( fluxMesh < ( 0.09 + 1.08 + 0.09 ) );

    pin43_t = zeros( Ng * pinWidth, 1 );
    pin43_tr = zeros( Ng * pinWidth, 1 );
    pin43_s = zeros( Ng * pinWidth, Ng );
    pin43_f = zeros( Ng * pinWidth, 1 );
    pin43_nu = zeros( Ng * pinWidth, 1 );
    pin43_chi = zeros( Ng * pinWidth, 1 );

    pin7_t = zeros( Ng * pinWidth, 1 );
    pin7_tr = zeros( Ng * pinWidth, 1 );
    pin7_s = zeros( Ng * pinWidth, Ng );
    pin7_f = zeros( Ng * pinWidth, 1 );
    pin7_nu = zeros( Ng * pinWidth, 1 );
    pin7_chi = zeros( Ng * pinWidth, 1 );

    pin87_t = zeros( Ng * pinWidth, 1 );
    pin87_tr = zeros( Ng * pinWidth, 1 );
    pin87_s = zeros( Ng * pinWidth, Ng );
    pin87_f = zeros( Ng * pinWidth, 1 );
    pin87_nu = zeros( Ng * pinWidth, 1 );
    pin87_chi = zeros( Ng * pinWidth, 1 );

    pinU_t = zeros( Ng * pinWidth, 1 );
    pinU_tr = zeros( Ng * pinWidth, 1 );
    pinU_s = zeros( Ng * pinWidth, Ng );
    pinU_f = zeros( Ng * pinWidth, 1 );
    pinU_nu = zeros( Ng * pinWidth, 1 );
    pinU_chi = zeros( Ng * pinWidth, 1 );

    guide_t = zeros( Ng * guideWidth, 1 );
    guide_tr = zeros( Ng * guideWidth, 1 );
    guide_s = zeros( Ng * guideWidth, Ng );
    guide_f = zeros( Ng * guideWidth, 1 );
    guide_nu = zeros( Ng * guideWidth, 1 );
    guide_chi = zeros( Ng * guideWidth, 1 );

    modLeft = find( fluxMesh( 1:pinWidth ) < 0.09 );
    modRight = find( fluxMesh( 1:pinWidth ) > ( 0.09 + 1.08 ) );
    fuelRegion = find( fluxMesh( 1:pinWidth ) > 0.09 & fluxMesh( 1:pinWidth ) < ( 0.09 + 1.08 ) );
    % adding moderator to left of each pin type 
    for i = 1:numel( modLeft )
        range = ( Ng * ( modLeft( i ) - 1 ) + 1 ):( Ng * modLeft( i ) );

        [pin43_t( range ), pin43_tr( range ), pin43_s( range, :), ...
         pin43_f( range ), pin43_nu( range ), pin43_chi( range ) ] = getMod7();

        [pin7_t( range ), pin7_tr( range ), pin7_s( range, :), ...
         pin7_f( range ), pin7_nu( range ), pin7_chi( range ) ] = getMod7();

        [pin87_t( range ), pin87_tr( range ), pin87_s( range, :), ...
         pin87_f( range ), pin87_nu( range ), pin87_chi( range ) ] = getMod7();

        [pinU_t( range ), pinU_tr( range ), pinU_s( range, :), ...
         pinU_f( range ), pinU_nu( range ), pinU_chi( range ) ] = getMod7();
    end
    % adding moderator to right of each pin type 
    for i = 1:numel( modRight )
        range = ( Ng * ( modRight( i ) - 1 ) + 1 ):( Ng * modRight( i ) );

        [pin43_t( range ), pin43_tr( range ), pin43_s( range, :), ...
         pin43_f( range ), pin43_nu( range ), pin43_chi( range ) ] = getMod7();

        [pin7_t( range ), pin7_tr( range ), pin7_s( range, :), ...
         pin7_f( range ), pin7_nu( range ), pin7_chi( range ) ] = getMod7();

        [pin87_t( range ), pin87_tr( range ), pin87_s( range, :), ...
         pin87_f( range ), pin87_nu( range ), pin87_chi( range ) ] = getMod7();

        [pinU_t( range ), pinU_tr( range ), pinU_s( range, :), ...
         pinU_f( range ), pinU_nu( range ), pinU_chi( range ) ] = getMod7();
    end
    % adding fuel to the center of each pin type 
    for i = 1:numel( fuelRegion )
        range = ( Ng * ( fuelRegion( i ) - 1 ) + 1 ):( Ng *  fuelRegion( i ) );

        [pin43_t( range ), pin43_tr( range ), pin43_s( range, :), ...
         pin43_f( range ), pin43_nu( range ), pin43_chi( range ) ] = getMOX47();

        [pin7_t( range ), pin7_tr( range ), pin7_s( range, :), ...
         pin7_f( range ), pin7_nu( range ), pin7_chi( range ) ] = getMOX77();

        [pin87_t( range ), pin87_tr( range ), pin87_s( range, :), ...
         pin87_f( range ), pin87_nu( range ), pin87_chi( range ) ] = getMOX87();

        [pinU_t( range ), pinU_tr( range ), pinU_s( range, :), ...
         pinU_f( range ), pinU_nu( range ), pinU_chi( range ) ] = getU7();
    end
    % generating the guide tubes 
    for i = 1:guideWidth
        range = ( Ng * ( i  - 1 ) + 1 ):( Ng * i );
        [guide_t( range ), guide_tr( range ), guide_s( range, : ), ...
         guide_f( range ), guide_nu( range ), guide_chi( range )] = getGuide7();
    end

    assemWidth = 2 * guideWidth + 6 * pinWidth;

    moxAssem_t = zeros( Ng * assemWidth, 1 );
    moxAssem_tr = zeros( Ng * assemWidth, 1 );
    moxAssem_s = zeros( Ng * assemWidth, Ng );
    moxAssem_f = zeros( Ng * assemWidth, 1 );
    moxAssem_nu = zeros( Ng * assemWidth, 1 );
    moxAssem_chi = zeros( Ng * assemWidth, 1 );

    uAssem_t = zeros( Ng * assemWidth, 1 );
    uAssem_tr  = zeros( Ng * assemWidth, 1 );
    uAssem_s = zeros( Ng * assemWidth, Ng );
    uAssem_f = zeros( Ng * assemWidth, 1 );
    uAssem_nu = zeros( Ng * assemWidth, 1 );
    uAssem_chi = zeros( Ng * assemWidth, 1 );
    
    % creating each assembly 
    for i = 1:8
        if i == 3 || i == 6
            range = Ng * guideWidth * ( i - 1 ) + 1: Ng * guideWidth * i;

            moxAssem_t( range ) = guide_t;
            moxAssem_tr( range ) = guide_tr;
            moxAssem_s( range, : ) = guide_s;
            moxAssem_f( range ) = guide_t;
            moxAssem_nu( range ) = guide_nu;
            moxAssem_chi( range ) = guide_chi;

            uAssem_t( range ) =  guide_t;
            uAssem_tr( range )  = guide_tr;
            uAssem_s( range, : ) = guide_s;
            uAssem_f( range ) = guide_f;
            uAssem_nu( range ) = guide_nu;
            uAssem_chi( range ) = guide_chi;
        elseif i == 7
            range = Ng * pinWidth * ( i - 1 ) + 1: Ng * pinWidth * i;

            moxAssem_t( range ) = pin7_t;
            moxAssem_tr( range ) = pin7_tr;
            moxAssem_s( range, : ) = pin7_s;
            moxAssem_f( range ) = pin7_f;
            moxAssem_nu( range ) = pin7_nu;
            moxAssem_chi( range ) = pin7_chi;

            uAssem_t( range ) = pinU_t;
            uAssem_tr( range )  = pinU_tr;
            uAssem_s( range, : ) = pinU_s;
            uAssem_f( range ) = pinU_f;
            uAssem_nu( range ) = pinU_nu;
            uAssem_chi( range ) = pinU_chi;
        elseif i == 8
            range = Ng * pinWidth * ( i - 1 ) + 1: Ng * pinWidth * i;

            moxAssem_t( range ) = pin43_t;
            moxAssem_tr( range ) = pin43_tr;
            moxAssem_s( range, : ) = pin43_s;
            moxAssem_f( range ) = pin43_f;
            moxAssem_nu( range ) = pin43_nu;
            moxAssem_chi( range ) = pin43_chi;

            uAssem_t( range ) = pinU_t;
            uAssem_tr( range )  = pinU_tr;
            uAssem_s( range, : ) = pinU_s;
            uAssem_f( range ) = pinU_f;
            uAssem_nu( range ) = pinU_nu;
            uAssem_chi( range ) = pinU_chi;
        else
            range = Ng * pinWidth * ( i - 1 ) + 1: Ng * pinWidth * i;

            moxAssem_t( range ) = pin87_t;
            moxAssem_tr( range ) = pin87_tr;
            moxAssem_s( range, : ) = pin87_s;
            moxAssem_f( range ) = pin87_f;
            moxAssem_nu( range ) = pin87_nu;
            moxAssem_chi( range ) = pin87_chi;

            uAssem_t( range ) = pinU_t;
            uAssem_tr( range )  = pinU_tr;
            uAssem_s( range, : ) = pinU_s;
            uAssem_f( range ) = pinU_f;
            uAssem_nu( range ) = pinU_nu;
            uAssem_chi( range ) = pinU_chi;
        end
    end
    % creating total domain 
    Sigma_t = [moxAssem_t; uAssem_t];
    Sigma_tr = [moxAssem_tr; uAssem_tr];
    Sigma_s = [moxAssem_s; uAssem_s];
    Sigma_f = [moxAssem_f; uAssem_f];
    nu = [moxAssem_nu; uAssem_nu];
    chi = [moxAssem_chi; uAssem_chi];

end
