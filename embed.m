function watermarked_img = embed_watermark(host_image_path, watermark_image_path, output_path, alpha)
% DWT-SVD based image watermarking function
%
% Inputs:
%   host_image_path - path to the host image file
%   watermark_image_path - path to the watermark image file
%   output_path - path where watermarked image will be saved
%   alpha - watermark strength factor (default: 0.10)
%
% Output:
%   watermarked_img - the watermarked image

% Set default alpha if not provided
if nargin < 4
    alpha = 0.10;
end

% Load host image
rgbimage = imread(host_image_path);
figure;
imshow(rgbimage);
title('Original host image');

% Apply DWT on host image
[h_LL, h_LH, h_HL, h_HH] = dwt2(rgbimage, 'haar');
img = h_LL;

% Separate RGB channels
red1 = img(:,:,1);
green1 = img(:,:,2);
blue1 = img(:,:,3);

% Apply SVD on host image channels
[U_imgr1, S_imgr1, V_imgr1] = svd(red1);
[U_imgg1, S_imgg1, V_imgg1] = svd(green1);
[U_imgb1, S_imgb1, V_imgb1] = svd(blue1);

% Load watermark image
watermark = imread(watermark_image_path);
figure;
imshow(watermark);
title('Watermark image');

% Apply DWT on watermark image
[w_LL, w_LH, w_HL, w_HH] = dwt2(watermark, 'haar');
img_wat = w_LL;

% Separate RGB channels of watermark
red2 = img_wat(:,:,1);
green2 = img_wat(:,:,2);
blue2 = img_wat(:,:,3);

% Apply SVD on watermark image channels
[U_imgr2, S_imgr2, V_imgr2] = svd(red2);
[U_imgg2, S_imgg2, V_imgg2] = svd(green2);
[U_imgb2, S_imgb2, V_imgb2] = svd(blue2);

% Watermark embedding
S_wimgr = S_imgr1 + (alpha * S_imgr2);
S_wimgg = S_imgg1 + (alpha * S_imgg2);
S_wimgb = S_imgb1 + (alpha * S_imgb2);

% Reconstruct watermarked image components
wimgr = U_imgr1 * S_wimgr * V_imgr1';
wimgg = U_imgg1 * S_wimgg * V_imgg1';
wimgb = U_imgb1 * S_wimgb * V_imgb1';

% Combine RGB channels
wimg = cat(3, wimgr, wimgg, wimgb);
newhost_LL = wimg;

% Apply inverse DWT
watermarked_img = idwt2(newhost_LL, h_LH, h_HL, h_HH, 'haar');

% Save and display the result
imwrite(uint8(watermarked_img), output_path);
figure;
imshow(uint8(watermarked_img));
title('Watermarked Image');

% Optional: Display the file name of the watermark used
[~, watermark_name, watermark_ext] = fileparts(watermark_image_path);
fprintf('Image watermarked with: %s%s\n', watermark_name, watermark_ext);
end


embed_watermark('host.jpg', 'watermark.jpg', 'watermarked1.jpg');
embed_watermark('host.jpg', 'watermark2.jpg', 'watermarked2.jpg');
embed_watermark('host.jpg', 'watermark3.jpg', 'watermarked3.jpg');
