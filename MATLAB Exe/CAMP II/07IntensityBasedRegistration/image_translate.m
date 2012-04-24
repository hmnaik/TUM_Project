%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% B = image_translate(A, t)
%   A image, t translation vector
%   uses best-neighbor

function B = image_translate(A,t)

    B = A*0;
    
    d1 = size(B,1);
    d2 = size(B,2);
    
    %t = [1 0 t(1); 0 1 t(2); 0 0 1];
    % backward warping
    for x=1:d1
        for y=1:d2

		%%% TODO
         origin_x = round(x-t(1));     
         origin_y = round(y-t(2));
        
        % origin_x = round(x+t(1));     
        % origin_y = round(y+t(2));
        
         
%         % calculate the correct indices for accessing matrix A
%             
%               
            if ( origin_x>0 && origin_y>0 && origin_x<=d1 && origin_y<=d2 )
                
                B(x,y) = A( ceil( origin_x) , ceil(origin_y) );      
            end
            
        end
    end
