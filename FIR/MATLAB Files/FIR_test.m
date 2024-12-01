clc;
clear all;
close all;

% Generating random analog input signal with harmonics
Fs = 48000;                  
dt = 1/Fs;                   
StopTime = 25e-4;   % Overall 2.5ms input signal           
t = (0:dt:StopTime-dt)';       
L = length(t); 
   
Fc = Fs/2;                     
a = 0.6324;
x = 0.2*sin(2*pi*Fc*t*a)+0.4*sin(2*pi*2*Fc*t*a)+0.3*sin(2*pi*2*(Fc/4)*t*a);
x = abs(x);

% Plot the input signal versus time
figure;
plot(round(t*1e9),x);
xlabel('time (in nanoseconds)');
title('Signal versus Time');

% Plot frequency components of input signal
Y = fft(x);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
figure;
plot(f,P1); 
title('Single-Sided Amplitude Spectrum of X(t)');
xlabel('f (Hz)');
ylabel('|P1(f)|');

% Quantizing analog input in 8 bits to put as filter input
range=max(x)-min(x);
interval_size=range/256;
 
partition=[min(x)+interval_size:interval_size:max(x)];
codebook=[0:256];
quants = quantiz(x,partition,codebook);
t_ns = round(t*1e9);

% Plot filter hardware implementation output vs time
filename = 'fir_sim_data_out.txt';
delimiterIn = ' ';
headerlinesIn = 0;
A = importdata(filename,delimiterIn,headerlinesIn);
t_sim = A(:,1);
t_sim = t_sim(2:2:end,:);
% Dequantize the 18-bit output. But as the quantiztion was done using
% quantiz function, the number of fraction bits or quantization segments 
% are not known as it was set automatically inside the function. So, trial 
% and error was used to determine a value which can dequantize the 18-bit 
% output quite accurately.
fir_out = A(:,2)./1e5;
fir_out = fir_out(2:2:end,:); % Dequantization
figure;
plot(t_sim,fir_out);
xlabel('time (in nanoseconds)');
title('Signal versus Time');

% Plot frequency components of filter hardware implementation output
L_sim = length(t_sim);
Y_sim = fft(fir_out);
P2_sim = abs(Y_sim/L_sim);
P1_sim = P2_sim(1:L_sim/2+1);
P1_sim(2:end-1) = 2*P1_sim(2:end-1);
f_sim = (1/(20832e-9))*(0:(L_sim/2))/L_sim;
figure;
plot(f_sim,P1_sim); 
title('Single-Sided Amplitude Spectrum of X(t)');
xlabel('f (Hz)');
ylabel('|P1(f)|');

% Comparison of analog input and filter hardware implementation output
figure;
plot(t_ns,x);
hold on;
plot(t_sim,fir_out);
xlabel('time (in nanoseconds)');
title('Signal versus Time');
legend('Analog input','FIR Hardware Output')

figure;
plot(f,P1); 
hold on;
plot(f_sim,P1_sim); 
title('Single-Sided Amplitude Spectrum of X(t)');
xlabel('f (Hz)');
ylabel('|P1(f)|');
legend('Analog input','FIR Hardware Output')