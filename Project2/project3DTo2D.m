
function projected2DPoints = project3DTo2D(cam,WorldCord)
    % Pad the Pmat(3*4) to 4*4 matrix with 0, 1 for multiplication
    Pmat = padarray(cam.Pmat,1,0,'post');  Pmat(4,4)=1;
    % Rotate and translate WorldCord into camera coordinates
    CamCord = Pmat*WorldCord;

    % Apply forward projection, translate into pixel coordinates
    FilmCord = [cam.foclen 0 0 0; 0 cam.foclen 0 0; 0 0 1 0]*CamCord;
    FilmCordx=FilmCord(1)/FilmCord(3); FilmCordy=FilmCord(2)/FilmCord(3); % Perspective projection
    u=FilmCordx+960; v=FilmCordy+540; % Adding half of size of pixels
    projected2DPoints = [u,v];
end