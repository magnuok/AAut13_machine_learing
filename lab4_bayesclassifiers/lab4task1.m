%lab4task1
% Magnus Knædal & Charlotte Heggem
close all
load('data1.mat')

figure 
hold on
for i=1:length(ytrain)
    if(ytrain(i)==1)
        scatter(xtrain(1,i),xtrain(2,i),'r','*');
       
    end
    if(ytest(i)==1)
        scatter(xtest(1,i),xtest(2,i),'r','d');
    end
    if(ytrain(i)==2)
        scatter(xtrain(1,i),xtrain(2,i),'b','*');
        legend('Class 2')
    end
    if(ytest(i)==2)
        scatter(xtest(1,i),xtest(2,i),'b','d');
    end
    if(ytrain(i)==3)
        scatter(xtrain(1,i),xtrain(2,i),'g','*');
        legend('Class 3')

    end
    if(ytest(i)==3)
        scatter(xtest(1,i),xtest(2,i),'g','d');
    end
end


legend('Training data','Test data')

text(3,-1, 'Class 1', 'Color', 'r', 'FontSize',10)
text(3,-1.5, 'Class 2', 'Color', 'b', 'FontSize',10)
text(3,-2, 'Class 3', 'Color', 'g', 'FontSize',10)

hold off