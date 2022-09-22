%PART A - SENDING FUNCTIONS TO DTFT
%% cos(w0*n)
Nw = 512;
n=-50:1:50;
w0=2.5;
x1=cos(w0*n);
[X1,omega_cos]=my_DTFT(x1,n,Nw);
plot(omega_cos,abs(X1))
xlabel('W')
ylabel('X(e^(jw))')
title('X fourie transformation')
%% sinc
Nw = 512;
n=-50:1:50;
a=size(n);
if mod(a,2)==0
    mid=a/2;
else
    mid=(a+1)/2;
end
B=3;
x2=B/pi.*sinc(B.*n/pi);
plot(x2)
[X2,omeage_sin]=my_DTFT(x2,n,Nw)
plot(omeage_sin,(X2))
xlabel('W')
ylabel('X(e^(jw))')
title('X fourie transformation')
%% delta
Nw = 512;

n=-50:1:50;
Ntrain=10;
x3=(mod(n,Ntrain))==0
plot(x3)
[X3,omeage_delta]=my_DTFT(x3,n,Nw);
plot(omeage_delta,abs(X3))
xlabel('W')
ylabel('X(e^(jw))')
title('X fourie transformation')
%% step
Nw = 512;
n=-50:1:50;
x4=heaviside(4+n).*heaviside(4-n)
[X4,omeage_step]=my_DTFT(x4,n,Nw);
plot(x4)
plot(omeage_step,(X4))
xlabel('W')
ylabel('X(e^(jw))')
title('X fourie transformation')
