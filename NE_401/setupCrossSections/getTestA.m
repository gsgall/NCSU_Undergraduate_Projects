function [Sigma_t, Sigma_tr, Sigma_s, Sigma_f, nu, chi] = getTestA()
%{
    Generates the Material Properties needed to run the finite volume
    implementation of the P-1 diffusion equations for Test A 
    Output: 
        Sigma_t: Total Crosssection as an ( N * Ng ) x 1 column vector 
        Sigma_tr: Transport Crosssection as an ( N * Ng ) x 1 column vector 
        Sigma_s: Scattering Crosssection as an ( N * Ng ) x Ng Matrix 
        Sigma_f: Fission Crosssection as an ( N * Ng ) x 1 column vector
        nu: number of neutrons per fussion as an an ( N * Ng ) x 1 column vector
        chi: neutron spectrum as an ( N * Ng ) x 1 column vector
%}
    N = 10; 
    Ng = 7; 

    Sigma_t = zeros( Ng * N, 1 );
    Sigma_tr = zeros( Ng * N, 1 );
    Sigma_f = zeros( Ng * N, 1 );
    Sigma_s = zeros( Ng * N, Ng );
    nu = zeros( Ng * N, 1 );
    chi = zeros( Ng * N, 1 );
    % adding all Mox 8.7 for domain 
    for i = 1:10
        range = ( Ng * ( i - 1 ) + 1 ):( Ng * i );       
        [ Sigma_t( range ), Sigma_tr( range ), Sigma_s( range, : ),...
          Sigma_f( range ), nu( range ), chi( range ) ] = getMOX87; 
    end 
end

