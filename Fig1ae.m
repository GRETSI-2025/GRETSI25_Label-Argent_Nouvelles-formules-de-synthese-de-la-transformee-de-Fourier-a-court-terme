% calcul de F_x^h
[tfr] = tfrgab2h(x, M, h);

% Fig 1 (a)
plot_tfr( abs(tfr(m_range,:)).^2, f_range, t_range, 1);
xlabel(leg_temp);ylabel(leg_freq);
title(sprintf('|F_x^h(t,w)|^2 , L=%.2f, RSB=%.2f dB', L, rsb))
saveas(gcf, 'figs/Fxh.eps', 'epsc');

%% Reconstruction de x  via Eq. (17)
[ x_hat ] = real(rectfrgabh(tfr, M, h, n0));
fprintf('\n Reconstruction de Fx^h\t\t\t\tRQF =: %.3f dB', RQF(x,x_hat.'));

% Fig 1 (e)
figure(2)  
plot(x,'k-')
hold on
plot(real(x_hat),'r-.')
xlabel(leg_temp)
legend('original signal', 'reconstruction')
title(sprintf('RQF: %.3f dB', RQF(x,x_hat.')))
