% This function will take an input color image (3 dimensional array of size
% N x M x 3) and output the array of the same size.
% Specifically, this will apply a scale to each color channel's pixel
% values into the output range -0.5 to 0.5.
% Formula: Out(i, j, k) = In(i, j, k) / 255.0 - 0.5
%
% This is a straightforward operation, but the matrix must be converted to
% a double to allow negative values since it's initially a unsigned 8 bit
% integer.
function result = apply_imnormalize(image)
    image = double(image);
    
    % Iterate through every pixel and normalize using given formula.
    for row = 1:32
        for column = 1:32
            for color = 1:3
                image(row, column, color) = (image(row, column, color) / 255.0) - 0.5;
            end
        end
    end
    
    % Display the image to show that it does scale from range -0.5 to 0.5.
    disp(image);
    
    result = image;
end