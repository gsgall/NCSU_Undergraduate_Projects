function [Sigma_t, Sigma_tr, Sigma_s, Sigma_f, nu, chi] = getMOX77()
%{
    Loads the Material properties for 7 group for MOX 7.7 fuel and used the transport
    cross section as the total cross section 
    
    Output: 
        Sigma_t: Total Crosssection as an Ng x 1 column vector 
        Sigma_tr: Transport Crosssection as an Ng x 1 column vector 
        Sigma_s: Scattering Crosssection as an Ng x Ng Matrix 
        Sigma_f: Fission Crosssection as an Ng x 1 column vector
        nu: number of neutrons per fussion as an an Ng x 1 column vector
        chi: neutron spectrum as an Ng x 1 column vector    
%}    
    all = [ ...
    2.14540E-01 1.81323E-01 9.06570E-03 8.11240E-04 8.25446E-03 2.88498E+00 5.87910E-01; ...
    3.59350E-01 3.34368E-01 4.29670E-03 2.97105E-03 1.32565E-03 2.91079E+00 4.11760E-01; ...
    4.98910E-01 4.93785E-01 3.28810E-02 2.44594E-02 8.42156E-03 2.86574E+00 3.39060E-04; ...
    5.96220E-01 5.91216E-01 1.22030E-01 8.91570E-02 3.28730E-02 2.87063E+00 1.17610E-07; ...
    4.80350E-01 4.74198E-01 1.82980E-01 1.67016E-01 1.59636E-02 2.86714E+00 0.00000E+00; ...
    8.39360E-01 8.33601E-01 5.68460E-01 2.44666E-01 3.23794E-01 2.86658E+00 0.00000E+00; ...
    8.59480E-01 8.53603E-01 5.85210E-01 2.22407E-01 3.62803E-01 2.87539E+00 0.00000E+00];
        
    Sigma_t = all( :, 2 );
    Sigma_tr = all( :, 2 );
    Sigma_f = all( :, end - 2 );
    nu = all( :, end - 1 );
    chi = all( :, end );
    
    Sigma_s = [ ...
    1.30457E-01 4.17920E-02 8.51050E-06 5.13290E-09 0.00000E+00 0.00000E+00 0.00000E+00; ... 
    0.00000E+00 3.28428E-01 1.64360E-03 2.20170E-09 0.00000E+00 0.00000E+00 0.00000E+00; ... 
    0.00000E+00 0.00000E+00 4.58371E-01 2.53310E-03 0.00000E+00 0.00000E+00 0.00000E+00; ... 
    0.00000E+00 0.00000E+00 0.00000E+00 4.63709E-01 5.47660E-03 0.00000E+00 0.00000E+00; ...  
    0.00000E+00 0.00000E+00 0.00000E+00 1.76190E-04 2.82313E-01 8.72890E-03 9.00160E-09; ... 
    0.00000E+00 0.00000E+00 0.00000E+00 0.00000E+00 2.27600E-03 2.49751E-01 1.31140E-02; ... 
    0.00000E+00 0.00000E+00 0.00000E+00 0.00000E+00 0.00000E+00 8.86450E-03 2.59529E-01]';
end

