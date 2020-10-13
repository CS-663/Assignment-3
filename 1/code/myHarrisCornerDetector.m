function [Ix,Iy,Ie1,Ie2,Icornr]=myHarrisCornerDetector(img,sg1,sg2,k)
%     hfWnd = 2;      %half Window Size of patch
    Ismth = imgaussfilt(img, sg1);
    [nr, nc] = size(img);
%     gFilter = fspecial('gaussian', 2*hf+1, sg2);

    % Image Derivative Calculation
%     Ix = conv2(Ismth, sobelX, 'same');
%     Iy = conv2(Ismth, sobelY, 'same');
    [Ix, Iy] = imgradientxy(Ismth);
    Ix2 = Ix .^ 2;
    Iy2 = Iy .^ 2;
    Ixy = Ix .* Iy;
    
    % Weighted gaussian sum of products around patch size 2*hfWnd + 1;
%     Wx2 = conv2(Ix2, gFilter, 'same');
%     Wy2 = conv2(Iy2, gFilter, 'same');
%     Wxy = conv2(Ixy, gFilter, 'same');
    Wx2 = imgaussfilt(Ix2, sg2);
    Wy2 = imgaussfilt(Iy2, sg2);
    Wxy = imgaussfilt(Ixy, sg2);
    A = zeros(nr, nc, 2, 2);
    A(:, :, 1,1) = Wx2;
    A(:, :, 1,2) = Wxy;
    A(:, :, 2,1) = Wxy;
    A(:, :, 2,2) = Wy2;
    
    % eigen decomposition and harris corner measure
    Ie1 = zeros(nr, nc);
    Ie2 = zeros(nr, nc);
    Icornr = zeros(nr, nc);
    for u = 1:nr
        for v = 1:nc
            Atemp = zeros(2);
            Atemp(:,:) = A(u, v, :, :);
            e = sort(eig(Atemp));
            Ie1(u,v) = e(1);
            Ie2(u,v) = e(2);    %Ie2 is principal eigenvalue as it's larger
            Icornr(u,v) = e(1)*e(2) - k*(e(1) + e(2))^2;
        end
    end
    Icornr = Icornr > 1e-5;
end