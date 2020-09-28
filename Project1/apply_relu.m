% This function take an input array of size N x M x D and outputs an array
% of the same size.
% The purpose of the rectified linear unit is to act as a thresholding
% operation that sets any negative pixel values to become 0 in the output
% array.
% Formula: Out(i, j, k) = max(In(i, j, k), 0)
%
% Straight forward operation, assuming input image is double type and we
% have a variable row, column, and color channel size which you need to
% consider.
function result = apply_relu(image)
    % I'm assuming the image is a double type.
    
    % Establish row, column, and color channel size.
    [row_len, column_len, color_len] = size(image);
    
    % Iterate through every pixel and change all negative values to 0.
    for row = 1:row_len
        for column = 1:column_len
            for color = 1:color_len
                pixel = image(row, column, color);
                
                if pixel < 0
                    image(row, column, color) = 0;
                end
            end
        end
    end   
    
    result = image;
end