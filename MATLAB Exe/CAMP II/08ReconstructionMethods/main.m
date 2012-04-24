%% Preparing the data

dim = 256;
image = phantom(dim);

projections = 0:179;
sinogram = radon(image, projections);

% optional: add 5% normally distributed noise
% sinogram = sinogram + 0.05 * mean(sinogram(:)) * randn(size(sinogram));

figure(1), subplot(2, 2, 1); imagesc(image); axis square; colorbar; title(['Phantom, size = ', num2str(dim)]);
figure(1), subplot(2, 2, 2); imagesc(sinogram); axis square; colorbar; title('Sinogram');


%% Direct Fourier Reconstruction

interpolation = 'cubic';
reconFourier = fourier(sinogram, interpolation);

figure(1), subplot(2, 2, 3); imagesc(reconFourier); axis square; colorbar; title(['Fourier, interp ' interpolation]);


%% Filtered Backprojection

filter = 'Ram-Lak';
%filter = 'None';
reconFBP = fbp(sinogram, projections, filter);

figure(1), subplot(2, 2, 4); imagesc(reconFBP); axis square; colorbar; title(['FBP, filter ' filter]);

