function Nu = getNu(Re, Pr)
%{
    Calculated the Nusselt number of a flow based on the Reynolds and
    Prandlt numbers 
    Input: 
        Re: The Reynolds Number of the flow
        Pr: The Prandtl Number of the flow 
    Output: 
        Nu: The nusselt number of the flow 
%}
    
    C = 0; 
    m = 0;
    [rows, ~] = size(Re);
    Nu = zeros( rows, 1 );

    for i = 1:rows 
        if ( Re( i ) < 4e-1 || Re( i ) > 4e5 )
            error( "Invalid Assumption for flow regime\n");
        elseif ( Re( i ) >= 4e-1 && Re( i ) < 4 )
            C = 0.989; 
            m = 0.330;
        elseif ( Re( i ) >= 4 && Re( i ) < 4e1 )
            C = 0.911; 
            m = 0.385; 
        elseif ( Re( i ) >= 4e1 && Re( i ) < 4e3 )
            C = 0.683; 
            m = 0.466;
        elseif ( Re( i ) >= 4e3 && Re( i ) < 4e4 )
            C = 0.193;
            m = 0.618;
        elseif ( Re( i ) >= 4e4 && Re( i ) <= 4e5 )
            C = 0.027; 
            m = 0.805;
        end 

        Nu( i ) = C .* Re( i ).^m .* Pr.^(1/3);
    end 
end

