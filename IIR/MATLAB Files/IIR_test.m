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
q = 52;
quants_iir = round(x*2^q);
xhat = dec2bin(quants_iir,64) %64-bit Q11.52 for filter input 
t_ns = round(t*1e9);

% Plot filter hardware implementation output vs time
filename_ = 'iir_sim_data_out_46.txt';
delimiterIn_ = ' ';
headerlinesIn_ = 0;
A_ = importdata(filename_,delimiterIn_,headerlinesIn_);
t_sim_ = A_(:,1);
t_sim_ = t_sim_(2:2:end,:);
iir_out = A_(:,2);
% Dequantize the output where the output 64-bit has 38 fraction bits as
% 130-bit Data_out had Q11.52*Q11.52 with (52+52)=104 fraction bits. Now, 
% 64-bit Data_out_r = Data_out[129:66]. So Data_out_r has [104-66]=38 
% fraction bits
iir_out = iir_out(2:2:end,:)./2^38; % Dequantization
figure;
plot(t_sim_,iir_out);
xlabel('time (in nanoseconds)');
title('Signal versus Time');

% Plot frequency components of filter hardware implementation output
L_sim_ = length(t_sim_);
Y_sim_ = fft(iir_out);
P2_sim_ = abs(Y_sim_/L_sim_);
P1_sim_ = P2_sim_(1:L_sim_/2+1);
P1_sim_(2:end-1) = 2*P1_sim_(2:end-1);
f_sim_ = (1/(20832e-9))*(0:(L_sim_/2))/L_sim_;
figure;
plot(f_sim_,(P1_sim_)); 
title('Single-Sided Amplitude Spectrum of X(t)');
xlabel('f (Hz)');
ylabel('|P1(f)|');

% Comparison of analog input and filter hardware implementation output
figure;
plot(t_ns,x);
hold on;
plot(t_sim_,iir_out);
xlabel('time (in nanoseconds)');
title('Signal versus Time');
legend('Analog input','IIR Hardware Output')

figure;
plot(f,P1); 
hold on;
plot(f_sim_,P1_sim_); 
title('Single-Sided Amplitude Spectrum of X(t)');
xlabel('f (Hz)');
ylabel('|P1(f)|');
legend('Analog input','IIR Hardware Output')