function recovered3DPoints = reconstruct3DFrom2D(cam1, cam1PixelCoords, cam2, cam2PixelCoords)
    % Pad the Pmat(3*4) to 4*4 matrix with 0, 1 for multiplication
    Pmat1 = padarray(cam1.Pmat,1,0,'post');  Pmat1(4,4)=1;
    Pmat2 = padarray(cam2.Pmat,1,0,'post');  Pmat2(4,4)=1;
    
    % Determine matrices Pu, K, C, R for triangulation
    Pu1 = cam1PixelCoords; Pu2 = cam2PixelCoords; % Input two 2D points
    
    K1 = [1 0 960; 0 1 540; 0 0 1]*[cam1.foclen 0 0 ; 0 cam1.foclen 0 ; 0 0 1 ];
    K2 = [1 0 960; 0 1 540; 0 0 1]*[cam2.foclen 0 0 ; 0 cam2.foclen 0 ; 0 0 1 ];
    
    C1 = cam1.position'; C2 = cam2.position'; % 3*1 camera coordinates
    
    R1 = Pmat1(1:3,1:3); R2 = Pmat2(1:3,1:3); % 3*3 rotation matrices
    
    % Derive both vectors(rays) from inputs
    V1 = R1'*inv(K1)*Pu1;
    uV1 = V1/sum(abs(V1));
 
    V2 = R2'*inv(K2)*Pu2;
    uV2 = V2/sum(abs(V2));
    % Compute the third vector and construct the 3 linear equations
    uV3 = cross(uV1,uV2)/sum(abs(cross(uV1,uV2)));
    
    % Using solve() to solve the equations and obtain the scale factors
	% a,b and d
    syms a b d
    E1 = a*uV1-b*uV2+d*uV3;  E2=C2-C1;
    eqn(1) = E1(1) == E2(1); eqn(2) = E1(2) == E2(2); eqn(3) = E1(3) == E2(3);
    S = solve(eqn,[a b d]);
    
    % Using the unit vectors, scale factors and camera cords to compute Pw
    P1 = double(S.a)*uV1+C1; P2 = double(S.b)*uV2+C2;
    recovered3DPoints = (P1+P2)/2;  %recovered3DPoints(Pw)
    
end