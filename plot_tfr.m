function [ ] = plot_tfr( tfr, f_axis, t_axis, num_fig, alpha )
% [ ] = plot_tfr( tfr, t_axis, f_axis, num_fig, titre, alpha )
%
% display a Time-Frequency Representation (TFR)
%
% INPUT:
% tfr      : the TFR
% f_axis   : frequency axis
% t_axis   : time_axis
% num_fig  : id of the figure
% alpha    : contrast parameter, recommanded values in range ]eps, 0.5]
%
%--------------------------------------------------------------------------
% Nom du fichier : plot_tfr.m
% Auteur        : Dominique Fourer (dominique@fourer.fr) 
% Date          : 31/03/2025
% Description   : Reproduit les resultats de l'article mentionne
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

if ~exist('num_fig', 'var')
  figure
else
  figure(num_fig)
end

if ~exist('alpha', 'var')
  alpha = 1;
end

if ~exist('t_axis', 'var')
  t_axis = 1:size(tfr,2);
end

imagesc(t_axis, f_axis, abs(tfr).^alpha)
colormap('gray');cmap = colormap;colormap(flipud(cmap));
set(gca,'Ydir', 'normal');
   
end

