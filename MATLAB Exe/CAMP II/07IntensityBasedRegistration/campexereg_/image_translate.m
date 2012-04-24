%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% B = image_translate(A, t)
%   A image, t translation vector
%   uses best-neighbor

function B = image_translate(A,t)

    B = A*0;
    
    d1 = size(B,1);
    d2 = size(B,2);
    % backward warping
    for x=1:d1
        for y=1:d2

		%%% TODO
		% calculate the correct indices for accessing matrix A
            
        origin_x=round(x-t(1));
        origin_y=round(y-t(2));
        
            if ( origin_x>0 && origin_y>0 && origin_x<=d1 && origin_y<=d2 )
                
                B(x,y) = A( origin_x , origin_y );      
            end
            
        end
    end
