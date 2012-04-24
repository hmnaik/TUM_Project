clear %all
close all
clc

%define parameters for gradient descent
steps = 10000;
tau = 1;
nu = 0.5;

%load image
load I.mat

%initialize embedding function
LF = LFunction(I);

%gradient descent
for i = 1:steps
    
    %compute gradient
    %convex formulation by chan and nikolova 
    
    
    [mu_i mu_o] = LF.CompMeanValues(I);
    grad_E = 0*((I-mu_i).^2 - (I-mu_o).^2) - nu*LF.kappa;
    
    %evolve embedding function
    LF.u = LF.u - tau*grad_E;
    
    %reinitialize embedding function
    LF = LF.ReProject;
    
    %visualize
    if mod(i,100) == 0
        imagesc(I)
        colormap gray
        axis equal tight off
        hold on
        LF.PlotContour
        hold off
        title(['iteration step ' num2str(i)])
        drawnow
    end
    
end
