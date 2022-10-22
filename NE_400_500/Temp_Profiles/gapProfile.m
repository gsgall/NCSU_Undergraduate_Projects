function Tgap = gapProfile(r, Rfoc, Rg, Tfuel, Tclad )
%{
    Generated the temperature profile in the gap region assuming a linear
    profile between the fuel surface temperature and the cladding inner
    temperature
    Input: 
        r: the range of radial positions in the fuel region 
        Rfoc: The outer radius of the fuel region 
        Rg: The ohter radius of the gap region 
        Tfuel: the temperature profile in the fuel region 
        Tclad: The temperature profile in the cladding region 
    Output: 
        Tgap: The temperature profile in the gap region 
%}
    
    Tgap = ( Tfuel( :, end ) - Tclad( :, 1 ) ) ./ ( Rfoc - Rg ) .* ( r - Rfoc ) + Tfuel( :, end );
end

