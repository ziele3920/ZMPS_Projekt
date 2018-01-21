function [pOpt, Yhat, MSE, AKAIKE] = estimateFourierSeriesModel(signalStruct)
Pmax=20;
Y=signalStruct.peaksVal';
X = ones(length(signalStruct.peaksVal), 1);
xmin = min(signalStruct.peaksTime);
xmax = max(signalStruct.peaksTime);
x = 2*pi*(signalStruct.peaksTime-xmin)/(xmax-xmin);

    for p = 1:Pmax
       X = [0.5*X sin(p*x') cos(p*x')];
       Phat = X\Y;
       Yhat = X*Phat;
       MSE(p) = mean((Y-Yhat).^2);
       Fk(p) = 2*(p+1)/length(signalStruct.peaksVal);
    end;
    
AKAIKE = log(MSE) + Fk;
[~, pOpt] = min(AKAIKE);
X = [0.5*X sin(pOpt*x') cos(pOpt*x')];
Phat = X\Y;
Yhat = X*Phat; 

if true
    figure;  
    subplot(411); plot(signalStruct.filteredTime, signalStruct.filteredBP); hold on;
    subplot(411); plot(signalStruct.peaksTime, signalStruct.peaksVal, 'rx'); hold on;
    subplot(411); plot(signalStruct.peaksTime, Yhat, 'r'); hold off;
    subplot(412); plot(1:Pmax, MSE); title('MSE');
    subplot(413); plot(1:Pmax, Fk); title('penatly function');
    subplot(414); plot(1:Pmax, AKAIKE); title('Akaike Information Criterion');
end

end

