function mask = calculateBirdMask(image)
    canny_R = edge((image(:,:,1)), 'canny', [0.05 0.5], 1.1);
    canny_G = edge((image(:,:,2)), 'canny', [0.15 0.5], 1.1);
    canny_B = edge((image(:,:,3)), 'canny', [0.15 0.5], 1.1);
    edge_canny = canny_R | canny_G | canny_B;
    
    % https://in.mathworks.com/matlabcentral/answers/341305-how-to-impose-binary-mask-on-rgb-color-image
    mask = imfill(edge_canny, 'holes');
    figure;
    subplot(2, 2, 1);
    imshow(image);
    axis on;
    title('Original');

    subplot(2, 2, 2);
    imshow(mask);
    axis on;
    title('Mask');

    maskImage = bsxfun(@times, image, cast(mask, 'like', image));

    subplot(2, 2, 3);
    imshow(maskImage);
    axis on;
    title('Foreground');

    notmaskImage = bsxfun(@times, image, cast(~mask, 'like', image));
    subplot(2, 2, 4);
    imshow(notmaskImage);
    axis on;
    title('Background');
    
    linkaxes;
    end
