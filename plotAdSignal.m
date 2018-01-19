close all; clear; clc;

%geting silgnals feom ADInstruments
fs=100;
[T, Resp, BPL, ECG] = get_AD_file;

figure; 
subplot(311);
plot(T, Resp);
grid on;
xlabel('Time[s]');
ylabel('Amplitude {\mu}V');
title('Respiration');

subplot(312);
plot(T, BPL);
grid on;
xlabel('Time[s]');
ylabel('Amplitude {\mu}V');
title('Blood Pulse');

subplot(313);
plot(T, ECG);
grid on;
xlabel('Time[s]');
ylabel('Amplitude {\mu}V');
title('Electrocardiogram');



