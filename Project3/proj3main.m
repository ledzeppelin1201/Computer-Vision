function outimage = proj3main(dirstring, maxframenum, ...
    abs_diff_threshold, alpha_parameter, gamma_parameter)

% Simplify parameter names
lambda = abs_diff_threshold; alpha = alpha_parameter;
gamma = gamma_parameter;
% Initialize variables, use cell arrays to store images
% Convert f0001.jpg to grayscale as first element in I
I{1} = rgb2gray(imread(append(dirstring,'f0001.jpg')));
B_bs = I{1}; % Background is constant for simple background subtraction
B_fd{1} = I{1}; % This is B for Frame Differencing
H{1} = zeros(size(I{1}));

% Loop maxframenum times
for t=2:maxframenum
    % Since we have differnt number of zeros in image names,
    % we'll have to adjust it whenever decimal of t changes
    if t<10
        fdir=append('f000',num2str(t),'.jpg');
    elseif t<100
        fdir=append('f00',num2str(t),'.jpg');
    else
        fdir=append('f0',num2str(t),'.jpg');
    end
    % Convert to grayscale
    I{t} = rgb2gray(imread(append(dirstring,fdir))); % I(t)= next frame
    
    %% Simple Background Subtraction
    diff_bs = abs(B_bs - I{t});
    M_bs{t} = threshold(diff_bs, lambda);
    A = M_bs{t};   
%     imshow(A);
    
    %% Persistent Frame Differencing
    diff = abs(B_fd{t-1}-I{t});
    M{t} = threshold(diff,lambda);
    tmp = max(H{t-1}-gamma,0);
    H{t} = max(255*M{t},tmp);
    B_fd{t} = I{t};
%     D = uint8(H{t});
    D = H{t};

    outimage = [A zeros(size(A)); zeros(size(A)) D]; 
    imshow(outimage);

%     imshow(outimage);
    
    %figure;
%     imshow(uint8(H{t}))
    
end
    %outimage = [A B;C D];
end