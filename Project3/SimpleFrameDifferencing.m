% Simple Frame Differencing
diff_fd = abs(b_fd - I{1});
M_fd{t} = threshold(diff_fd, lamda);
% Update the base frame to be the current frame
b_fd = I{1};