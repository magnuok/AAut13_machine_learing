load('./mfiles5/chess33n.mat');

kernel_function = 'rbf';
rbf_sigma = 1;
method = 'QP';
boxconstraint = 0.00000001;
showplot = false;

support_vectors = [];
error = [];

row_names= {};
row_name = 'box_constraint = ';

j = 1;

for i = 1:1:20
    boxconstraint = boxconstraint*10;
    row_names{j, 1} = strcat(row_name,num2str(boxconstraint));
    j = j+1;
    if(showplot)
        figure(j);
    end
    svmstruct = svmtrain(X, Y, 'kernel_function', kernel_function, 'rbf_sigma', rbf_sigma, 'method', method, 'boxconstraint', boxconstraint,'showplot', showplot);
    support_vectors = [support_vectors; size(svmstruct.SupportVectors, 1)];
    group = svmclassify(svmstruct, X, 'showplot', showplot);
    error = [error; 1-(45+sum(group.*Y)/2)/90];
end;

disp(' ');
disp(' ');
disp(table(support_vectors, error, 'RowNames', row_names));
