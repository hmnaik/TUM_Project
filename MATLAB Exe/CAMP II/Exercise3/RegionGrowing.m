function Region = RegionGrowing(I,T)

Visited = zeros(size(I));
Region = zeros(size(I));

% Location of the 8 neighbors
neigb=[-1 0; 1 0; 0 -1;0 1; 1 1; -1 -1; -1 1; 1 -1];
[s1, s2] = size(I);
tic();

% Select and add the seed point to tho the queue of pixel to visit "list"
figure; imagesc(I);axis image; axis xy; title('Select the seed point');...
    colormap gray;axis off

[y x] = ginput(1);
x = round(x); 
y = round(y);
Im = I(x,y);
list = [x, y];

% Grow until no more pixel can be added to the FIFO list
Im = I(x,y); % Initialize the mean Intensity inside the region
list = [x, y];
while(size(list,1)~=0)
    % Pick up and remove the first pixel from the list
    mypix = list(1,:);
    list(1,:) = [];
    
    % Check if pixel is homogeneous
    % By comparing it to the mean Intensity inside the region
    if ( (I(mypix(1),mypix(2)) - Im) < T) 
        Region(mypix(1),mypix(2)) = 1;
        Visited(mypix(1),mypix(2)) = 1;
        for k = 1:8
            myneighpix = mypix + neigb(k,:);
            if (Visited(myneighpix(1),myneighpix(2)) == 0)
            	list(end+1,:) = myneighpix;
            	Visited(myneighpix(1),myneighpix(2)) =1;
            end
        end
    else
       Visited(mypix(1),mypix(2)) = 1;
       %????
    end
    Im = sum(sum(I(Region==1)))/sum(sum(Region));
    
    if toc()>1/2
        imagesc(I+Region,[0 1]); axis image; colormap gray; axis off; axis xy;
        drawnow;
       tic();
    end
    
end

%% Display
imagesc(I+Region,[0 1]); axis image; colormap gray; axis off; axis xy;
drawnow;

