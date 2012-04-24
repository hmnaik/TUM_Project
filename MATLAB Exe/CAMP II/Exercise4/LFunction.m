classdef LFunction
    
    %%%%%%%% PROPERTIES %%%%%%%%
    
    %%%% public properties %%%%
    properties
        u     %embedding function
    end
    
    %%%%% dependent properties %%%%
    properties
        kappa %curvature
    end
    
    %%%%%%%% METHODS %%%%%%%%
    methods
        
        %%%% constructor %%%%
        function obj = LFunction(Init)
        %this function initializes a signed distance function
        
            %generate initial embedding function
            %%%% TO BE IMPLEMENTED %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % Consider that
            % * Init has the same size as the image to be segmented
            % * the embedding function should have values between 0 and 1
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            obj.u = Init;
            % Initialisation can be any funtion - a natural choice is image
            % itself 
            
        end %constructor
     
        %%%% get methods %%%%
        function val = get.kappa(obj)
        %call this function to compute the curvature
            
            %get size of embedding function
            [m n] = size(obj.u);
            
            %initialize gradient
            dx = zeros(m,n);
            dy = zeros(m,n);

            %approximate the derivative of u in x-direction with forward differences
            dx(:,1:(n-1)) =  obj.u(:,2:n) - obj.u(:,1:(n-1));

            %approximate the derivative of u in y-direction with forward differences
            dy(1:(m-1),:) =  obj.u(2:m,:) - obj.u(1:(m-1),:);
            
            %compute norm of gradient
            N = sqrt(dx.^2+dy.^2)+10*eps;
            
            %normalize gradient
            dx = dx./N;
            dy = dy./N;
            
            %initialize second order derivatives
            dxx = zeros(m,n);
            dyy = zeros(m,n);

            %approximate the derivative of dx in x-direction with backward differences
            dxx(:,2:n) = dx(:,2:n) - dx(:,1:(n-1));

            %approximate the derivative of dy in y-direction with backward differences
            dyy(2:m,:) = dy(2:m,:) - dy(1:(m-1),:);

            %correct boundary treatment
            %otherwise we assume that also the "second derivative" is 0
            dxx(:,1) = dx(:,1);% - 0
            dyy(1,:) = dy(1,:);% - 0

            %compute the divergence
            val = dxx + dyy;
            
        end %get_kappa
        
        %%%% utility methods %%%%
        function PlotContour(obj)
        %call this function to plot the contour
            contour(obj.u,[0.5 0.5],'y','LineWidth',2);
        end %PlotCurve
        
        function [mu_i mu_o] = CompMeanValues(obj,I)
        %call this function to compute the mean values
            
            %%%% TO BE IMPLEMENTED %%%%%%%%%%%%%%%%%%%%
            % Use the formulas from the lecture slides!
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            mu_i = sum(sum(obj.u.*I))/sum(sum(obj.u));
            mu_o = sum(sum((1-(obj.u)).*I))/sum(sum(obj.u));
                       
        end %CompMeanValues
        
        function obj = ReProject(obj)
        %call this function to enforce that u is between 0 and 1
            obj.u = max(min(obj.u,1),0); % From slides 
        end %ReProject
        
    end %methods
    
end %classdef