%% MyMainScript

tic;
%% Your code here
 
 % Reading in baboonColor.png
 baboon = im2double(imread('../data/baboonColor.png'));
 
 % Reading in bird.jpg
 bird = im2double(imread('../data/bird.jpg'));
 
 % Reading in flower.jpg
 flower = im2double(imread('../data/flower.jpg'));
 
 % Setting image for input['bird' , 'flower' , 'baboon']
 input_name = 'baboon';
 
 if strcmp(input_name, 'bird')
     xy_band = 125.0;
     image_band = 250.0;
     noOfNearest = 185;
     iterations = 50;
     input = contrast_streching(downscaling(bird, 2));
 elseif strcmp(input_name, 'flower')
     xy_band = 100.0;
     image_band = 250.0;
     noOfNearest = 170;
     iterations = 50;
     input = contrast_streching(downscaling(flower, 1));
 else
     xy_band = 25.0;
     image_band = 250.0;
     noOfNearest = 125;
     iterations = 35;
     input = contrast_streching(downscaling(baboon, 1));
 end
 
% Running the mean shift algorithm
seg_image = myMeanShiftSegmentation(input, xy_band, image_band, noOfNearest, iterations);

% scatter plot for the input image
colorcloud(contrast_streching(input));

% Scatter plot for the Segmented image
colorcloud(seg_image);


figure;
subplot(1, 2, 1);
imshow(input);
axis on;
title('Original');

subplot(1, 2, 2);
imshow(seg_image);
axis on;
title('Segmented image');

linkaxes;

saveas(gcf, sprintf('../images/%s_%d_%d_%d_%d.png',input_name,xy_band, image_band, noOfNearest, iterations));

toc;
