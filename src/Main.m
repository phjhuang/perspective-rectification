%% Clear all

clc;
clear all;
close all;

%% Attributes

testImage = '..\base\iPhone4\IMG_1255.JPG';
debug = 1;
con = 8;
edgeAlg = 'canny';
prop1 = 'BoundingBox'; 
prop2 = 'Eccentricity';
scale = 0.5;

%% Flow

% Preprocessamento
[rgbImage grayImage bwImage edgeImage labelledImage props numComps] = PreProcessImage(testImage, con, edgeAlg, prop1, prop2, scale);

% Descomentar para salvar as vari�veis e d� o load dentro da fun��o para economizar tempo
%save workspaceWorkspace.mat

% Debug
if debug == 1
    subplot(2,2,1), imshow(grayImage);
    subplot(2,2,2), imshow(bwImage);
    subplot(2,2,3), imshow(edgeImage);
end

% First Stage
[horizontalLines verticalLines] = StraightLineDetection( labelledImage, props, numComps, grayImage, bwImage, edgeImage);

%Vanishing Point Detections

%Second Stage
HorizontalTextLineDetection(LabelledImage, Props, numComps, GrayImage, verticalLines);