clear all;
% Using matlab version 2016b

% Use all data for training
load('mfiles5/spiral.mat');

num_suport_vector = [];
error = [];
rbf_sigma0= [];

%% Parameteres
method = 'QP';
poly_kernel = 'polynomial';
gaussian_kernel = 'rbf';
box_constraint = 10^10;


%% Trains model6
for rbf_sigma = 0.1:0.2:2.5
    rbf_sigma0 =[rbf_sigma0; rbf_sigma];

svmstruct = svmtrain(X, Y, 'kernel_function', gaussian_kernel, 'rbf_sigma', rbf_sigma, 'method', method, 'boxconstraint', box_constraint, 'showplot', true);

num_suport_vector = [num_suport_vector; size(svmstruct.SupportVectors,1)];

group = svmclassify(svmstruct, X, 'showplot', true);

error= [error; 1-(50+sum(group.*Y)/2)/100];

end

rbf_sigma0
error;

%group = svmclassify(model, X, 'SHOWPLOT', true );