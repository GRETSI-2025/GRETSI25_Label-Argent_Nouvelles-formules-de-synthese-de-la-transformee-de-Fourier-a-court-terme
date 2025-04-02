function [ s_hat ] = rectfrgabh(tfr, M, h, n0, t0, mm)
% [ s_hat ] = rectfrgab( tfr, h)
%
% signal reconstruction from the Gabor Transform using the simplified
% formula
%
% INPUT:
% tfr      : the TFR to reconstruct
% M        : number of frequency bins
% h        : an arbitrary chosen window
% n0       : time instant centered at t=0 on the window
% t0       : time delay (expressed in samples applied to the reconstructed signal)
% mm       : frequencies bins to reconstruct
%
% OUTPUT:
% s_hat    : reconstructed signal
%
%--------------------------------------------------------------------------
% Nom du fichier : rectfrgabh.m
% Auteur        : Dominique Fourer (dominique@fourer.fr) 
% Date          : 31/03/2025
% Description   : Applique la formule de reconstruction de la TFCT Eq. (17)
%                 via la marginalisation en frequence avec une fenetre h
%                 arbitraire
%
%  D. Fourer, F. Auger, E Chassandre-Mottin, P. Flandrin, Nouvelles 
%  formules de synth?se de la transform?e de Fourier ? court terme
%  avec une fen?tre d'analyse modifi?e. Soumis a GRETSI 2025.
%
%
% MIT License
% Copyright (c) 2025 Dominique Fourer
%
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"),
% to deal in the Software without restriction, including without limitation
% the rights to use, copy, modify, merge, publish, distribute, sublicense, 
% and/or sell copies of the Software, subject to the following conditions:
%
% This notice shall be included in all copies or substantial portions of the Software.
%
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.
%--------------------------------------------------------------------------


if ~exist('n0', 'var')
 n0 = floor(length(h)/2)+1;
end

if ~exist('t0', 'var')
 t0 = 0;  %default no-delay
end

N = size(tfr, 2);

if ~exist('mm', 'var')
 mm = m_axis(M);
end

s_hat = zeros(1, N);

omega = 2*pi*mm'/M;
for n = 1:N
  t = (n-1);
  s_hat(n) = sum(tfr(:, n) .* exp(1i * omega * (t-t0))   );
 end
s_hat = s_hat /h(n0+t0) /M;


end

