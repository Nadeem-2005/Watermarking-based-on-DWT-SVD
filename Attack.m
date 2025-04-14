clc;
close all;

% Read the original and watermarked images
rgb_image = imread('watermarked.jpg');   % Watermarked image
host_image = imread('host.jpg');        % Original host image

% Display original host and watermarked images
figure; imshow(host_image); title('Original Host Image');
figure; imshow(rgbimage); title('Watermarked Image');

% Attack: Add Gaussian Noise to the Watermarked Image
noisy_image = imnoise(rgbimage, 'gaussian', 0, 0.01);  % Gaussian noise attack
figure; imshow(noisy_image); title('Noisy Watermarked Image');

% Attack: Apply Gaussian Blur to the Watermarked Image
blurred_image = imgaussfilt(rgbimage, 2);  % Gaussian blur attack
figure; imshow(blurred_image); title('Blurred Watermarked Image');

% Attack: JPEG Compression on Watermarked Image
imwrite(rgbimage, 'compressed.jpg', 'Quality', 20);  % JPEG compression (quality 20%)
compressed_image = imread('compressed.jpg');
figure; imshow(compressed_image); title('Compressed Watermarked Image');

%% Calculate PSNR, SNR, and SSIM for each attacked image

% Function to calculate SNR
calculate_SNR = @(original, noisy) 20 * log10(norm(original(:)) / norm(original(:) - noisy(:)));

% PSNR, SNR, and SSIM for Watermarked Image
psnr_rgb = psnr(rgb_image, host_image);
snr_rgb = calculate_SNR(double(host_image), double(rgb_image));
ssim_rgb = ssim(rgb_image, host_image);
disp(['Watermarked Image - PSNR: ', num2str(psnr_rgb), ' dB']);
disp(['Watermarked - SNR: ', num2str(snr_rgb), ' dB']);
disp(['Watermarked - SSIM: ', num2str(ssim_rgb)]);


% PSNR, SNR, and SSIM for Noisy Image
psnr_noisy = psnr(noisy_image, host_image);
snr_noisy = calculate_SNR(double(host_image), double(noisy_image));
ssim_noisy = ssim(noisy_image, host_image);
disp(['Noisy Image - PSNR: ', num2str(psnr_noisy), ' dB']);
disp(['Noisy Image - SNR: ', num2str(snr_noisy), ' dB']);
disp(['Noisy Image - SSIM: ', num2str(ssim_noisy)]);

% PSNR, SNR, and SSIM for Blurred Image
psnr_blurred = psnr(blurred_image, host_image);
snr_blurred = calculate_SNR(double(host_image), double(blurred_image));
ssim_blurred = ssim(blurred_image, host_image);
disp(['Blurred Image - PSNR: ', num2str(psnr_blurred), ' dB']);
disp(['Blurred Image - SNR: ', num2str(snr_blurred), ' dB']);
disp(['Blurred Image - SSIM: ', num2str(ssim_blurred)]);

% PSNR, SNR, and SSIM for Compressed Image
psnr_compressed = psnr(compressed_image, host_image);
snr_compressed = calculate_SNR(double(host_image), double(compressed_image));
ssim_compressed = ssim(compressed_image, host_image);
disp(['Compressed Image - PSNR: ', num2str(psnr_compressed), ' dB']);
disp(['Compressed Image - SNR: ', num2str(snr_compressed), ' dB']);
disp(['Compressed Image - SSIM: ', num2str(ssim_compressed)]);

