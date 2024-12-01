clc;
clear all;
close all;

format long 

fs=48000; % Sampling Frequency

% Getting numerator and denominator coefficients 
% from designed filter object
[b,a] = tf(FIR_Hamming_Lowpass_8)

% N.B.: For FIR filter, denominator coefficient a = 1

% Plotting frequency response of filter
figure;
freqz(b,a,200,fs);  

% Quantizing numerator coefficients in 7 bits as 1 bit is kept for sign bit
% in 8 bit
range=max(b)-min(b);
interval_size=range/128;
 
partition=[min(b)+interval_size:interval_size:max(b)];
codebook=[0:128];
quants = quantiz(b,partition,codebook)