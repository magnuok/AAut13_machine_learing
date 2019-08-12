clear all;
% Using matlab version 2016b

% Use all data for training
load('mfiles5/chess33n.mat');

num_suport_vector = [];
error = [];
rbf_sigma0= [];

%% Parameteres
method = 'QP';
poly_kernel = 'polynomial';
gaussian_kernel = 'rbf';
box_constraint0 = [];
box_constraint = 0.00001;

%% Trains model6

for rbf_sigma = 1:1:12
   
    rbf_sigma0 =[rbf_sigma0; rbf_sigma];
    box_constraint = box_constraint*10;
    box_constraint0 = [box_constraint0; box_constraint];


svmstruct = svmtrain(X, Y, 'kernel_function', gaussian_kernel, 'rbf_sigma', 0.7, 'method', method, 'boxconstraint', box_constraint, 'showplot', true);

num_suport_vector = [num_suport_vector; size(svmstruct.SupportVectors,1)];

group = svmclassify(svmstruct, X, 'showplot', true);

error= [error; 1-(45+sum(group.*Y)/2)/90];

end

rbf_sigma0
error;

%group = svmclassify(model, X, 'SHOWPLOT', true );