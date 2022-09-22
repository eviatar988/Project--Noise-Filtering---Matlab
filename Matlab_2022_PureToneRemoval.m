close all
clc
clear
%% Generation of noisy signal
% Enter your ID 
ID = 315669739;
[inputSignal,fs,SNR_in] = inputSignalBuilder(ID);
soundsc(inputSignal,fs)
figure();plot(0:length(inputSignal)-1,inputSignal);
xlabel('n','fontsize',16);
ylabel('signal','fontsize',16);

audiowrite(['Input_' num2str(ID) '.wav'],inputSignal,fs)
[x, fs]= audioread('about_time.wav');
SNR_in = 10*log10(mean(x.^2)/mean((inputSignal-x).^2));

%% Noise frequency detection
%   In this part the input signal is examined. We assume a pure tone
%   disturbance of cos(w_0*n), and have to locate w_0=(2*pi/N)*k0
%   the cosine wave is periodic with N=512
%% Fourier Discrete Transform - Detect w_0 from the last frame of the signal
Nframe=512;
x_last_frame=inputSignal((end-Nframe+1):end);
n=0:511;
[X,omega]=my_DTFT(x_last_frame,n,Nframe);
stem(omega,abs(X));

% plot x_last_frame DTFT to detect w_0
% dont forget to define w axis to plot the DTFT in right scale

%% Band stop with III implementations
%%%%% Implemetation I : perfect filtering (FIR)
N = 1000;
n = -N:N;
B = pi/50;

w_0 = 2.88388;
h_1 = (2*cos(w_0*n).*sin(B*n))./(pi*n);
h_1(1,1001)=0;
[H_1,omega_1]=my_DTFT(h_1,n,N);
stem(omega_1,abs(H_1));
xlabel('n')
ylabel('H1(jw)')
title('h1 fourie transformation')
% Note- you can use conv() function to filter the signal. 
% use the option 'same' to get the same output length.
% for example if you have: input-x filter-h:
% y= conv(x,h,'same')
v_1=conv(inputSignal,h_1,'same');
y_1 = inputSignal-v_1;
% audiowrite(['Output_I_' num2str(ID) '.wav'],y_1,fs)
 SNR_out = 10*log10(mean(x.^2)/mean((y_1-x).^2));
% figure(2);plot(0:length(y_1)-1,y_1);
% xlabel('n','fontsize',16);
% ylabel('signal','fontsize',16);
% title('filter I Band stop filter')
 soundsc(y_1,fs)
%%% Freaquency response- H_1(e^jw)

%TODO
%%
%%%%% Implemetation II : ZOH design (FIR)
N = 100;
n = -N:N;
w_0 = 2.88388;
h_2 = 2*cos(w_0*n)/(2*N+1);
[X_2,omega_2]=my_DTFT(h_2,n,N);
plot(omega_2,abs(X_2));
xlabel('n')
ylabel('H2(jw)')
title('h2 fourie transformation')
v_2=conv(inputSignal,h_2,'same');
y_2 = inputSignal-v_2;
% audiowrite(['Output_II_' num2str(ID) '.wav'],y_2,fs)
 SNR_out = 10*log10(mean(x.^2)/mean((y_2-x).^2));
% figure(3);plot(0:length(y_2)-1,y_2);
% xlabel('n','fontsize',16);
% ylabel('signal','fontsize',16);
% title('filter II ZOH design')
soundsc(y_2,fs)

%%% Freaquency response- H_2(e^jw)

%TODO

%%
%%%%% Implemetation III : recursive design (IIR)
w_0 =2.88388;
alpha = 0.999;
z_1=0;z_2=0; % initial rest
for n=1:length(inputSignal)
    z_1 = alpha*exp(1i*w_0)*z_1+(1-alpha)*inputSignal(n);
    z_2 = alpha*exp(-1i*w_0)*z_2+(1-alpha)*inputSignal(n);

    y_3(n,1) =inputSignal(n)-z_1-z_2;
end

audiowrite(['Output_III_' num2str(ID) '.wav'],y_3,fs)
SNR_out = 10*log10(mean(x.^2)/mean((y_3-x).^2));
% figure(4);plot(0:length(y_3)-1,y_3);
% xlabel('n','fontsize',16);
% ylabel('signal','fontsize',16);
% title('filter III recursive filter')
soundsc(y_3,fs)
y_3_last_frame=y_3((end-Nframe+1):end);
n1=-256:1:255;
[Y_3,omega_3]=my_DTFT(y_3_last_frame,n1,Nframe);
%H_3=Y_3./X;
h_3=y_3/x
%stem(omega_3,abs(H_3))
stem(omega_3,abs(h_3))


%% Performace evaluation:

[Grade, SNR_out_ref]= GradeMyOutput(ID,y_1,1);
[Grade, SNR_out_ref]= GradeMyOutput(ID,y_2,2);
[Grade, SNR_out_ref]= GradeMyOutput(ID,y_3,3);