function Tfuel = fuelProfile( r, Tinf, q, Rv, Rfoc, Rg, R, kc, hc, k, Hg)
%{ 
    Generates the temperature profile within the given fuel region
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
        k: The thermal conductivity of the fuel 
        Hg: The gap conductance 
    Output: 
        Tfuel: The temperature profile in the fuel region
%} 
    Tfuel = - ( q ./ ( 6 .* k ) ) .* ( r.^2 + 2 .* ( Rv.^3 ./ r ) );
    Tfuel = Tfuel + cladProfile( r, Tinf, q, Rv, Rfoc, Rg, R, kc, hc) - ...
            ( q ./ (3 .* Hg .* Rg ) ) .* ( ( ( Rv.^3 ) ./ Rfoc ) - Rfoc.^2 ) + ...
            ( q ./ 6 ) .* ( Rfoc.^2  + 2 .* ( Rv.^3 ./ Rfoc ) );
            
end

