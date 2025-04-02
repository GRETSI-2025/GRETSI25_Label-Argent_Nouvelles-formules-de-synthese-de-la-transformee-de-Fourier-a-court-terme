function value = RQF(s, s_hat)
% function value = RQF(s, s_hat)
%
% Compute the Reconstruction Quality Function expressed in dB
% and defined by 10 log10(|s|^2 / |s-s_hat|^2)
%
% INPUT:  
% s:       Reference signal
% s_hat:   Estimated signal
%
%
% Author: D. Fourer (dominique@fourer.fr)
% Date: Sept 2015
% Ref: [D.Fourer, F. Auger and P.Flandrin. Recursive versions of the Levenberg-Marquardt
% reassigned spectrogram and of the synchrosqueezed STFT. IEEE Proc. ICASSP 2016.]
% [D. Fourer, F. Auger, K.Czarnecki, S. Meignen and P. Flandrin, 
% Chirp rate and instantaneous frequency estimation. IEEE Signal Processing Letters 2017]

value=20*log10(norm(s)/norm(s-s_hat));

end