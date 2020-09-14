clear all
close all

% Main routine which reads the input files, calls the other layer functions in the right order, and analyzes/reports the classification results. 

% Referenced from the project 1 description.
load 'Project1DataFiles/cifar10testdata.mat'
%loading this file defines imrgb and layerResults
load 'Project1DataFiles/debuggingTest.mat'

% This iterates through each picture class (ie airplane, automobile, etc.)
% and access a single image that is a 3 dimensional matrix (row, column,
% color channel).
for classindex = 1
    % indices represents a vector/array of 1000 elements -> row of 1000
    % elements
    indices = find(trueclass==classindex);
    
    size(indices) % 1 row, 1000 columns
    
    % Access the first color image of the particular picture class.
    %image_rgb = imageset(:, :, :, indices(1)); 
    
    image_rgb = imrgb;
    
    size(image_rgb) % 3D matrix [32 x 32 x 3]
    
    disp(image_rgb) % will print the entire 3d matrix
    
    % testing that apply_imnormalize() worked
    fprintf('TESTING IMNORMALIZE\n');
    inarray1 = image_rgb;
    outarray1 = apply_imnormalize(inarray1); % should invoke disp(image) as well
    
    %loading this file defines filterbanks and biasvectors
    load 'Project1DataFiles/CNNparameters.mat'
    %sample code to verify which layers have filters and biases
    for d = 1:length(layertypes)
    fprintf('layer %d is of type %s\n',d,layertypes{d});
    filterbank = filterbanks{d};
        if not(isempty(filterbank))
            fprintf(' filterbank size %d x %d x %d x %d\n', ...
            size(filterbank,1),size(filterbank,2), ...
            size(filterbank,3),size(filterbank,4));
            biasvec = biasvectors{d};
            fprintf(' number of biases is %d\n',length(biasvec));
        end
    end
    % testing that apply_convolve() worked
    fprintf('TESTING CONVOLUTION\n');
    inarray2 = outarray1;
    outarray2 = apply_convolve(inarray2, cell2mat(filterbanks(1,2)), cell2mat(biasvectors(1,2)));
    
    % testing that apply_relu() worked
    fprintf('TESTING RELU\n');
    inarray3 = outarray2;
    outarray3 = apply_relu(inarray3); % also dispapply_relu(inarray3); % also disp
    
    % testing that apply_softmax() worked
    fprintf('TESTING SOFTMAX\n');
    inarray4 = outarray3(16,16,:); % Manually picked just for testing
    outarray4 = apply_softmax(inarray4);
     
    % Shows the image.
    figure(1); imagesc(image_rgb); truesize(gcf, [64, 64]);
    title(sprintf('%s', classlabels{classindex}));
end

%% debug

%sample code to show image and access expected results
figure; imagesc(imrgb); truesize(gcf,[64 64]);
for d = 1:length(layerResults)
    result = layerResults{d};
    fprintf('layer %d output is size %d x %d x %d\n',...
    d,size(result,1),size(result,2), size(result,3));
end
%find most probable class
classprobvec = squeeze(layerResults{end});
[maxprob,maxclass] = max(classprobvec);
%note, classlabels is defined in ’cifar10testdata.mat’
fprintf('estimated class is %s with probability %.4f\n',...
classlabels{maxclass},maxprob);
