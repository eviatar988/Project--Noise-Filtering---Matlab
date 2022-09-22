%this funch calcultate the DFT 
%input: x - SIGNAL, n - time vector ,Nw - num of sampels
%output: X , omega - signal in omega axis

function [X,omega] = my_DTFT(x,n, Nw)
if mod(Nw,2)==0       %if the num of sumpel
    k=-Nw/2+1:1:Nw/2;      %k is sum that strat from -Nw/2 +1 to Nw/2
else                         % k is odd
    k=-(Nw-1)/2:1:(Nw-1)/2;      %k is sum that strat from -(Nw-1)/2 to (Nw-1)/2
end
omega=2*pi*(k)/Nw;            %w=w0*k ,w0=2*pi/Nw
if size(n,1)==1               
    n=n.';
end
if size(x,2)==1 
    x=x.';
end
expo=exp(-1i*n*omega);        
X=x*expo;                     %Multiplication between vector and expo
end