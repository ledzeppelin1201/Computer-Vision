# Project 1

Project on using convolutional neural networks or image recognition of the CIFAR 10 color image dataset

Functions
- main.m
- compute_accuracy.m

- apply_imnormalize.m
- apply_relu.m
- apply_convolution.m
- apply_fullconnect.m
- apply_softmax.m
- apply_maxpool.m

Running main.m will run the given color airplane imrgb from debuggingtest through all 18 layers and compare it with the expected result.
Notice that the end result vector from softmax has max probability of 0.5252 for class 1 (airplane) which is exactly what we expect from the debugging result.

Running compute_accuracy.m will take 15 minutes to process 10000 images and compute the accuracy and confusion matrix.
We generated an overall accuracy of 0.4371 with 4371 accurate predictions out of 10000.