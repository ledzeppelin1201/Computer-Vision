%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%      To perform Softmax algorithm, taking a vector of arbitrary real 
%       numbers and converts them into numbers that can be viewed as
%       probabilities.
%
% Input Variables:
%      inarray      Input array with size 1*1*D
%      
% Returned Results:
%      outarray     Output image with size 1*1*D
%
% Processing Flow:
%      1. Determine alpha, the index of inarray that has the max value
%      2. Perform the algorithm with exponentials for D times
%      3. The output outarray would sum up to 1
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [outarray] = apply_softmax(inarray)
    D=size(inarray,3);
    [~,alpha] = max(inarray);
    
    for k=1:D
        outarray(k) = exp(inarray(k)-alpha)/sum(exp(inarray-alpha));
    end

end