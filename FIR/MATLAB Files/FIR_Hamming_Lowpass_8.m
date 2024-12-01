function Hd = FIR_Hamming_Lowpass_8
%FIR_HAMMING_LOWPASS_8 Returns a discrete-time filter object.

% FIR Window Lowpass filter designed using the FIR1 function.

% All frequency values are in Hz.
Fs = 48000;  % Sampling Frequency

N    = 8;        % Order
Fc   = 14400;    % Cutoff Frequency
flag = 'scale';  % Sampling Flag

% Create the window vector for the design algorithm.
win = hamming(N+1);

% Calculate the coefficients using the FIR1 function.
b  = fir1(N, Fc/(Fs/2), 'low', win, flag);
Hd = dfilt.dffir(b);
