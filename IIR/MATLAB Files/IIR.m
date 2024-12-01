clc;
clear all;
close all;

format long 
 
fs=48000; %Sampling Frequency

% Getting numerator and denominator coefficients 
% from designed filter object
[b,a] = tf(IIR_Cheby1_Lowpass_9)

% Plotting frequency response of filter
figure;
freqz(b,a,200,fs);

% Quantizing numerator and denominator coefficients in 64 bits with 52
% fractional bits and 1 sign bit in QN.M format where Q=1,N=11,M=52 to get
% the maximum possible precise quantization
q = 52; % Number of fractional bits
bhat = round(b*2^q); % Quantized numerator coefficients
ahat = round(a*2^q); % Quantized denominator coefficients
% Numerator coefficients in 64-bit binary
dec2bin(bhat,64)
% Denominator coefficients in 64-bit binary of which the negative ones
% are manually converted to two's complement
dec2bin(abs(ahat),64) 

% Plotting frequency response of filter with quantized coefficients
figure;
freqz(bhat,ahat,200,fs);

% [ss,gn] = tf2sos(b,a,'down')


% frac_bit = 8;
% bhat = round(b*2^frac_bit);
% ahat = round(a*2^frac_bit);
% 
% c = [bhat ahat]

% figure;
% freqz(b,a,200,fs);  % plot frequency response of filter

% % % try_0
% % numerator
% range_b=max(b)-min(b);
% interval_size_b=range_b/256;
%  
% partition_b=[min(b)+interval_size_b:interval_size_b:max(b)];
% codebook_b=[0:256];
% quants_b = quantiz(b,partition_b,codebook_b) % print Quantized filter coefficients
% 
% % denominator
% range_a=max(a)-min(a);
% interval_size_a=range_a/256;
%  
% partition_a=[min(a)+interval_size_a:interval_size_a:max(a)];
% codebook_a=[0:256];
% quants_a = quantiz(a,partition_a,codebook_a) % print Quantized filter coefficients
% 
% figure;
% freqz(quants_b,quants_a,200,fs);

% 
% % try_1
% % numerator
% range_b=max(b)-min(b);
% interval_size_b=range_b/512;
%  
% partition_b=[min(b)+interval_size_b:interval_size_b:max(b)];
% codebook_b=[0:512];
% quants_b = quantiz(b,partition_b,codebook_b) % print Quantized filter coefficients
% 
% % denominator
% range_a=max(a)-min(a);
% interval_size_a=range_a/512;
%  
% partition_a=[min(a)+interval_size_a:interval_size_a:max(a)];
% codebook_a=[0:512];
% quants_a = quantiz(a,partition_a,codebook_a) % print Quantized filter coefficients
% 
% % try_2
% c = [b a(2:end)]
% 
% range=max(c)-min(c);
% interval_size=range/256;
%  
% partition=[min(c)+interval_size:interval_size:max(c)];
% codebook=[0:256];
% quants = quantiz(c,partition,codebook) % print Quantized filter coefficients

% % try_3
% % first determine the number of non-frac bits needed to quantize the
% % numerator and denominator
% nonfraca = ceil(log2(max(abs(a(2:end)))));
% nonfracb = ceil(log2(max(abs(b))));
% 
% % quantize coefficients (we know there won't be overflow)
% B = 8; % we have B+1 total bits, including sign
% qa = B-nonfraca; % fractional bits for denominator
% qb = B-nonfracb; % fractional bits for numerator
% % ahat = round(a*2^qa)/2^qa; % quantized denominator
% % bhat = round(b*2^qb)/2^qb; % quantized numerator
% ahat = round(a*2^qa) % quantized denominator
% bhat = round(b*2^qb) % quantized numerator
% 
% % compute quantized coefficients frequency response
% figure;
% freqz(bhat,ahat,200,fs);

% c = [bhat ahat];
% 
% range=max(c)-min(c);
% interval_size=range/256;
%  
% partition=[min(c)+interval_size:interval_size:max(c)];
% codebook=[0:256];
% quants = quantiz(c,partition,codebook) % print Quantized filter coefficients
% 
% figure;
% freqz(c(1:10),c(11:end),200,fs);
% 
% conv_bin = dec2bin(quants)
% 
% d = [109 112 120 134 147 147 134 120 112 109 174 332 253 258 255 256 191 317 130 357];
% figure;
% freqz(d(1:10),d(11:end),200,fs);

% % numerator
% range_bhat=max(bhat)-min(bhat);
% interval_size_bhat=range_bhat/256;
%  
% partition_bhat=[min(bhat)+interval_size_bhat:interval_size_bhat:max(bhat)];
% codebook_bhat=[0:256];
% quants_bhat = quantiz(bhat,partition_bhat,codebook_bhat) % print Quantized filter coefficients
% 
% % denominator
% range_ahat=max(ahat)-min(ahat);
% interval_size_ahat=range_ahat/256;
%  
% partition_ahat=[min(ahat)+interval_size_ahat:interval_size_ahat:max(ahat)];
% codebook_ahat=[0:256];
% quants_ahat = quantiz(ahat,partition_ahat,codebook_ahat) % print Quantized filter coefficients
% 
% conv_bin = dec2bin(quants_ahat)
% 
% d = [0 15 71 170 255 255 170 71 15 0 174 332 253 258 255 256 191 317 130 357];
% figure;
% freqz(d(1:10),d(11:end),200,fs);

% d = [1 10 42 98 147 147 98 42 10 1 64 479 142 406 144 404 81 465 20 504];
% figure;
% freqz(d(1:10),d(11:end),200,fs);

% b1 = [1 2 1].*0.635868546465835238201691481663146987557;
% a1 = [1 0.606559734469824252123260066582588478923 0.936914451393516700683505860069999471307];
% b2 = [1 2 1].*0.540150695908390376942520560987759381533;
% a2 = [1 0.357882093255650679530788238480454310775 0.80272069037791060619468908043927513063];
% b3 = [1 2 1].*0.376723138296045478856655108756967820227;
% a3 = [1 -0.125407966311032320616547508507210295647 0.63230051949521437482104602167964912951];
% b4 = [1 2 1].*0.163688851583407068979170162492664530873;
% a4 = [1 -0.777958267207629394768275687965797260404 0.432713673541257615173805106678628362715];
% b5 = [1 1 0].*0.214504303765117948499252520377922337502;
% a5 = [1 -0.570991392469764158512646190501982346177 0];
% b = [b1 b2 b3 b4 b5]
% a = [a1 a2 a3 a4 a5]
% % nonfraca = ceil(log2(max(abs(a))));
% % nonfracb = ceil(log2(max(abs(b))));
% % 
% % B = 15; % we have B+1 total bits, including sign
% % qa = B-nonfraca; % fractional bits for denominator
% % qb = B-nonfracb; % fractional bits for numerator
% % ahat = round(a*2^qa)/2^qa % quantized denominator
% % bhat = round(b*2^qb)/2^qb % quantized numerator
% 
% q = 14;
% bhat = round(b*2^q)
% ahat = round(a*2^q)