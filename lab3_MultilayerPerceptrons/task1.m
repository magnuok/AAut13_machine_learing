clear all;
load digits;
%% 1.2 Neural Network
net = patternnet([15]);
net.performFcn='mse';

net.layers{1}.transferFcn='tansig';
net.layers{2}.transferFcn='tansig';

net.divideFcn='divideind';
net.divideParam.trainInd=1:400;
net.divideParam.testInd=401:560;
%% 1.3 Gradient method with fixed step size parameter and momentum 
net.trainFcn = 'traingdx'
net.trainParam.lr=0.7; % learning rate
net.trainParam.mc=0.9;% Momentum constant
net.trainParam.show=10000; % # of epochs in display
net.trainParam.epochs=1000;% max epochs
net.trainParam.goal=0.05; % training goal
[net,tr] = train(net,X,T);


epochs = [204 262 227 208 195 221];
epochs_median = median(epochs); % Calculate median
fprintf('Epochs median 1.3: %f\n', epochs_median);

%% 1.4. Gradient method with adaptive step sizes and momentum 
epochs = [112 74 66 66 122 67 116];
epochs_median = median(epochs); % Calculate median
fprintf('Epochs median 1.4: %f\n', epochs_median);

x_test=X(:,tr.testInd);
t_test=T(:,tr.testInd);
y_test = net(x_test);
plotconfusion(t_test,y_test); 


