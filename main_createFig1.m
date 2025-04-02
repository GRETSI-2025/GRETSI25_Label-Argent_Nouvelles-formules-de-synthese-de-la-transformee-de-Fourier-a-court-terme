%--------------------------------------------------------------------------
% Nom du fichier: main_createFig1.m
% Auteur        : Dominique Fourer (dominique@fourer.fr) 
% Date          : 31/03/2025
% Description   : Reproduit les resultats de l'article ci-dessou
%
%  D. Fourer, F. Auger, E Chassandre-Mottin, P. Flandrin, Nouvelles 
%  formules de synthese de la transformee de Fourier a court terme
%  avec une fenetre d'analyse modifiee. Soumis a GRETSI 2025.
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
clear
close all


% Choix du signal:
M=500;         % nombre d'indices frequentiels
signal = 1;    %1: multi composantes, %2: impulse %3: sinusoids
load_signal;   % genere un signal de taille N=500

% Ajout de bruit   %inf pour le cas sans bruit
rsb=30;   % inf
x = sigmerge(s, randn(size(s)), rsb);

L=8;  % largeur de la fenetre Gaussenne

%%%%%%%%%%%%%%%%%%%%%%%%%  Reglages %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
leg_temp = 'indice de temps'; %'time index'
leg_freq = 'frequence normalisee'; %'time index'

if ~exist('figs', 'dir')
  mkdir('figs');    
end

m_range = 1:M/2;                %indices frequentiels [0, M/2]
f_range = (m_range-1)/M;        %frequences normalisees [0, 0.5]
t_range = 1:N;

mm = m_axis(M);              %mm = -(M/2-1):ceil(M/2);
omega = 2*pi*mm'/M;          % frequences omega
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% h(t) Fenetre Gaussienne 
% creation de la fenetre
n_rg = -ceil(M/2):ceil(M/2);
C = -1 / (2*L^2);
n0 = ceil(M/2)+1;
h = 1/(sqrt(2*pi)*L) * exp(C * n_rg.^2);

%% Th(t)
Th = n_rg .* h;

%% Dh(t)
Dh = -n_rg .* h/(L^2);

%% D2h(t)
D2h = (n_rg.^2/(L^2) - 1) .* h/(L^2);

%% D3h(t)
D3h = 2*n_rg/(L^4) .* h +  (n_rg.^2/(L^2) - 1) .* Dh/(L^2);

%% D4h(t)
D4h = 1/(L^4) * (2*h + 4 *n_rg .* Dh + (n_rg.^2 - L^2) .* D2h);


%%%%%%%%%%%%%%%%%%%%%%%%%% calcul des RTF %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Fx^h et reconstruction
Fig1ae

%% Fx^{Th} et reconstruction
Fig1bf

%% Fx^{Dh} et reconstruction
Fig1cg

%% Fx^{D2h} et reconstruction
Fig1dh


%% calcul de F_x^{D3h} (pas dans l'article)
[tfr_d3h] = tfrgab2h(x, M, D3h);

plot_tfr( abs(tfr_d3h(m_range,:)).^2, f_range, t_range);
xlabel(leg_temp);ylabel(leg_freq);
title(sprintf('|F_x^{D3h}(t,w)|^2 , L=%.2f, RSB=%.2f dB', L, rsb))

%%  Utilisation de l'Eq. (17) - retourne 0 en theorie
[ x_hat ] = abs(rectfrgabh(tfr_d3h, M, h, n0));

figure
plot(abs(x_hat),'k-')
title('Module de la marginale de F_x^{Dh} (vaut 0 en theorie)')

%% Fig 1 (f) reconstruction utilisant la regle de l Hopital Eq. (26) with n=3
[ x_hat ] = real(rectfrgabh(1i * omega .* tfr_d3h, M, D4h, n0));

fprintf('\n Reconstruction Eq. (24) de Fx^{D3h}\t\tRQF =: %.3f dB', RQF(x,x_hat.'));

figure
plot(x,'k-')
hold on
plot(real(x_hat),'r-.')
xlabel(leg_temp);ylabel('amplitude');
legend('original', 'reconstruction');
title(sprintf('RQF: %.3f dB', RQF(x,x_hat.')))

alpha = 0.25;
[tfr_x_hat] = tfrgab2h(x_hat, M, h);
plot_tfr( abs(tfr_x_hat(m_range,:)).^2, f_range, t_range, 101, alpha);
xlabel(leg_temp);ylabel(leg_freq);
title(sprintf('Reconstruction Eq. (24) de Fx^{D3h} , L=%.2f, TFR^a a=%.2f dB', L, alpha))

