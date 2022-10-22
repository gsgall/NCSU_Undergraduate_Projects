function Re = getRe(G, R, mu )
%{ 
    Calculates the Reynolds number for the given flow parameters 
    Input: 
        G: The mass flux 
        R: The outer radius of the fuel pellet 
        mu: The dynamic viscosity of the fluid 
    Output: 
        Re: The Reynolds number of the flow 
%} 
    Re = G .* 2 .* R ./ mu; 
end

