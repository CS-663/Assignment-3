function segmented = myMeanShiftSegmentation(image, xy_band, image_band, noOfNearest, iterations)
    [height, width, ~] = size(image);
    
    x = 1:width;
    y = 1:height;
    image = RGBtoLAB(image);
    
    % 5-D feature vector
    [X, Y] = meshgrid(x, y);
    feature_vec = reshape(cat(3, cat(3,X,Y), image), height*width, 5);
    
    totalPixels = height*width;
    
    bar = waitbar(0, "Progress");
    for i = 1:iterations
        % To get the nearest neighbours
        % https://in.mathworks.com/help/vision/ref/pointcloud.findnearestneighbors.html
        % https://in.mathworks.com/help/stats/classification-using-nearest-neighbors.html#bsehylk
        [neighbour, ~] =  knnsearch(feature_vec,feature_vec,'K',noOfNearest);
        
         temp_feature_vec = feature_vec;
        for j = 1:totalPixels
            xy_dist = sum((temp_feature_vec(neighbour(j,:), 1:2)-temp_feature_vec(j, 1:2)).^2, 2);
            image_dist = sum((temp_feature_vec(neighbour(j,:), 3:5)-temp_feature_vec(j, 3:5)).^2, 2);
            weights = exp(-(xy_dist./xy_band).^2).*exp(-(image_dist./image_band).^2);
            
            weights = squeeze(cat(3, weights, weights, weights));
            feature_vec(j, 3:5) = sum(weights.*temp_feature_vec(neighbour(j,:),3:5))./sum(weights);
        end
        waitbar(i/iterations); 
    end
    
    close(bar);
    segmented = LABtoRGB(reshape(feature_vec(:, 3:5), [height, width, 3]));

end