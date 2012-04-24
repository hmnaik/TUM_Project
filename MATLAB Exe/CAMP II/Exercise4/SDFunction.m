classdef SDFunction
    
    %%%%%%%% PROPERTIES %%%%%%%%
    
    %%%% constant properties %%%%
    properties (Constant)
        epsilon = 1.5; %"radius" of smeared out heaviside function
    end
    
    %%%% dependent properties %%%%
    properties (Dependent)
        H       %heaviside function
        delta   %dirac function
    end
    
    %%%% public properties %%%%
    properties
        phi     %embedding function
        NB      %narrow band
        kappa   %curvature
    end
    
    %%%%%%%% METHODS %%%%%%%%
    methods
        
        %%%% constructor %%%%
        function obj = SDFunction(Init)
        %this function initializes a signed distance function
        
            %generate initial embedding function
            obj.phi = bwdist(Init) - bwdist(1-Init);
        
            %generate initial narrow band
            obj.NB = find(abs(obj.phi)<obj.epsilon);
        
            %refine embedding function and narrow band
            ReInitialize(obj);
            
        end %constructor
     
        %%%% get methods %%%%
        function val = get.H(obj)
        %call this function to compute H(phi)
            val = zeros(size(obj.phi));
            val(abs(obj.phi)<=obj.epsilon) = 0.5*(1 + obj.phi(abs(obj.phi)<=obj.epsilon)/obj.epsilon +...
                                             sin(pi*obj.phi(abs(obj.phi)<=obj.epsilon)/obj.epsilon)/pi);
            val(obj.phi>obj.epsilon) = 1;
        end %get_H
        
        function val = get.delta(obj)
        %call this cuntion to compute delta(phi)
            val = zeros(size(obj.phi));
            val(abs(obj.phi)<=obj.epsilon) = 1/(2*obj.epsilon)+cos(pi*obj.phi(abs(obj.phi)<=obj.epsilon)/obj.epsilon)./(2*obj.epsilon);
        end %get_delta
        
        function val = get.kappa(obj)
        %call this function to compute the curvature
            
            %pad embedding function
            phi_p = padarray(obj.phi,[1 1],'symmetric','both');
            
            %convert narrow band values
            [m n] = size(obj.phi);
            [i j] = ind2sub([m n],obj.NB);
            NB_p = sub2ind([m+2 n+2], i+1, j+1);
                     
            %compute gradient with forward differences
            dx = phi_p(NB_p+m+2) - phi_p(NB_p);
            dy = phi_p(NB_p+1) - phi_p(NB_p);
            
            %compute norm
            N = sqrt(dx.^2+dy.^2) + 10*eps;
            
            %fill in normalized gradient
            dx_full = zeros(m+2,n+2);
            dy_full = zeros(m+2,n+2);
            dx_full(NB_p) = dx./N;
            dy_full(NB_p) = dy./N;
            
            %compute kappa with Neumann boundary conditions
            val = (dx_full(NB_p) - dx_full(NB_p-m-2)).*(dx_full(NB_p-m-2) ~= 0) +...
                  (dy_full(NB_p) - dy_full(NB_p-1)).*(dy_full(NB_p-1) ~= 0);
            
        end %get_kappa
        
        %%%% utility methods %%%%
        function PlotCurve(obj)
        %call this function to plot the contour
            contour(obj.phi,[0 0],'y','LineWidth',2);
        end %PlotCurve
        
        function obj = ReInitialize(obj)
        %call this function to reinitialize the embedding function
            
            steps = 20;
            tau = 0.05;
            m = size(obj.phi,1);
            
            %generate extended narrow band
            N = unique([obj.NB; obj.NB-m; obj.NB-1; obj.NB+1; obj.NB+m]);
            
            D = obj.phi(N);

            for i = 1:steps
    
                a = obj.phi(N) - obj.phi(N-m); 
                b = obj.phi(N+m) - obj.phi(N); 
                c = obj.phi(N) - obj.phi(N-1); 
                d = obj.phi(N+1) - obj.phi(N);
    
                s = D./sqrt(D.^2+1);
    
                D = D - tau*max(s,0).*(sqrt(max(a,0).^2 + min(b,0).^2 + max(c,0).^2 + min(d,0).^2) - 1) - ...
                        tau*min(s,0).*(sqrt(min(a,0).^2 + max(b,0).^2 + min(c,0).^2 + max(d,0).^2) - 1);
        
                obj.phi(N) = D;

            end

            obj.NB = find(abs(obj.phi) < obj.epsilon);
            obj.phi(obj.phi < -obj.epsilon) = -obj.epsilon;
            obj.phi(obj.phi > obj.epsilon) =  obj.epsilon;
            
        end %ReInitialize
          
    end %methods
    
end %classdef