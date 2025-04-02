function [tfr] = tfrgab2h(x, M, h,n0, gamma_K)
% [tfr] = tfrgab2(x, M, L, h, gamma_K)
% Compute the discrete-time Gabor Transform (using FFT)
% 
% INPUT:
% x      : the signal to process
% M      : number of frequency bins to process (default: length(x))
% L      : window duration parameter:  w0 * T, (default: 10)
% h      :
% gamma_K: threshold applied on window values (default: 10^(-4))
%
% OUTPUT:
% tfr    : STFT computed using window h
%
% Author: D.Fourer
% Date: 28-08-2015

x = x(:).';          %convert x as a row vector
N = length(x);

if ~exist('M', 'var')
 M = N;
end

if ~exist('h', 'var')
  L = 10;
  n_rg = -ceil(M/2):ceil(M/2);
  C = -1 / (2*L^2);
  n0 = ceil(M/2)+1;
  h = 1/(sqrt(2*pi)*L) * exp(C * n_rg.^2);
  
%   plot(h)
%   hold on
%   plot(n0,h(n0),'rx');
%   pause
end

if ~exist('n0', 'var')
 n0 = floor(length(h)/2)+1;
end


if ~exist('gamma_K', 'var')
 gamma_K = 10^(-4);
end

tfr = zeros(M, N);


%K = 2 * L * sqrt(2*log(1/gamma_K));  %% window length in samples
K = length(find(h > gamma_K));

B = -1i * 2*pi / M;

mm = m_axis(M);
for n = 1:N
  
  k_min = min(n-1, round(K/2));
  k_max = min(N-n, round(K/2));
  k = (-k_min):k_max;
  k2 = k.^2;
  g = h(n0+k);
  %A * exp( C * k2);

  tfr(:,n) = fft(x(n+k) .* g, M) .* exp(B * mm * (n-1 - k_min));
end
end