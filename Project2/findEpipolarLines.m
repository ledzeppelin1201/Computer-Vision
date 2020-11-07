function [EpipolarLines1, EpipolarLines2] = findEpipolarLines(worldCoord3DPoints, cam1, ...
    cam1PixelCoords, cam2, cam2PixelCoords)
    
    % Pad the Pmat(3*4) to 4*4 matrix with 0, 1 for multiplication
    Pmat1 = padarray(cam1.Pmat,1,0,'post');  Pmat1(4,4)=1;
    % Rotate and translate WorldCord into camera coordinates
    CamCord1 = Pmat1*[cam2.position 1]';
    % Apply forward projection, translate into pixel coordinates
    FilmCord1 = [cam1.foclen 0 0 0; 0 cam1.foclen 0 0; 0 0 1 0]*CamCord1;
    FilmCord1x=FilmCord1(1)/FilmCord1(3); FilmCord1y=FilmCord1(2)/FilmCord1(3); % Perspective projection
    u1=FilmCord1x+960; v1=FilmCord1y+540; % Adding half of size of pixels, Epipole1
    Epipole1 = [u1,v1];
    
    % Solve linear equation using the joint point and the epipole
    syms a1 b1
    eqn1(1) = a1*u1+b1*v1+1==0;
    eqn1(2) = a1*cam1PixelCoords(1)+b1*cam1PixelCoords(2)+1==0;
    Sol1 = solve(eqn1,[a1 b1]);
    EpipolarLines1 = double([Sol1.a1,Sol1.b1,1]');
    
    
    % Pad the Pmat(3*4) to 4*4 matrix with 0, 1 for multiplication
    Pmat2 = padarray(cam2.Pmat,1,0,'post');  Pmat2(4,4)=1;
    % Rotate and translate WorldCord into camera coordinates
    CamCord2 = Pmat2*[cam1.position 1]';
    % Apply forward projection, translate into pixel coordinates
    FilmCord2 = [cam2.foclen 0 0 0; 0 cam2.foclen 0 0; 0 0 1 0]*CamCord2;
    FilmCord2x=FilmCord2(1)/FilmCord2(3); FilmCord2y=FilmCord2(2)/FilmCord2(3); % Perspective projection
    u2=FilmCord2x+960; v2=FilmCord2y+540; % Adding half of size of pixels, Epipole2
    Epipole2 = [u2,v2];
    
    % Solve linear equation using the joint point and the epipole
    syms a2 b2
    eqn2(1) = a2*u2+b2*v2+1==0;
    eqn2(2) = a2*cam2PixelCoords(1)+b2*cam2PixelCoords(2)+1==0;
    Sol2 = solve(eqn2,[a2 b2]);
    EpipolarLines2 = double([Sol2.a2,Sol2.b2,1]');
    
        %{
    syms f11 f12 f13 f21 f22 f23 f31 f32 f33
    F_var = [f11 f12 f13; f21 f22 f23; f31 f32 f33];
    
    for i=1:12
        multF(i) = cam1PixelCoords(:,i)'*F_var*cam2PixelCoords(:,i);
        eqn(i) = multF(i)==0;
    end
    
    Sol = solve(eqn,[f11 f12 f13 f21 f22 f23 f31 f32 f33]);
    
    F = double([Sol.f11 Sol.f12 Sol.f13; 
                Sol.f21 Sol.f22 Sol.f23; 
                Sol.f31 Sol.f32 Sol.f33]);

    % Derive both vectors(rays) from inputs
    V1 = R1'*inv(K1)*Pu1;
    uV1 = V1/sum(abs(V1));
 
    V2 = R2'*inv(K2)*Pu2;
    uV2 = V2/sum(abs(V2));

    C1 = cam1.position'; C2 = cam2.position';
    T = abs(C2-C1);
    Tx=T(1); Ty=T(2); Tz=T(3);
    S = [0 -Tz Ty; Tz 0 -Tx; -Ty Tx 0];
    %}
    
    
end