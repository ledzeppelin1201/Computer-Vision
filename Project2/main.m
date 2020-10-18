clear all
close all

load 'FilesForProject2/Subject4-Session3-Take4_mocapJoints.mat'
load 'FilesForProject2/vue2CalibInfo.mat'
load 'FilesForProject2/vue4CalibInfo.mat'

%% Extract info
mocapFnum = 1000; %mocap frame number 1000
x = mocapJoints(mocapFnum,:,1); %array of 12 X coordinates
y = mocapJoints(mocapFnum,:,2); % Y coordinates
z = mocapJoints(mocapFnum,:,3); % Z coordinates
conf = mocapJoints(mocapFnum,:,4); %confidence values

%% Projection
% focal lengths for both videos
f2 = vue2.foclen; f4 = vue4.foclen;
for i=1:12
    % The given joint coordinates are in world coordinates
    WorldCord = [x(i) y(i) z(i) 1]';
    % Pad the Pmat(3*4) to 4*4 matrix with 0, 1 for multiplication
    Pmat2 = padarray(vue2.Pmat,1,0,'post');  Pmat2(4,4)=1;
    % Rotate and translate WorldCord into camera coordinates
    CamCord = Pmat2*WorldCord;
    % Apply forward projection, translate into pixel coordinates
    FilmCord2 = [f2 0 0 0; 0 f2 0 0; 0 0 1 0]*CamCord;
    FilmCord2x(i)=FilmCord2(1)/FilmCord2(3); FilmCord2y(i)=FilmCord2(2)/FilmCord2(3);
    u2(i)=FilmCord2x(i)+960; v2(i)=FilmCord2y(i)+540;
    
    % Repeat the same for vue4
    Pmat4 = padarray(vue4.Pmat,1,0,'post');  Pmat4(4,4)=1;
    CamCord4 = Pmat4*WorldCord;
    FilmCord4 = [f4 0 0 0; 0 f4 0 0; 0 0 1 0]*CamCord4;
    FilmCord4x(i)=FilmCord4(1)/FilmCord4(3); FilmCord4y(i)=FilmCord4(2)/FilmCord4(3);
    u4(i)=FilmCord4x(i)+960; v4(i)=FilmCord4y(i)+540;
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

% Show the frame image for vue2
figure
imshow(vid2Frame)
% Plot the joint coordinates on the image
axis on
hold on
plot(u2,v2, 'r*', 'MarkerSize', 5, 'LineWidth', 2);
hold off

%initialization of VideoReader for the vue4 video.
filenamevue4mp4 = 'Subject4-Session3-24form-Full-Take4-Vue4.mp4';
vue4video = VideoReader(filenamevue4mp4);
vue4video.CurrentTime = (mocapFnum-1)*(50/100)/vue4video.FrameRate;
vid4Frame = readFrame(vue4video);

% Show the frame image for vue4
figure
imshow(vid4Frame)
% Plot the joint coordinates on the image
axis on
hold on
plot(u4,v4, 'r*', 'MarkerSize', 5, 'LineWidth', 2);
hold off

