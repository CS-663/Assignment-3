function mask=calculateFlowerMask(image)
    % DO NOT CHANGE THESE VALUES
    xy_band = 100.0;
    image_band = 250.0;
    noOfNearest = 150;
    iterations = 50;
    
    seg_image = myMeanShiftSegmentation(image, xy_band, image_band, noOfNearest, iterations);    
    
    edge_canny = edge(seg_image(:,:,1), 'canny', [0.1 0.7], 2);
    
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