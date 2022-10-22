function [TmeltClad, TmeltFuel, totalRange, totalProfile] = getMinMelt(Uinf, rho, mu, Cp, kfluid, step, Rv, Rfoc, dG, dC, Tinf, q, kc, k, Hg )
%{
    Generated the temperature profile in the fuel pellet based on the given
    parameters
    Input: 
        Uinf: The coolant fluid velocity    
        rho: The coolant density 
        Cp: the specific heat of the coolant 
        kfluid: The thermal conductivity of the fluid 
        step: The distance between radial posisitions in mesh 
        Rv: The inner fuel radius 
        Rfoc: The other fuel radius
        dG: The gap thickness
        dC: The clad thickness 
        Tinf: The bulk coolant temperature
        q: The volumetric heat generation rate
        kc: The thermal conductivity of the clad 
        k: The thermal conductivity of the fuel 
        Hg: The gap conductance
    Output: 
        TmetlClad: The maximum temperature reached in the clad 
        TmeltFuel: The maximum temperature reached in the fuel 
        totalRange: The mesh over which the temperature profile exists 
        totalProfile: The temperature profile of the entire fuel pellet
%}
    R = Rfoc + dG + dC;
    Rg = Rfoc + dG;

    G = Uinf .* rho; 

    Re = getRe( G, R, mu );
    Pr = getPr(Cp, mu, kfluid);
    Nu = getNu(Re, Pr);
    hc = gethc(kfluid, R, Nu);
    
    cladRange = Rg:step:R; 
    fuelRange = Rv:step:Rfoc;
    gapRange = Rfoc:step:Rg; 

    Tclad = cladProfile( cladRange, Tinf, q, Rv, Rfoc, Rg, R, kc, hc);
    Tfuel = fuelProfile( fuelRange, Tinf, q, Rv, Rfoc, Rg, R, kc, hc, k, Hg);    
    Tgap = gapProfile( gapRange, Rfoc, Rg, Tfuel, Tclad );

    [cladRows, cladCols] = size( Tclad );
    [fuelRows, ~] = size( Tfuel );
    
    if cladRows ~= fuelRows
        Tclad = ones( fuelRows, cladCols ) .* Tclad;
    end 

    TmeltClad = max( Tclad, [], 2 );
    TmeltFuel = max( Tfuel, [], 2 );
    
    totalProfile = [Tfuel, Tgap, Tclad];
    totalRange = [fuelRange, gapRange, cladRange];
end

