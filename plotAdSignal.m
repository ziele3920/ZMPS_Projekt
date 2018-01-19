function plotAdSignal(signalStruct)

figure; 
subplot(311);
plot(signalStruct.time, signalStruct.resp);
grid on;
xlabel('Time[s]');
ylabel('Amplitude {\mu}V');
title(['Respiration' signalStruct.fileName]);

subplot(312);
plot(signalStruct.time, signalStruct.BP);
grid on;
xlabel('Time[s]');
ylabel('Amplitude {\mu}V');
title(['Blood Pulse' signalStruct.fileName]);

subplot(313);
plot(signalStruct.time, signalStruct.ECG);
grid on;
xlabel('Time[s]');
ylabel('Amplitude {\mu}V');
title(['Electrocardiogram' signalStruct.fileName]);

end



