% load data
% load the data
load('dataset2.mat');

% train and find hyperparameters
mdl = fitctree(Xtrain,Ytrain,'OptimizeHyperparameters','all');
predictions = mdl.predict(Xtest);

% calculate the error
% contains 0 for correct classifications, and 1/-1 for wrong
% classifications. 
error_vector = predictions-Ytest;

% makes 1's where there used to be 0's
idx = error_vector == 0;

% count number of 1's (which is the number of correct classifications)
error = 1-sum(idx)/length(Ytest);

% calculate sensitivities
correct_class_1 = predictions.*Ytest;
sensitivity_class_1 = sum(correct_class_1)/sum(Ytest);

correct_class_0 = (predictions-1).*(Ytest-1);
sensitivity_class_0 = sum(correct_class_0)/sum((Ytest-1).*(Ytest-1));


