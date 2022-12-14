function [Sigma_t, Sigma_tr, Sigma_s, Sigma_f, nu, chi] = getMOX87()
%{
    Loads the Material properties for 7 group for MOX 8.7 fuel and used the transport
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
     2.16280E-01 1.83045E-01 9.48620E-03 8.14110E-04 8.67209E-03 2.90426E+00 5.87910E-01; 
     3.61700E-01 3.36705E-01 4.65560E-03 3.03134E-03 1.62426E-03 2.91795E+00 4.11760E-01; 
     5.05630E-01 5.00507E-01 3.62400E-02 2.59684E-02 1.02716E-02 2.86986E+00 3.39060E-04; 
     6.11170E-01 6.06174E-01 1.32720E-01 9.36753E-02 3.90447E-02 2.87491E+00 1.17610E-07; 
     5.08900E-01 5.02754E-01 2.08400E-01 1.89142E-01 1.92576E-02 2.87175E+00 0.00000E+00; 
     9.26670E-01 9.21028E-01 6.58700E-01 2.83812E-01 3.74888E-01 2.86752E+00 0.00000E+00; 
     9.60990E-01 9.55231E-01 6.90170E-01 2.59571E-01 4.30599E-01 2.87808E+00 0.00000E+00];
        
     Sigma_t = all( :, 2 );
     Sigma_tr = all( :, 2 );
     Sigma_f = all( :, end - 2 );
     nu = all( :, end - 1 );
     chi = all( :, end );

    Sigma_s = [ ...
    1.31504E-01 4.20460E-02 8.69720E-06 5.19380E-09 0.00000E+00 0.00000E+00 0.00000E+00; 
    0.00000E+00 3.30403E-01 1.64630E-03 2.60060E-09 0.00000E+00 0.00000E+00 0.00000E+00; 
    0.00000E+00 0.00000E+00 4.61792E-01 2.47490E-03 0.00000E+00 0.00000E+00 0.00000E+00; 
    0.00000E+00 0.00000E+00 0.00000E+00 4.68021E-01 5.43300E-03 0.00000E+00 0.00000E+00; 
    0.00000E+00 0.00000E+00 0.00000E+00 1.85970E-04 2.85771E-01 8.39730E-03 8.92800E-09; 
    0.00000E+00 0.00000E+00 0.00000E+00 0.00000E+00 2.39160E-03 2.47614E-01 1.23220E-02; 
    0.00000E+00 0.00000E+00 0.00000E+00 0.00000E+00 0.00000E+00 8.96810E-03 2.56093E-01]';
end

