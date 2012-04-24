%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function cost_function
% implement intensity based registration

function [similarity_value] = cost_function(transform_params, img_fixed, img_moving, similarity_measure)

global img_registertest

% construct current transformation
angle = transform_params(1);
dx    = transform_params(2);
dy    = transform_params(3);

%%% TODO:
% apply current transformation to img_moving
%   store result in "img_registertest"

img_registertest = image_rotate( img_moving, angle , [0 0]);

img_registertest = image_translate(img_registertest,[dx dy]);



% calculate similarity measure
%                                                  
switch upper(similarity_measure)
    case 'SSD'
        %%% TODO:
        % calculate SSD
                
        SSD = sum(sum((img_fixed - img_registertest).^2));
           
        similarity_value = ( SSD / (size(img_moving,1)*size(img_moving,2)) );
        
        
    case 'SAD'
        %%% TODO:
        % calculate SAD
        SAD = sum(sum(abs(img_fixed - img_registertest)));
              
        similarity_value = ( SAD / (size(img_moving,1)*size(img_moving,2)) );
        
        
    case 'NCC'
        %%% TODO:
%         Xmean = mean2(img_registertest);
%         Ymean = mean2(img_fixed);
%         similarity_value = -sum(sum((img_registertest-Xmean).*(img_fixed-Ymean)))/(size(img_fixed(:),1)*std(double(img_registertest(:)))*std(double(img_fixed(:))));
%         

        meanx = mean2(img_fixed);
        meany = mean2(img_registertest);
        numerator = sum(sum ( ((img_fixed)-meanx).*((img_registertest)-meany) ) );
        
        NCC = -numerator / std(double(img_fixed(:)))*std(double(img_registertest(:)));
        
        similarity_value = NCC / (size(img_moving,1)*size(img_moving,2)) ;
        
       
        
        
    case 'MI'
        %%% TODO:
        % calculate MI, use the function joint_histogram           
        joint = joint_histogram(img_registertest,img_fixed) ;
        joint = joint / sum(joint(:)) ;

        % calculate produce of marginals distribution
        m1 = sum(joint,1) ;
        m2 = sum(joint,2) ;
        prod = m2 * m1 ;

        % calculate mi
        mi = joint .* log((eps+joint)./(eps+prod)) ;
        similarity_value = -sum(mi(:)) ;
        
end