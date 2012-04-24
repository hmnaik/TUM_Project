clear %all
close all
clc


%define parameters for gradient descent
steps = 1000;
tau = 0.5;
nu = 0.05;

%load image
load I.mat

%initialize embedding function
imagesc(I)
colormap gray
axis equal tight off
title('define initial contour!')
R = roipoly;
SDF = SDFunction(double(R));

%gradient descent
for i = 1:steps
    
    %compute gradient
    %%%% TO BE IMPLEMENTED %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Consider that
    % * the signed distance function can be obtained by SDF.phi
    % * H(phi), delta(phi),... can be obtained by SDF.get_H,
    %   SDF.get_delta,...
    % * grad_E should have the same size as the narrow band SDF.NB
    %
    %mu_i = 
    %mu_o = 
    %delta = 
    %grad_E = 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    mu_o = sum(sum(SDF.H.*I))/sum(sum(SDF.H));
    
    myphi = SDF.phi;
    SDF.phi = -myphi;
    mu_i = sum(sum(SDF.H.*I))/sum(sum(SDF.H));
    SDF.phi = myphi;
    
    delta = SDF.delta;
    
    % Chan and vese algorithm 
    % Energy for embedding function is defined and not for curve , derive 
    % evolution equation    directly for embedding function. 
    
    % Gradient is calculated 
    grad_E =  delta(SDF.NB).*( (mu_o - I(SDF.NB)).^2 - (mu_i - I(SDF.NB)).^2 - nu .* SDF.kappa);
    
    %evolve embedding function (gradient descent step)
    %%%% TO BE IMPLEMENTED %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Consider that the signed distance function needs only to be
    % updated on the narrow band!
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % step of evolving function 
    SDF.phi(SDF.NB) = SDF.phi(SDF.NB) - tau .* grad_E;
    
    %reinitialize embedding function -> to generate new narrow band 
    SDF = SDF.ReInitialize;
    
    % For this results always depend on the initialisation 
    
    %visualize
    if mod(i,10) == 0
        subplot(1,2,1)
        imagesc(I)
        colormap gray
        axis equal tight off
        hold on
        SDF.PlotCurve
        hold off
        title(['iteration step ' num2str(i)])
        subplot(1,2,2)
        surf(double(SDF.phi))
        axis equal tight 
        shading flat
        hold on
        SDF.PlotCurve
        hold off
        title(['evolving signed distance function'])
        drawnow
    end
    
end
