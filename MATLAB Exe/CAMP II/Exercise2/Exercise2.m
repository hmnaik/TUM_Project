%% Computer Aided Medical Procedures II - Ss2010
%% Filtering
%% Exercise 2: Basic filtering in the frequency domain

clear all; 

%%-----------------------------------------------------------------------%%
%% A. Create the shape logan phantom 512x512 (function phantom)
%% And add some normal noise
sx = 512; sy = 512; % Size of the image
SL = phantom('Modified Shepp-Logan',sx);
SLn = imnoise(SL,'gaussian');

%%-----------------------------------------------------------------------%%
%% B. Fill the files imfft and imifft.m

%%-----------------------------------------------------------------------%%
%% C. Ideal Low Pass Filter (ILPF)
%% - Create the transfert function H_ilpf of the ILPF with D0=100
%% - Use imfft and imifft to filter the image in the frequency domain
%% - Repeat with D0 = [25 50 75]

H_ilpf = zeros(size(SLn));
for D0 = [100, 25, 50, 75]
    %% Create the transfert function H_ilpf(D0)
    for i = 1:size(SLn,1)
        for j = 1:size(SLn,2)
            fx = i-256;
            fy = j-256;
            H_ilpf(i,j) =  sqrt(fx^2 + fy^2) < D0;
        end
    end
    %% Filter SLn using H_ilpf
	SLn_ft = imfft(SLn);
	SLn_ftf = SLn_ft .* H_ilpf;
    SLn_f = imifft(SLn_ftf);
    %% Display the results
    figure(1);
    subplot(2,2,1);imagesc(SLn); axis image; colormap gray; axis off; ...
        title('Original Image')
    subplot(2,2,2);imagesc(H_ilpf); axis image; colormap gray; axis off; ...
        title('Transfert function')
    subplot(2,2,3);imagesc(SLn_f); axis image; colormap gray; axis off; ...
        title('Filtered Image')
    subplot(2,2,4);imagesc(SLn_f(1:200,201:400)); axis image; colormap gray;...
        axis off; title('Filtered Image')
    pause(0.5)
end
input('Continue?')

%% 2. Repeat C.1. with D0 = 25,50,75. Comment the result

%%-----------------------------------------------------------------------%%
%% D. Butterworth Low Pass Filter (BLPF)
%% - Create the transfert function H_blpf of the BLPF with D0=50 and n = 2
%% and apply it to the image by using the functions imfft and imifft.
%% - Repeat with D0 = 50 and n = [1 2 5 10 15 20 25]. 
%% - Comment the result.

H_blpf = zeros(size(SLn));
D0 =25; 

for n = [1 2 5 10 15 20 25]
    for i = 1:size(SLn,1)
        for j = 1:size(SLn,2)
            fx = i-256;
            fy = j-256;
			Df = sqrt(fx^2 + fy^2);
            H_blpf(i,j) = 1/((1+(Df/D0))^2*n);
        end
    end
    %% Filtered SLn using H_blpf
	SLn_ft = imfft(SLn);
	SLn_ftf = SLn_ft .* H_blpf;
    SLn_f = imifft(SLn_ftf);
    %% Display the results
    figure(1);
    subplot(2,2,1);imagesc(SLn); axis image; colormap gray; axis off; ...
        title('Original Image')
    subplot(2,2,2);imagesc(H_blpf); axis image; colormap gray; axis off; ...
        title('Transfert function')
    subplot(2,2,3);imagesc(SLn_f); axis image; colormap gray; axis off; ...
        title('Filtered Image')
    subplot(2,2,4);imagesc(SLn_f(1:200,201:400)); axis image; colormap gray;...
        axis off; title('Filtered Image')
    pause(0.5)
end
disp('End Exercise 2')
pause
close all;