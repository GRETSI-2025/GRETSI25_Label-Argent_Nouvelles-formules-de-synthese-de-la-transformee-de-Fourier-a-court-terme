%% Fig 1 (d) calcul de F_x^{D2h}
[tfr_d2h] = tfrgab2h(x, M, D2h);

% Fig 1 (d)
plot_tfr( abs(tfr_d2h(m_range,:)).^2, f_range, t_range, 7);
xlabel(leg_temp);ylabel(leg_freq);
title(sprintf('|F_x^{D2h}(t,w)|^2 , L=%.2f, RSB=%.2f dB', L, rsb))
saveas(gcf, 'figs/Fxd2h.eps', 'epsc');

%% Fig 1 (h) reconstruction utilisant Eq. (17)
[ x_hat ] = real(rectfrgabh(tfr_d2h, M, D2h, n0));

figure(8)
plot(x,'k-')
hold on
plot(real(x_hat),'r-.')
xlabel(leg_temp);ylabel('amplitude');
legend('original signal', 'reconstruction')
title(sprintf('RQF: %.3f dB', RQF(x,x_hat.')))
saveas(gcf, 'figs/x_hat_d2h.eps', 'epsc');

fprintf('\n Reconstruction de Fx^{D2h}\t\t\tRQF =: %.3f dB', RQF(x,x_hat.'));
