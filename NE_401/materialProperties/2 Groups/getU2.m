function [Sigma_t, Sigma_tr, Sigma_s, Sigma_f, nu, chi] = getU2()
%{
    Loads the Material properties for 2 group for UO2 and used 
    the transport cross section as the total cross section 
    
    Output: 
        Sigma_t: Total Crosssection as an Ng x 1 column vector 
        Sigma_tr: Transport Crosssection as an Ng x 1 column vector 
        Sigma_s: Scattering Crosssection as an Ng x Ng Matrix 
        Sigma_f: Fission Crosssection as an Ng x 1 column vector
        nu: number of neutrons per fussion as an an Ng x 1 column vector
        chi: neutron spectrum as an Ng x 1 column vector    
%}    
    
    Sigma_t = [ 0.2; 1 ];
    muBar = [ 0; 0 ];

    nu = [ 0; 1.5 ];
    chi = [ 1; 0 ];
    Sigma_f = [ 0; 0.1 ];

    Sigma_s = [ 0.185 0.000; ...
                0.015 0.900 ];

    Sigma_tr = Sigma_t - muBar .* diag( Sigma_s );
    
end

