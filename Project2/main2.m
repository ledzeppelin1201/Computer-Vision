load 'FilesForProject2/Subject4-Session3-Take4_mocapJoints.mat'
% load 'FilesForProject2/vue2CalibInfo.mat'
% load 'FilesForProject2/vue4CalibInfo.mat'

% L2 Distances -> 2D Matrix [frame, joint]
L2D = zeros(1, 12);

% times out, efficiency issue with large num frames
for mocapFnum = 1000:1010
    % access input coordinates
    x = mocapJoints(mocapFnum, :, 1);
    y = mocapJoints(mocapFnum, :, 2);
    z = mocapJoints(mocapFnum, :, 3);
    conf = mocapJoints(mocapFnum, :, 4);
    
    % access focal length of both cameras
    f2 = vue2.foclen;
    f4 = vue4.foclen;

    % holds L2 distances for a 12 pair joint set until cleared on next
    % frame
    JointSet = zeros(1, 12);
    flag = 1; % used for checking if set is confident

    % loop through 12 joint points
    for i = 1:12
        % if one joint is not confident, throw out entire 12 set
        if conf(i) == 0
%             fprintf("joint conf %d\n", conf(i))
            flag = 0;
            break;
        end

        WorldCord = [ x(i) y(i) z(i) 1 ]';
        Pmat2 = padarray(vue2.Pmat, 1, 0, 'post'); 
        Pmat2(4, 4) = 1;
        CamCord2 = Pmat2 * WorldCord;
        FilmCord2 = [f2 0 0 0; 0 f2 0 0; 0 0 1 0] * CamCord2;
        FilmCord2x(i) = FilmCord2(1) / FilmCord2(3);
        FilmCord2y(i) = FilmCord2(2) / FilmCord2(3);
        u2(i) = FilmCord2x(i) + 960; % why 960?
        v2(i) = FilmCord2y(i) + 540; % why 540?

        Pmat4 = padarray(vue4.Pmat, 1, 0, 'post');
        Pmat4(4, 4) = 1;
        CamCord4 = Pmat4 * WorldCord;
        FilmCord4 = [f4 0 0 0; 0 f4 0 0; 0 0 1 0] * CamCord4;
        FilmCord4x(i) = FilmCord4(1) / FilmCord4(3); % I think this means scaled by dividing by depth row z so x/z
        FilmCord4y(i) = FilmCord4(2) / FilmCord4(3); % cross product right?
        u4(i) = FilmCord4x(i) + 960;
        v4(i) = FilmCord4y(i) + 540;

        Pu2(:, i) = [u2(i) v2(i) 1]';
        Pu4(:, i) = [u4(i) v4(i) 1]';

        K2 = [1 0 960; 0 1 540; 0 0 1] * [f2 0 0; 0 f2 0; 0 0 1];
        K4 = [1 0 960; 0 1 540; 0 0 1] * [f4 0 0; 0 f4 0; 0 0 1];
        R2 = Pmat2(1:3, 1:3); 
        C2 = vue2.position';
        R4 = Pmat4(1:3, 1:3);
        C4 = vue4.position';

        Pw(:, i) = Triangulation(Pu2(:, i), Pu4(:, i), K2, K4, R2, R4, C2, C4);
        D = Distance(WorldCord, Pw(:, i));

        JointSet(i) = D;
    end

    % confidence check
    if flag == 0
%         fprintf("skip case at frame %d\n", mocapFnum);
        L2D(mocapFnum, :) = 0; % all zero
    else
        L2D(mocapFnum, :) = JointSet; % should be 1x12
    end
    

end

% disp(size(L2D))

for joint = 1:12
    fprintf("JOINT %d\n", joint);
    fprintf("MEAN %d\n", mean(nonzeros(L2D(:, joint))));
    fprintf("STD %d\n", std(nonzeros(L2D(:, joint))));
    fprintf("MIN %d\n", min(nonzeros(L2D(:, joint))));
    fprintf("MEDIAN %d\n", median(nonzeros(L2D(:, joint))));
    fprintf("MAX %d\n", max(nonzeros(L2D(:, joint))));
    fprintf("\n\n\n");
end

fprintf("EVERYTHING\n");
fprintf("MEAN %d\n", mean(nonzeros(L2D(:, :))));
fprintf("STD %d\n", std(nonzeros(L2D(:, :))));
fprintf("MIN %d\n", min(nonzeros(L2D(:, :))));
fprintf("MEDIAN %d\n", median(nonzeros(L2D(:, :))));
fprintf("MAX %d\n", max(nonzeros(L2D(:, :))));
fprintf("\n\n\n");

