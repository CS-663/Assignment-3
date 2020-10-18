%% MyMainScript

bird_img = im2double(imread('../data/bird.jpg'));
flower_img = im2double(imread('../data/flower.jpg'));

gaussian_kernel = fspecial('gaussian', [3 3], 0.7);
scaled_bird_img = imresize(imfilter(bird_img, gaussian_kernel), 1/2);

%% Generating foreground mask

% takes 20 minutes
bird_mask = calculateBirdMask(bird_img);
scaled_bird_mask = imresize(imfilter(bird_mask, gaussian_kernel), 1/2);
flower_mask = calculateFlowerMask(flower_img);

%% Background blurring by varying radii disk kernel

%takes 20 minutes
[blurr_bird_img, radii_bird] = mySpatiallyVaryingKernel(scaled_bird_img, scaled_bird_mask, 20);
radii_bird = radii_bird(:,:,1);
figure();
imshow(blurr_bird_img);
axis on;
title('Blured Bird Image');

%takes 10 minutes
[blurr_flower_img, radii_flower] = mySpatiallyVaryingKernel(flower_img, flower_mask, 20);
radii_flower = radii_flower(:,:,1);
figure();
imshow(blurr_flower_img);
axis on;
title('Blured Flower Image');

%% Variation of radii of disk kernel 

figure();
subplot(1,2,1);
imshow(radii_bird, 'DisplayRange', [], 'Colormap', jet(256));
axis on;
title('Variation of radii of disk kernel over bird image');

subplot(1,2,2);
imshow(radii_flower, 'DisplayRange', [], 'Colormap', jet(256));
axis on;
title('Variation of radii of disk kernel over flower image');

%% Disk kernel of varrying radii

figure();
alpha = 40;

subplot(2,5,1);
imshow(normalize_disk(0.2, alpha));
axis on;
title("r = 0.2 * alpha");

subplot(2,5,2);
imshow(normalize_disk(0.4, alpha));
axis on;
title("r = 0.4 * alpha");

subplot(2,5,3);
imshow(normalize_disk(0.6, alpha));
axis on;
title("r = 0.6 * alpha");

subplot(2,5,4);
imshow(normalize_disk(0.8, alpha));
axis on;
title("r = 0.8 * alpha");

subplot(2,5,5);
imshow(normalize_disk(1, alpha));
axis on;
title("r = alpha");

alpha = 20;

subplot(2,5,6);
imshow(normalize_disk(0.2, alpha));
axis on;
title("r = 0.2 * alpha");

subplot(2,5,7);
imshow(normalize_disk(0.4, alpha));
axis on;
title("r = 0.4 * alpha");

subplot(2,5,8);
imshow(normalize_disk(0.6, alpha));
axis on;
title("r = 0.6 * alpha");

subplot(2,5,9);
imshow(normalize_disk(0.8, alpha));
axis on;
title("r = 0.8 * alpha");

subplot(2,5,10);
imshow(normalize_disk(1, alpha));
axis on;
title("r = alpha");

function [disk] = normalize_disk(ratio, alpha)
    disk = fspecial('disk',ratio * alpha);
    disk = (disk - min(min(disk))) / (max(max(disk))- min(min(disk)));
end
