function [blurr_img, radii] = mySpatiallyVaryingKernel(img, img_mask, alpha)
    [rows, columns, channels] = size(img);
    blurr_img = zeros(rows, columns, channels);
    radii = zeros(rows, columns, channels);
    
    % Padding img by 0's for convolution at border pixels %
    img_ch1 = imtile(img(:,:,1), 'BorderSize', alpha, 'GridSize', [1 1]);
    img_ch2 = imtile(img(:,:,2), 'BorderSize', alpha, 'GridSize', [1 1]);
    img_ch3 = imtile(img(:,:,3), 'BorderSize', alpha, 'GridSize', [1 1]);
    
    for i = 1:rows
        for j = 1:columns
            if img_mask(i, j) == 0
                dp = min_distance_from_foreground(i, j, img_mask);
                if dp <= alpha
                    r = dp;
                else 
                    r = alpha;
                end
                radii(i ,j) = r;
                r = round(r, 0);
                disc_kernel = fspecial('disk', r);
                blurr_img(i, j, 1) = sum(img_ch1(alpha+i-r:alpha+i+r, alpha+j-r:alpha+j+r) .* disc_kernel, 'all');
                blurr_img(i, j, 2) = sum(img_ch2(alpha+i-r:alpha+i+r, alpha+j-r:alpha+j+r) .* disc_kernel, 'all');
                blurr_img(i, j, 3) = sum(img_ch3(alpha+i-r:alpha+i+r, alpha+j-r:alpha+j+r) .* disc_kernel, 'all');
            else
                radii(i, j) = 0;
                for k = 1:channels
                    blurr_img(i, j, k) = img(i, j, k);
                end
            end
        end
    end
end

function [min_distance] = min_distance_from_foreground(x, y, img_mask)
    p1 = [x; y];
    [r, c] = size(img_mask);
    min_distance = sqrt(r^2 + c^2);
    
    for i = 1:r
        for j = 1:c
            if img_mask(i, j)
                p2 = [i; j];
                d = norm(p1 - p2);
                if d < min_distance
                    min_distance = d;
                end
            end
        end
    end 
end

