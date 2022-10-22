function fig2Tex( fig, figfile, filename, caption, permission, figFolder )
%{
    Converts a MATLAB figure into a latex figure. Saves the Latex code to a
    file and then creates a PDF of the figure that will be displayed in
    Latex. 

    Input:
        fig: The figure handle to be saved 
        figFile: the name of the figure file with no extenstion as a string
                 or character array 
        filename: the name of the latex txt file to save things as a string
                  or character array 
        caption: The figure caption as a string or character array 
        permission: The writing permission for the file. should be 'w' for
                    the first time to save and 'a' for any additional items 
        figFolder: The folder where the pdfs will be saved 
%}
    if ~exist( figFolder, 'dir' )
        mkdir( figFolder );
    end 
    if permission == 'w' 
        if exist( figFolder, 'dir')
            delete( sprintf( "%s/*.pdf", figFolder ) );
        end 
    end 
    fid = fopen( filename, permission );
    set(fig, 'PaperPosition', [0 0 6 5]); %Position plot at left hand corner with width 5 and height 5.
    set(fig, 'PaperSize', [6 5]); 
    saveas( fig, sprintf( "%s\\%s", figFolder, figfile ), 'pdf' )

    fprintf( fid, "\\begin{figure}[H]\n");
    fprintf( fid, "\t\\centering\n");
    fprintf( fid, "\t\\includegraphics[scale=0.7]{additional_items/%s.pdf}\n", figfile );
    fprintf( fid, "\t\\caption{%s}\n", caption);
    fprintf( fid, "\\end{figure}\n\n\n");
    
    fclose( fid );
end 

