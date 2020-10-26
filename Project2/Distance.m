%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%      To calculate the L2 Euclidean Distance between the given world 
%      coordinate and the reconstructed world coordinate of a particular 
%      joint in a frame.
%
% Input Variables:
%      W          4x1 given world XYZ1 coordinates
%      R          3x1 reconstructed world X'Y'Z' coordinates
%
% Returned Results:
%      D          L2 distance between the two coordinates
%
% Processing Flow:
%      1. Apply formula sqrt( (X-X’)^2 + (Y-Y’)^2 + (Z-Z’)^2 ).
%      2. Return result distance.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function D = Distance(W, R)
    X = W(1);
    Y = W(2);
    Z = W(3);
    
    XP = R(1);
    YP = R(2);
    ZP = R(3);
    
    D = sqrt((X - XP)^2 + (Y - YP)^2 + (Z - ZP)^2);
end