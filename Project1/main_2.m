clear all
close all

% Main routine which reads the input files, calls the other layer functions in the right order, and analyzes/reports the classification results. 

% Referenced from the project 1 description.
load 'Project1DataFiles/cifar10testdata.mat'
%loading this file defines imrgb and layerResults
load 'Project1DataFiles/debuggingTest.mat'
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

% This iterates through each picture class (ie airplane, automobile, etc.)
% and access a single image that is a 3 dimensional matrix (row, column,
% color channel).
for classindex = 1
    % indices represents a vector/array of 1000 elements -> row of 1000
    % elements
    indices = find(trueclass==classindex);
    
%     image_rgb = imageset(:, :, :, indices(1)); % gets a single image of the class

    % Debug Verification
    image_rgb = imrgb;
    
    % Layer 1 (imnormalize) 
    fprintf('1: IMNORMALIZE\n');
    inarray1 = image_rgb;
    outarray1 = apply_imnormalize(inarray1);
    
    % Layer 2 (convolve) 
    fprintf('2: CONVOLUTION\n');
    inarray2 = outarray1;
    outarray2 = apply_convolve(inarray2, cell2mat(filterbanks(1,2)), cell2mat(biasvectors(1,2)));
    
    % Layer 3 (relu) 
    fprintf('3: RELU\n');
    inarray3 = outarray2;
    outarray3 = apply_relu(inarray3);
    
    % Layer 4 (convolve) 
    fprintf('4: CONVOLUTION\n');
    inarray4 = outarray3;
    outarray4 = apply_convolve(inarray4, cell2mat(filterbanks(1,4)), cell2mat(biasvectors(1,4)));
    
    % Layer 5 (relu)
    fprintf('5: RELU\n');
    inarray5 = outarray4;
    outarray5 = apply_relu(inarray5);
    
    % Layer 6 (maxpool)
    fprintf('6: MAXPOOL\n');
    inarray6 = outarray5;
    outarray6 = apply_maxpool(inarray6);
    
    % Layer 7 (convolve)
    fprintf('7: CONVOLUTION\n');
    inarray7 = outarray6;
    outarray7 = apply_convolve(inarray7, cell2mat(filterbanks(1,7)), cell2mat(biasvectors(1,7)));
    
    % Layer 8 (relu)
    fprintf('8: RELU\n');
    inarray8 = outarray7;
    outarray8 = apply_relu(inarray8);
    
    % Layer 9 (convolve)
    fprintf('9: CONVOLUTION\n');
    inarray9 = outarray8;
    outarray9 = apply_convolve(inarray9, cell2mat(filterbanks(1,9)), cell2mat(biasvectors(1,9)));    
    
    % Layer 10 (relu)
    fprintf('10: RELU\n');
    inarray10 = outarray9;
    outarray10 = apply_relu(inarray10);
    
    % Layer 11 (maxpool)
    fprintf('11: MAXPOOL\n');
    inarray11 = outarray10;
    outarray11 = apply_maxpool(inarray11);
    
    % Layer 12 (convolve)
    fprintf('12: CONVOLUTION\n');
    inarray12 = outarray11;
    outarray12 = apply_convolve(inarray12, cell2mat(filterbanks(1,12)), cell2mat(biasvectors(1,12)));  
    
    % Layer 13 (relu)
    fprintf('13: RELU\n');
    inarray13 = outarray12;
    outarray13 = apply_relu(inarray13);
    
    % Layer 14 (convolve)
    fprintf('14: CONVOLUTION\n');
    inarray14 = outarray13;
    outarray14 = apply_convolve(inarray14, cell2mat(filterbanks(1,14)), cell2mat(biasvectors(1,14)));  
    
    % Layer 15 (relu)
    fprintf('15: RELU\n');
    inarray15 = outarray14;
    outarray15 = apply_relu(inarray15);
    
    % Layer 16 (maxpool)
    fprintf('16: MAXPOOL\n');
    inarray16 = outarray15;
    outarray16 = apply_maxpool(inarray16);
    
    % Layer 17 (fullyconnect)
    fprintf('17: FULLY_CONNECT\n');
    inarray17 = outarray16;
    outarray17 = apply_fullyconnect(inarray17, cell2mat(filterbanks(1,17)), cell2mat(biasvectors(1,17)));  
    
    % Layer 18 (softmax)
    fprintf('18: SOFTMAX\n');
    inarray18 = outarray17;
    outarray18 = apply_softmax(inarray18);
    
    disp(outarray18) % what does this represent? it represents the probability of the class being a particular type
    figure; bar(outarray18)
    
    % not sure why the images are not changing, showing image_rgb but it's
    % always airplane
     
    % Shows the image.
    figure; imagesc(image_rgb); truesize(gcf, [64, 64]);
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
