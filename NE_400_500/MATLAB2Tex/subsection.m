function  subsection( filename, string, permission )
    fid = fopen( filename, permission );

    fprintf( fid, "\\subsection{%s}\n\n\n", string );

    fclose( fid );

end

