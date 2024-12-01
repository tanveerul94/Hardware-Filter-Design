function Hd = IIR_Cheby1_Lowpass_9
%IIR_CHEBY1_LOWPASS_9 Returns a discrete-time filter object.

% Chebyshev Type I Lowpass filter designed using FDESIGN.LOWPASS.

% All frequency values are in Hz.
Fs = 48000;  % Sampling Frequency

N     = 9;      % Order
Fpass = 14400;  % Passband Frequency
Apass = 0.5;    % Passband Ripple (dB)

% Construct an FDESIGN object and call its CHEBY1 method.
h  = fdesign.lowpass('N,Fp,Ap', N, Fpass, Apass, Fs);
Hd = design(h, 'cheby1');
