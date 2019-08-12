%Lab1 task 3
%IST 2018 AAut13
%Magnus Knædal and Charlotte Heggem
function l1t2
load('data3.mat');

% Lasso algorithm
[B,FitInfo] = lasso(X,Y); 
lassoPlot(B,FitInfo,'PlotType','Lambda','XScale','log');
hold on

% Get coefficients for LS by Lasso method
[BLS,FitInfo2] = lasso(X,Y,'Lambda',0);
disp(BLS);

first= repmat(BLS(1),size(FitInfo.Lambda));
second=repmat(BLS(2),size(FitInfo.Lambda));
third=repmat(BLS(3),size(FitInfo.Lambda));
fourth=repmat(FitInfo.Intercept(1),size(FitInfo.Lambda));

plot(FitInfo.Lambda,first);
hold on
plot(FitInfo.Lambda,second);
hold on
plot(FitInfo.Lambda,third);
hold on
plot(FitInfo.Lambda,fourth);
hold off

%Calculate SSE for Lasso
pred = X*BLS;
Lam = 10^-1;
SSE = 0;
for n=1:length(pred)
   SSE = SSE+ (Y(n)-pred(n))^2;
end
%SSE without lambda
disp(SSE);

for i = 1:length(BLS)   
SSE= SSE + Lam*abs(BLS(i));
end

disp(SSE);
