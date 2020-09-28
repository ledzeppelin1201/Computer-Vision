%apply_maxpool
%This function will take an input image and output an array of
%half the size for the spacial dimensions N x M
%Use subDiv_image as 2 x 2 sub-array
%uses max function to take max value from each subarray for a final
%maxpool output

function result = apply_maxpool(image)
    
    [row_len, col_len, D] = size(image);
    N=row_len/2; M=col_len/2;
    result = zeros(N,M,D);
    
    for ch=1:D
        for row = 1:N
            for col = 1:M
                subDiv_image = image(row*2-1:row*2,col*2-1:col*2,ch);
                outpix = max(subDiv_image(:));
                result(row,col,ch) = outpix;
            end
        end
    end

end
                
                