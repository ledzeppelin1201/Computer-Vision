%2.6 attempt. Please review/edit
function epi_lines = epipolar_lines_coorelation(C2, C4, R2, R4, K2, K4)
    % Find camera positions and epipolar line vectors
    RmatTr = transpose(R2);
    v_mat = [C2(1); C2(2); 1];
    % Find vector derived from C1
    vue2vec =  RmatTr * (K2 \ v_mat);
    % Find position of C1 
    vue2loc = -(RmatTr) * [Pmat2(1, 4); Pmat2(2, 4); Pmat2(3, 4)];

    RmatTr = transpose(R4);
    v_mat = [C4(1); C4(2); 1];
    % Find vector derived from C2
    vue4vec =  RmatTr * (K4 \ v_mat);
    % Find position of C2
    vue4loc = -(RmatTr) * [Pmat4(1, 4); Pmat4(2, 4); Pmat4(3, 4)];

    % Find the unit vectors for each camera via normalization  
    vue2unit = vue2vec ./ norm(vue2vec);
    vue4unit = vue4vec ./ norm(vue4vec);
    crossUnitVec = cross(vue2unit, vue4unit);
    dUnit = crossUnitVec ./ norm(crossUnitVec);

    % Create unit vector matrix
    matUnitVec = horzcat(vue2unit, -vue4unit, dUnit);
    % Find the distances
    dist = mldivide(matUnitVec, vue4loc - vue2loc);

    % Find the points based on calculations 
    vue2coord = vue2loc + dist(1) * vue2unit;
    vue4coord = vue4loc + dist(2) * vue4unit;
    
    % Calculate midpoint coordinate
    epi_lines_coord = (vue2coord + vue4coord) ./ 2;
    % Calculate epipolar line
    epi_lines = matUnitVec * epi_lines_coord;
end
