%{
% dirstring and maxframenum for different datasets

dirstring = 'DataSets/DataSets/ArenaA/';  maxframenum=295;
dirstring = 'DataSets/DataSets/ArenaN/';  maxframenum=513;
dirstring = 'DataSets/DataSets/AShipDeck/';  maxframenum=368;
dirstring = 'DataSets/DataSets/getin/';  maxframenum=591;
dirstring = 'DataSets/DataSets/getout/';  maxframenum=656;
dirstring = 'DataSets/DataSets/movecam/';  maxframenum=211;
dirstring = 'DataSets/DataSets/trees/';  maxframenum=132;
dirstring = 'DataSets/DataSets/walk/';  maxframenum=283;
%}

close all
clear all

dirstring = 'DataSets/DataSets/walk/';  maxframenum=283;
abs_diff_threshold = 30; % for converting absolute intensity difference values into binary values, 0-255
alpha_parameter = 0.3; % blending parameter for ABS, 0-1
gamma_parameter = 10; % decay parameter for PFD, 0-255
proj3main(dirstring, maxframenum, abs_diff_threshold, alpha_parameter, gamma_parameter);

