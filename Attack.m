function evaluate_attacks(hostPath, watermarkedPath)

    rgb_image = imread(watermarkedPath);
    host_image = imread(hostPath);

    figure; imshow(host_image); title('Original Host Image');
    figure; imshow(rgb_image); title('Watermarked Image');

    noisy_image = imnoise(rgb_image, 'gaussian', 0, 0.01);
    figure; imshow(noisy_image); title('Noisy Watermarked Image');

    blurred_image = imgaussfilt(rgb_image, 2);
    figure; imshow(blurred_image); title('Blurred Watermarked Image');

    imwrite(rgb_image, 'compressed.jpg', 'Quality', 20);
    compressed_image = imread('compressed.jpg');
    figure; imshow(compressed_image); title('Compressed Watermarked Image');

    calculate_SNR = @(original, noisy) 20 * log10(norm(original(:)) / norm(original(:) - noisy(:)));

    psnr_rgb = psnr(rgb_image, host_image);
    snr_rgb = calculate_SNR(double(host_image), double(rgb_image));
    ssim_rgb = ssim(rgb_image, host_image);
    disp(['Watermarked Image - PSNR: ', num2str(psnr_rgb), ' dB']);
    disp(['Watermarked - SNR: ', num2str(snr_rgb), ' dB']);
    disp(['Watermarked - SSIM: ', num2str(ssim_rgb)]);

    psnr_noisy = psnr(noisy_image, host_image);
    snr_noisy = calculate_SNR(double(host_image), double(noisy_image));
    ssim_noisy = ssim(noisy_image, host_image);
    disp(['Noisy Image - PSNR: ', num2str(psnr_noisy), ' dB']);
    disp(['Noisy Image - SNR: ', num2str(snr_noisy), ' dB']);
    disp(['Noisy Image - SSIM: ', num2str(ssim_noisy)]);

    psnr_blurred = psnr(blurred_image, host_image);
    snr_blurred = calculate_SNR(double(host_image), double(blurred_image));
    ssim_blurred = ssim(blurred_image, host_image);
    disp(['Blurred Image - PSNR: ', num2str(psnr_blurred), ' dB']);
    disp(['Blurred Image - SNR: ', num2str(snr_blurred), ' dB']);
    disp(['Blurred Image - SSIM: ', num2str(ssim_blurred)]);

    psnr_compressed = psnr(compressed_image, host_image);
    snr_compressed = calculate_SNR(double(host_image), double(compressed_image));
    ssim_compressed = ssim(compressed_image, host_image);
    disp(['Compressed Image - PSNR: ', num2str(psnr_compressed), ' dB']);
    disp(['Compressed Image - SNR: ', num2str(snr_compressed), ' dB']);
    disp(['Compressed Image - SSIM: ', num2str(ssim_compressed)]);
end

evaluate_attacks('host.jpg', 'watermarked1.jpg');
evaluate_attacks('host.jpg', 'watermarked2.jpg');
evaluate_attacks('host.jpg', 'watermarked3.jpg');

