% Main routine which reads the input files, calls the other layer functions in the right order, and analyzes/reports the classification results. 

% Referenced from the project 1 description.
load './Project1DataFiles/cifar10testdata.mat'

% This iterates through each picture class (ie airplane, automobile, etc.)
% and access a single image that is a 3 dimensional matrix (row, column,
% color channel).
for classindex = 1
    % indices represents a vector/array of 1000 elements -> row of 1000
    % elements
    indices = find(trueclass==classindex);
    
    size(indices) % 1 row, 1000 columns
    
    % Access the first color image of the particular picture class.
    image_rgb = imageset(:, :, :, indices(1)); 
    
    size(image_rgb) % 3D matrix [32 x 32 x 3]
    
    disp(image_rgb) % will print the entire 3d matrix
    
    % testing that apply_imnormalize() worked
    inarray = image_rgb;
    outarray = apply_imnormalize(inarray); % should invoke disp(image) as well
    
    % Shows the image.
    figure(1); colormap(gray); imagesc(image_rgb); truesize(gcf, [64, 64]);
    title(sprintf('%s', classlabels{classindex}));
end