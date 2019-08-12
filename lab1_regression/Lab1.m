function Lab1()
load('data2.mat');
%Lab 1 task 2
%IST 2018
%Magnus Knædal & Charlotte Heggem

%Set a degree of polynomial = P
P = 1;
n = length(x);

X=zeros(n,P+1);

for i=2:P+1
    X(:,1) = 1;
    X(:,i)= transpose(x);
end

%Make the matrix
for i=1:n 
    for j=2:P+1
        X(i,j)= X(i,j)^(j-1);
        
    end
end

B = ((transpose(X)*X)^-1)*transpose(X)*y;

%Plot predictions as a straight line together with the training set
pred = X*B;
plot(x,y,'o',X,pred,'x');

%Calculate SSE
SSE = 0;
for n=1:length(pred)
    
   SSE = SSE+ (y(n)-pred(n))^2;
end


%Calculate coefficients
lc= polyfit(x, pred,P);

func = @(k) 0;

for i = 1:P+1
    
    g =@(k) lc(P+2-i)*k^(i-1);
    
    func = @(k) func(k) + g(k);
end 

hold on;

fplot(func,[-1,1])

hold on;

disp(lc)
disp(SSE)
