function [EpipolarLines1, EpipolarLines2] = findEpipolarLines(worldCoord3DPoints, cam1, ...
    cam1PixelCoords, cam2, cam2PixelCoords)
    
    % Determine the location of cam2 seen by cam1
    % Pad the Pmat(3*4) to 4*4 matrix with 0, 1 for multiplication
    Pmat1 = padarray(cam1.Pmat,1,0,'post');  Pmat1(4,4)=1;
    % Rotate and translate WorldCord into camera coordinates
    CamCord1 = Pmat1*[cam2.position 1]';
    % Apply forward projection, translate into pixel coordinates
    FilmCord1 = [cam1.foclen 0 0 0; 0 cam1.foclen 0 0; 0 0 1 0]*CamCord1;
    FilmCord1x=FilmCord1(1)/FilmCord1(3); FilmCord1y=FilmCord1(2)/FilmCord1(3); % Perspective projection
    u1=FilmCord1x+960; v1=FilmCord1y+540; % Adding half of size of pixels
    Epipole1 = [u1,v1]; % Acquired the epipole
    % Solve linear equation using the joint point and the epipole
    syms a1 b1
    eqn1(1) = a1*Epipole1(1)+b1*Epipole1(2)+1==0;
    eqn1(2) = a1*cam1PixelCoords(1)+b1*cam1PixelCoords(2)+1==0;
    Sol1 = solve(eqn1,[a1 b1]);
    EpipolarLines1 = double([Sol1.a1,Sol1.b1,1]');
    
    % Determine the location of cam1 seen by cam2
    % Pad the Pmat(3*4) to 4*4 matrix with 0, 1 for multiplication
    Pmat2 = padarray(cam2.Pmat,1,0,'post');  Pmat2(4,4)=1;
    % Rotate and translate WorldCord into camera coordinates
    CamCord2 = Pmat2*[cam1.position 1]';
    % Apply forward projection, translate into pixel coordinates
    FilmCord2 = [cam2.foclen 0 0 0; 0 cam2.foclen 0 0; 0 0 1 0]*CamCord2;
    FilmCord2x=FilmCord2(1)/FilmCord2(3); FilmCord2y=FilmCord2(2)/FilmCord2(3); % Perspective projection
    u2=FilmCord2x+960; v2=FilmCord2y+540; % Adding half of size of pixels
    Epipole2 = [u2,v2]; % Acquired the epipole
    % Solve linear equation using the joint point and the epipole
    syms a2 b2
    eqn2(1) = a2*Epipole2(1)+b2*Epipole2(1)+1==0;
    eqn2(2) = a2*cam2PixelCoords(1)+b2*cam2PixelCoords(2)+1==0;
    Sol2 = solve(eqn2,[a2 b2]);
    EpipolarLines2 = double([Sol2.a2,Sol2.b2,1]');
    
    
end