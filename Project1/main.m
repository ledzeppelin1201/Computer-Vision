load 'Project1DataFiles/cifar10testdata.mat'
load 'Project1DataFiles/CNNparameters.mat'

fprintf("COMPUTE CONFUSION MATRIX --> IT TAKES ABOUT 15 MINUTES TO PROCESS 10000 IMAGES\n");

confusion_matrix = zeros(10);

for classindex = 1:10
    indices = find(trueclass==classindex);
    
    fprintf("PROCESSING CLASS %s...\n", classlabels{classindex});
    
    % This takes a while to compute since we need to process 10000 images
    % in total.
    for index = 1:1000
        image_rgb = imageset(:, :, :, indices(index));
        
        % Layer 1 (imnormalize) 
        inarray1 = image_rgb;
        outarray1 = apply_imnormalize(inarray1);

        % Layer 2 (convolve) 
        inarray2 = outarray1;
        outarray2 = apply_convolve(inarray2, cell2mat(filterbanks(1,2)), cell2mat(biasvectors(1,2)));

        % Layer 3 (relu) 
        inarray3 = outarray2;
        outarray3 = apply_relu(inarray3);

        % Layer 4 (convolve) 
        inarray4 = outarray3;
        outarray4 = apply_convolve(inarray4, cell2mat(filterbanks(1,4)), cell2mat(biasvectors(1,4)));

        % Layer 5 (relu)
        inarray5 = outarray4;
        outarray5 = apply_relu(inarray5);

        % Layer 6 (maxpool)
        inarray6 = outarray5;
        outarray6 = apply_maxpool(inarray6);

        % Layer 7 (convolve)
        inarray7 = outarray6;
        outarray7 = apply_convolve(inarray7, cell2mat(filterbanks(1,7)), cell2mat(biasvectors(1,7)));

        % Layer 8 (relu)
        inarray8 = outarray7;
        outarray8 = apply_relu(inarray8);

        % Layer 9 (convolve)
        inarray9 = outarray8;
        outarray9 = apply_convolve(inarray9, cell2mat(filterbanks(1,9)), cell2mat(biasvectors(1,9)));    

        % Layer 10 (relu)
        inarray10 = outarray9;
        outarray10 = apply_relu(inarray10);

        % Layer 11 (maxpool)
        inarray11 = outarray10;
        outarray11 = apply_maxpool(inarray11);

        % Layer 12 (convolve)
        inarray12 = outarray11;
        outarray12 = apply_convolve(inarray12, cell2mat(filterbanks(1,12)), cell2mat(biasvectors(1,12)));  

        % Layer 13 (relu)
        inarray13 = outarray12;
        outarray13 = apply_relu(inarray13);

        % Layer 14 (convolve)
        inarray14 = outarray13;
        outarray14 = apply_convolve(inarray14, cell2mat(filterbanks(1,14)), cell2mat(biasvectors(1,14)));  

        % Layer 15 (relu)
        inarray15 = outarray14;
        outarray15 = apply_relu(inarray15);

        % Layer 16 (maxpool)
        inarray16 = outarray15;
        outarray16 = apply_maxpool(inarray16);

        % Layer 17 (fullyconnect)
        inarray17 = outarray16;
        outarray17 = apply_fullyconnect(inarray17, cell2mat(filterbanks(1,17)), cell2mat(biasvectors(1,17)));  

        % Layer 18 (softmax)
        inarray18 = outarray17;
        outarray18 = apply_softmax(inarray18);
        
%         fprintf("The class label is %s\n", classlabels{classindex}); 
        
        [maxprob, maxclass] = max(outarray18);
%         fprintf("The predicted class label is %s with probability %.4f\n", classlabels{maxclass}, maxprob);
        
        confusion_matrix(classindex, maxclass) = confusion_matrix(classindex, maxclass) + 1;
%         disp(confusion_matrix)
%         fprintf("------------------------------\n");
    end
    
end

fprintf("FINISHED\n");

disp(confusion_matrix);

accurate = 0;

for i = 1:10
    accurate = accurate + confusion_matrix(i, i);
end

accuracy = accurate / 10000

fprintf("There are %d correct predictions out of %d with an accuracy of %.4f\n", accurate, 10000, accuracy);
