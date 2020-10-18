function LAB = RGBtoLAB(RGB)
    XYZ = rgb2xyz(RGB);
    LAB = xyz2lab(XYZ);
end