%% MyMainScript

tic;
%% Your code here
% sobelX = [1 0 -1; 2 0 -2; 1 0 -1];
% sobelY = [1 2 1; 0 0 0; -1 -2 -1];
img = rescale(load('../data/boat.mat').imageOrig);
[Ix,Iy,Ie1,Ie2,Icornr] = myHarrisCornerDetector(img, 1.35, 0.5, 0.06);

%Output Images
% figure('Name', 'Derivative Images');
% subplot(1,2,1), imshow(Ix);
% axis equal tight on;
% title('Derivative along X-axis');
% colorbar;
% subplot(1,2,2), imshow(Iy);
% axis equal tight on;
% title('Derivative along Y-axis');
% colorbar;

% figure('Name', 'Eigenvalue Images');
% subplot(1,2,1), imshow(Ie2);
% axis equal tight on;
% title('Principal Eigenvalue');
% colorbar;
% subplot(1,2,2), imshow(Ie1);
% axis equal tight on;
% title('Another Eigenvalue');
% colorbar;

% figure('Name', 'Harris Corner Image');
% imshow(Icornr);

% figure, imshow(img);
figure, imshow(Ix);
figure, imshow(Iy);

toc;
