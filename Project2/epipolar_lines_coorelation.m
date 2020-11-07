%2.6 attempt. Please review/edit
function [EpipolarLines1, EpipolarLines2] = epipolar_lines_coorelation(cam1, cam2)

    % Pad the Pmat(3*4) to 4*4 matrix with 0, 1 for multiplication
    Pmat1 = padarray(cam1.Pmat,1,0,'post');  Pmat1(4,4)=1;
    Pmat2 = padarray(cam2.Pmat,1,0,'post');  Pmat2(4,4)=1;
    K1 = [1 0 960; 0 1 540; 0 0 1]*[cam1.foclen 0 0 ; 0 cam1.foclen 0 ; 0 0 1 ];
    K2 = [1 0 960; 0 1 540; 0 0 1]*[cam2.foclen 0 0 ; 0 cam2.foclen 0 ; 0 0 1 ];
    C1 = cam1.position'; C2 = cam2.position';
    R1 = Pmat1(1:3,1:3); R2 = Pmat2(1:3,1:3);
    
    % Find camera positions and epipolar line vectors
    RmatTr = transpose(R1);
    v_mat = [C1(1); C1(2); 1];
    % Find vector derived from C1
    vue2vec =  RmatTr * (K1 \ v_mat);
    % Find position of C1 
    vue2loc = -(RmatTr) * [Pmat1(1, 4); Pmat1(2, 4); Pmat1(3, 4)];

    RmatTr = transpose(R2);
    v_mat = [C2(1); C2(2); 1];
    % Find vector derived from C2
    vue4vec =  RmatTr * (K2 \ v_mat);
    % Find position of C2
    vue4loc = -(RmatTr) * [Pmat2(1, 4); Pmat2(2, 4); Pmat2(3, 4)];

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
    %epi_lines = matUnitVec * epi_lines_coord;
    EpipolarLines1 = matUnitVec * vue2coord;
    EpipolarLines2 = matUnitVec * vue4coord;
    
end
