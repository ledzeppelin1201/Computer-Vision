clear all
close all

load 'FilesForProject2/Subject4-Session3-Take4_mocapJoints.mat'
load 'FilesForProject2/vue2CalibInfo.mat'
load 'FilesForProject2/vue4CalibInfo.mat'

%% Extract info
%mocapFnum = 1000; %mocap frame number 1000

for i = 1:13
    mocapFnum = i*2000;
    %mocapFnum = 1000;
    x = mocapJoints(mocapFnum,:,1); %array of 12 X coordinates
    y = mocapJoints(mocapFnum,:,2); % Y coordinates
    z = mocapJoints(mocapFnum,:,3); % Z coordinates
    conf = mocapJoints(mocapFnum,:,4); %confidence values

    % focal lengths for both videos
    %f2 = vue2.foclen; f4 = vue4.foclen;
    % Loop for 12 joint points
    for i=1:12
        %% Projection
        % The given joint coordinates are in world coordinates
        WorldCord = [x(i) y(i) z(i) 1]';

        % Perform Projection for vue2
        [proj2(i,:)] = project3DTo2D(vue2,WorldCord);

        % Perform Projection for vue4
        [proj4(i,:)] = project3DTo2D(vue4,WorldCord);

        %% Triangulation
        %
        Pu2 = [proj2(i,1) proj2(i,2) 1]';  Pu4 = [proj4(i,1) proj4(i,2) 1]'; 
        Pw(:,i) = reconstruct3DFrom2D(vue2, Pu2, vue4, Pu4);

        % Pw contains the estimated 3D points 
        %Pw(:,i) = Triangulation(Pu2(:,i),Pu4(:,i),K2,K4,R2,R4,C2,C4);

        %[EpL1(:,i),EpL2(:,i)] = epipolar_lines_coorelation(vue2,vue4);
        % 2D Camera pixel coordinates
        CamCor2 = [proj2(i,1) proj2(i,2)]'; CamCor2 = padarray(CamCor2,1,1,'post');
        CamCor4 = [proj4(i,1) proj4(i,2)]'; CamCor4 = padarray(CamCor4,1,1,'post');

        [EpL1(:,i), EpL2(:,i)] = findEpipolarLines(WorldCord, vue2, CamCor2, vue4, CamCor4);

    end


    %% Read videos and plot joints
    %initialization of VideoReader for the vue2 video.
    filenamevue2mp4 = 'Subject4-Session3-24form-Full-Take4-Vue2.mp4';
    vue2video = VideoReader(filenamevue2mp4);
    %now we can read in the video for any mocap frame mocapFnum.
    %the (50/100) factor is here to account for the difference in frame
    %rates between video (50 fps) and mocap (100 fps).
    vue2video.CurrentTime = (mocapFnum-1)*(50/100)/vue2video.FrameRate;
    vid2Frame = readFrame(vue2video);

    % Plot the joints and the epipolar lines on the frame for vue2
    PlotJoints(vid2Frame,proj2,EpL1);

    %initialization of VideoReader for the vue4 video.
    filenamevue4mp4 = 'Subject4-Session3-24form-Full-Take4-Vue4.mp4';
    vue4video = VideoReader(filenamevue4mp4);
    vue4video.CurrentTime = (mocapFnum-1)*(50/100)/vue4video.FrameRate;
    vid4Frame = readFrame(vue4video);

    % Plot the joints and the epipolar lines on the frame for vue4
    PlotJoints(vid4Frame,proj4,EpL2);
end
