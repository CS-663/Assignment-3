%% MyMainScript

tic;
%% Your code here
img = rescale(load('../data/boat.mat').imageOrig);
[Ix,Iy,Ie1,Ie2,Icornr] = myHarrisCornerDetector(img, 2, 0.45, 0.12);

%Output Images
figure('Name', 'Derivative Images');
subplot(1,2,1), imshow(Ix);
axis equal tight on;
title('Derivative along X-axis');
colorbar;
subplot(1,2,2), imshow(Iy);
axis equal tight on;
title('Derivative along Y-axis');
colorbar;

figure('Name', 'Eigenvalue Images');
subplot(1,2,1), imshow(Ie2);
axis equal tight on;
title('Principal Eigenvalue');
colorbar;
subplot(1,2,2), imshow(Ie1);
axis equal tight on;
title('Another Eigenvalue');
colorbar;

figure('Name', 'Harris Corner Image');
imshow(Icornr);
axis equal tight on;
title('Harris Corner Image');
colorbar;

toc;
