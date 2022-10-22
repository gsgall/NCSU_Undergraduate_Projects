function hc = gethc(kfluid, R, Nu)
%{ 
    Calculates the convective heat transfer coefficent for a flow 
    Input: 
        kfluid: The thermal conductivity of the fluid 
        R: The outher radius of the fuel pellet 
        Nu: The Nusselt number of the flow 
    Output: 
        The convective heat transfer coefficient of the fluid
%} 
    hc = ( kfluid ./ R ) .* Nu;
end

