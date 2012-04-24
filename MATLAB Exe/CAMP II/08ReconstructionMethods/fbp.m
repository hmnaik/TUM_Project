% filtered backprojection
function recon = fbp(sinogram, projections, filter)

tic;


if strcmp(filter, 'Ram-Lak') % implement Ram-Lak filter on our own
    
    % apply Ram-Lak filter to sinogram
     filtr = linspace(0,1,floor(size(sinogram,1)/2)+1);
     
     filtr = [filtr filtr(end-1:-1:1)];
     
     recon = zeros(size(sinogram,1));
     
    for i=1:length(projections)
        
    
    line = sinogram(:,i);
    %filteredSino = imfilter(sinogram,filter,'replicate');
    %filteredSino = ifft(imfilter(fft(sinogram),filter));
    line = real(ifft(fft(line).*filtr'));
    
    temp_image = repmat(line,[1 size(sinogram,1)]);
    
    recon = recon + imrotate(temp_image,i,'bilinear','crop');
    
    
    
    end
    
    recon = imrotate ( recon, 90,'bilinear','crop');
    xmin = (size(recon,1)/2) - 128;
    ymin = (size(recon,2)/2) - 128;
    recon = imcrop(recon, [xmin ymin 255 255]);
    size(recon);
     
    % ...
    
    % apply backprojection via iradon (filtering disabled)
  %  recon = iradon(sinogram, projections, 'linear', 'none');
    
else % cheap way out - use filter provided by iradon
    
    recon = iradon(sinogram, projections, 'linear', filter);
    
end;

elapsed = toc;
disp(['FBP done in ' num2str(elapsed) ' seconds.']);
