%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:  
%      To perform convolution on the input image with the set of filters.
%
% Input Variables:
%      inarray      Input image with size N*M*D1
%      filterbank   The set of filters, a 4-dimensional array of size R*C*D1*D2.
%      biasvals     
%      
% Returned Results:
%      outarray     Output image with size N*M*D1
%
% Processing Flow:
%      1. Assign values to Bf
%      2. Create Bb as ~Bf (-inf not considered)
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
        sumc = sum(Conv,3);
        outarray(:,:,l) = sum(Conv,3)+biasvals(l);
    end
    %disp(outarray)
    %imshow(outarray)
end