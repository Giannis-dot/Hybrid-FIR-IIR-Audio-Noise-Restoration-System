%%Hybrid sound-restoring system

load handel.mat
%sound(y, Fs);

n=30000;
signal=y(1:n); %30k samples, to make the signal 'lighter'

t = (1/Fs*(0:n-1))';

noise=0.1*sin(2*pi*50*t); %mains-hum noise
noise2=0.05*sin(2*pi*3000*t); %high frequency whine

noisy_signal=signal+noise+noise2;

%Low frequency filtering
N=3;
fc=45;
fp=55;
Wn=[fc fp]/(Fs/2);
[b, a]=cheby2(N,40,Wn,'stop');

freqz(b,a,1024,Fs);
semi_filtered_signal=filtfilt(b,a,noisy_signal);

%High frequency filtering
N_high=50;
fc_FIR=2900;
fp_FIR=3100;
Wn_FIR=[fc_FIR, fp_FIR]/(Fs/2);
b=fir1(N_high, Wn_FIR,'stop');
cleaned_signal=filtfilt(b,1,semi_filtered_signal);

%Results
sound(signal,Fs); 
pause(length(signal)/Fs); 
sound(cleaned_signal, Fs);

err=signal-cleaned_signal;
squaredErr=sum(err.^2);
fprintf('Total squared Error: %g\n', squaredErr);

Win=256;
[pxx, f]=pwelch(noisy_signal,Win, 200, 256,Fs,"onesided");
[pxx2, f2]=pwelch(cleaned_signal,Win,200,256,Fs,"onesided");

figure;
plot(f, 10*log10(pxx)),title('Power Spectral Density of Noisy Signal'),
xlabel('Frequency (Hz)'),ylabel('Power/Frequency (dB/Hz)'),
hold on;
plot(f, 10*log10(pxx2)), title('Power Spectral Density of Cleaned Signal'), xlabel('Frequency (Hz)'), ylabel('Power/Frequency (dB/Hz)');
legend('Noisy Signal', 'Cleaned Signal');
hold off;







