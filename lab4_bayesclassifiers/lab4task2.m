%lab4task2
%Magnus Knædal & Charlotte Heggem
% Naive Bayes Classifier

close all
load('data1.mat')

%{
Creates a naive Bayes classifier based on the training data, 
and find the classifications that that classifier gives to the test data.

The script should plot the classifications of the test data as a 
function of the test pattern index, and should print the percentage 
of errors that the classifier makes on the test data.
Give the listing of your script in a separate file.
%}

%% Seperate into class matrices
N = length(ytrain);

% Find length of each class matrix, needed to initialize class matrices
k1=0;
k2=0;
k3=0;
for i=1:N
    if(ytrain(i)==1)
        k1=k1+1;
    end
    if(ytrain(i)==2)
        k2=k2+1;
    end
    if(ytrain(i)==3)
        k3=k3+1;
    end
end

% Initialize class matrices, with lenght found in last step
class1 = zeros(2,k1);
class2 = zeros(2,k2);
class3 = zeros(2,k3);

% Set counters needed for iteration through data
c1=1;
c2=1;
c3=1;

% Add data instances to the correct class matrix
for i=1:N
    if(ytrain(i)==1)
        class1(:,c1) =  xtrain(:,i);
        c1=c1+1;
    end
    if(ytrain(i)==2)
        class2(:,c2) =  xtrain(:,i); 
        c2=c2+1;
    end
    if(ytrain(i)==3)
        class3(:,c3) =  xtrain(:,i); 
        c3=c3+1;
    end
    
end

%% Calculate class means and variances
% function mean(class_i,2) takes the mean along the dimension 2 of class_i
class1_mean = mean(class1,2);
class2_mean = mean(class2,2);
class3_mean = mean(class3,2);

% function Y = var(X) normalizes Y by N-1 if N>1, where N is the sample
% size ( N>1 in this case ) 
class1_var = [var(class1(1,:));var(class1(2,:))];
class2_var = [var(class1(1,:));var(class1(2,:))];
class3_var = [var(class1(1,:));var(class1(2,:))];

%% Classification

labels = zeros(1,N);

for i=1:N
    % Get x and y for the data instance
    x=xtest(1,i);
    y=xtest(2,i);
    
    
% The naive conditional independence assuption assume that each feature is
% conditionally independant of every other feature, given the category
% Class_i.
% This means that the joint model can be expressed as the pdfs multiplied
% together.

    % Calculate probability of the data from the pdfs of the classes by
    % function normdpdf(x,mu,sigma)
    % returns normal pdf of mu and sigmna, evaluated at the values in x
    pdf1x = normpdf(x,class1_mean(1),class1_var(1));
    pdf1y = normpdf(y,class1_mean(2),class1_var(2));
   	pdf1 = pdf1x*pdf1y;
   
    pdf2x = normpdf(x,class2_mean(1),class2_var(1));
    pdf2y = normpdf(y,class2_mean(2),class2_var(2));
    pdf2 = pdf2x*pdf2y;
    
    pdf3x = normpdf(x,class3_mean(1),class3_var(1));
    pdf3y = normpdf(y,class3_mean(2),class3_var(2));
    pdf3 = pdf3x*pdf3y;
    
    % Find class with highest probability for the data instance
    pdfs = [pdf1,pdf2, pdf3];
    maxclass = max(pdfs);
    
    % Assign label to the data instance
    if(maxclass==pdf1)
        label=1;
    elseif(maxclass==pdf2)
        label=2;
    else
        label=3;
    end
    
    % Make list with estimated classes
    labels(i)=label;
end

%% CALCULATE ACCURACY

count=0;
for i =1:N
    if(ytest(i) == labels(i))
        count = count+1;
    end
end
accuracy = count/N;

%% PLOT TEST DATA
figure 
hold on

% Plot the estimated classes
for i=1:length(labels)
    if(labels(i)==1)
        scatter(xtest(1,i),xtest(2,i),'r','o');
    end
    if(labels(i)==2)
        scatter(xtest(1,i),xtest(2,i),'b','o');
    end
    if(labels(i)==3)
        scatter(xtest(1,i),xtest(2,i),'g','o');
    end
end

% Plot the correct classes
for i=1:length(ytest)
    if(ytest(i)==1)
        scatter(xtest(1,i),xtest(2,i),'r','.');
    end
    if(ytest(i)==2)
        scatter(xtest(1,i),xtest(2,i),'b','.');
    end
    if(ytest(i)==3)
        scatter(xtest(1,i),xtest(2,i),'g','.');
    end
end

% Add text to plot
legend('Classifications')
text(-4.8,6.5, 'Circles with dot with same color inside, are correct.','FontSize',9);
text(-4.8,6.2, 'Dot with different color than circle indicates errors.','FontSize',9);
text(-4.8,5.8, "Accuracy = " + num2str(accuracy*100) + "%",'FontSize',12);

text(3,-0.5, 'Class 1', 'Color', 'r', 'FontSize',10)
text(3,-1, 'Class 2', 'Color', 'b', 'FontSize',10)
text(3,-1.5, 'Class 3', 'Color', 'g', 'FontSize',10)

hold off
