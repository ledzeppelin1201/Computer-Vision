function outimage = proj3main(dirstring, maxframenum, ...
    abs_diff_threshold, alpha_parameter, gamma_parameter)

% Simplify parameter names
lambda = abs_diff_threshold; alpha = alpha_parameter;
gamma = gamma_parameter;
% Initialize
I{1} = rgb2gray(imread(append(dirstring,'f0001.jpg')));
B_pfd{1} = I{1}; % This is B for Persistent Frame Differencing
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
    %% Persistent Frame Differencing
    diff = abs(B_pfd{t-1}-I{t});
    M{t} = threshold(diff,lambda);
    tmp = max(H{t-1}-gamma,0);
    H{t} = max(255*M{t},tmp);
    B_pfd{t} = I{t};
    
    %figure;
    imshow(uint8(H{t}))
    
end
    %outimage = [A B;C D];
end