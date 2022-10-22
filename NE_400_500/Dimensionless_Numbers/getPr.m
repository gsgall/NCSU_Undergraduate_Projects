function Pr = getPr(Cp, mu, kfluid)
%{
    Calculates the Prandtl number of the fluid 
    Input: 
        Cp: The specific heat of the fluid
        mu: The dynamic viscosity of the fuild 
        kfluid: The thermal conductivity of the fluid
    Output: 
        Pr: The Prandtl number of the fluid 
%} 
    Pr = Cp .* mu ./ kfluid; 
end

