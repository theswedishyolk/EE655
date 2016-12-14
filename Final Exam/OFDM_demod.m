function [y lol boll] = OFDM_demod(x,g,N,n_bins,p)
% OFDM_demod(x,g,N,n_bins,*p)
% Demodulates OFDM data
%
% Input parameters:
% x=input data
% g=length of guard interval
% N=number of symbols
% n_bins=number of frequency bins
% p=preamble in QPSK modulation(optional)
%
% Output variables
% y=output
y=[];
phi=zeros(1,n_bins);
p_chan=1;
if exist('p','var')
    start=g+n_bins+1;
    start=1;
    p_chan=x(51:(n_bins+g))./p(51:end)/10;
else
    start=1;
end

for n=start:(n_bins+g):N*(n_bins+g)
    tmp_t=x((n+g):(n+(n_bins+g-1)))./(p_chan);
    tmp_f=fftshift(fft(tmp_t)/10);
    y=[y tmp_f'];
end
end

