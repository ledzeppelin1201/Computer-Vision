%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%      To perform convolution on the input image with the set of filters.
%
% Input Variables:
%      inarray      Input image with size N*M*D1
%      filterbank   The set of filters, a 4-dimensional array of size R*C*D1*D2.
%      biasvals     A vector of length D2 containing bias values
%      
% Returned Results:
%      outarray     Output image with size N*M*D2
%
% Processing Flow:
%      1. Determine the sizes D1 and D2
%      2. Perform convolution using imfilter on the input image with 
%         corresponded filters throughout D1 channels
%      3. Sum up the convoluted results and add bias values
%      4. Repeat this process D2 times
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [outarray] = apply_convolve(inarray, filterbank, biasvals)
    D1=size(inarray,3); D2=size(filterbank,4);
    
    for l=1:D2
        for k=1:D1
            h = filterbank(:,:,k,l);
            A = inarray(:,:,k);
            Conv(:,:,k) = imfilter(A,h,'conv');
        end
        outarray(:,:,l) = sum(Conv,3)+biasvals(l);
    end
    
end
