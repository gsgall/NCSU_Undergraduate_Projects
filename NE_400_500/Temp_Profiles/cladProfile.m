function Tclad = cladProfile( r, Tinf, q, Rv, Rfoc, Rg, R, kc, hc)
%{ 
    Generates the temperature profile within the given clad region
    Input: 
        r: the range of radial positions in the fuel region 
        Tinf: the coolant bulk temperature
        q: the volumetric heat generation rate
        Rv: The innter radius of the fuel region 
        Rfoc: The outer radius of the fuel region 
        Rg: The ohter radius of the gap region 
        R: The outher radius of the cladding 
        kc: The thermal conductivity of the cladding 
        hc: The convective heat transfer coefficent 
    Output: 
        Tclad: The temperature profile in the clad region
%} 
    Tclad = - ( q .* Rg ./ ( 3 .* kc ) ) .* ( Rv.^3 ./ Rfoc  - Rfoc.^2 ) ./ r + ...
            Tinf + ...
            ( q .* Rg ./ 3 ) .* ( Rv.^3 ./ Rfoc - Rfoc.^2 ) .* ...
            ( 1 ./ ( kc .* R) -  1 ./ ( hc .* R.^2 ) );
end 

