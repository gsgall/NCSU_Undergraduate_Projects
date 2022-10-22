function equation2Tex( equation, filename, permission )

    fid = fopen( filename, permission );

    for i = 1:numel( equation )
        fprintf( fid, "\n\n\\begin{equation}\n");
        fprintf( fid, "\t%s\n", latex( equation( i ) ) );
        fprintf( fid, "\\end{equation}\n");
    end 

    fclose( fid );
end

