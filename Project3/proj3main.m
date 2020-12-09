function outimage = proj3main(dirstring, maxframenum, ...
    abs_diff_threshold, alpha_parameter, gamma_parameter)

% Simplify parameter names
lambda = abs_diff_threshold; alpha = alpha_parameter;
gamma = gamma_parameter;
% Initialize variables, use cell arrays to store images
% Convert f0001.jpg to grayscale as first element in I
I{1} = rgb2gray(imread(append(dirstring,'f0001.jpg')));
B_sbs = I{1}; % Background is constant for simple background subtraction
B_abs{1} = I{1}; % B for Adaptive Background Subtraction
B_sfd{1} = I{1}; % B for Adaptive Background Subtraction
B_pfd{1} = I{1}; % B for Persistent Frame Differencing
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
    diff_bs = abs(B_sbs - I{t});
    M_bs{t} = threshold(diff_bs, lambda);
    A = 255*M_bs{t};   
%     imshow(A);
    
  %% Simple Frame Differencing
    diff_sfd = abs(B_sfd{t-1} - I{t});
    M_sfd{t} = threshold(diff_sfd, lambda);   
    B_sfd{t} = I{t};
    B = 255*M_sfd{t};
    
    %% Adaptive Background Subtraction
    diff_abs = abs(B_abs{t-1} - I{t});
    M_abs{t} = threshold(diff_abs, lambda);
    B_abs{t} = alpha*I{t} + (1-alpha)*B_abs{t-1};
    C = 255*M_abs{t};
    
    %% Persistent Frame Differencing
    diff_pfd = abs(B_pfd{t-1}-I{t});
    M_pfd{t} = threshold(diff_pfd,lambda);
    tmp = max(H{t-1}-gamma,0);
    H{t} = max(255*M_pfd{t},tmp);
    B_pfd{t} = I{t};
    D = uint8(H{t});

    outimage = [A B; C D]; 
    imshow(outimage);

end

end