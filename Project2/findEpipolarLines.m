function [EpipolarLines1, EpipolarLines2] = findEpipolarLines(worldCoord3DPoints, cam1, ...
    cam1PixelCoords, cam2, cam2PixelCoords)
    
    % Determine the location of cam2 seen by cam1 as the first epipole
    Epipole1 = project3DTo2D(cam1,[cam2.position 1]');
    % Solve linear equation using the joint point and the epipole
    syms a1 b1
    eqn1(1) = a1*Epipole1(1)+b1*Epipole1(2)+1==0;
    eqn1(2) = a1*cam1PixelCoords(1)+b1*cam1PixelCoords(2)+1==0;
    Sol1 = solve(eqn1,[a1 b1]);
    EpipolarLines1 = double([Sol1.a1,Sol1.b1,1]');

    % Determine the location of cam1 seen by cam2 as the second epipole
    Epipole2 = project3DTo2D(cam2,[cam1.position 1]');
    % Solve linear equation using the joint point and the epipole
    syms a2 b2
    eqn2(1) = a2*Epipole2(1)+b2*Epipole2(2)+1==0;
    eqn2(2) = a2*cam2PixelCoords(1)+b2*cam2PixelCoords(2)+1==0;
    Sol2 = solve(eqn2,[a2 b2]);
    EpipolarLines2 = double([Sol2.a2,Sol2.b2,1]');
    
    
end