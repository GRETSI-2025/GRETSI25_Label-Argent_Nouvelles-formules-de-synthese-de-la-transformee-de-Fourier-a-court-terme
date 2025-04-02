%% Fig 1 (c) calcul de F_x^{Dh}
[tfr_dh] = tfrgab2h(x, M, Dh);

%% Fig 1 (c)
plot_tfr( abs(tfr_dh(m_range,:)).^2, f_range, t_range, 5);
xlabel(leg_temp);ylabel(leg_freq);
title(sprintf('|F_x^{Dh}(t,w)|^2 , L=%.2f, RSB=%.2f dB', L, rsb))
saveas(gcf, 'figs/Fxdh.eps', 'epsc');


%% Utilisation de l'Eq. (17) - retourne 0 en theorie

% mm = m_axis(M);
% x_hat = zeros(1, N);
% for n = 1:N
%  x_hat(n) = sum(tfr_dh(:, n) .* exp(1i *2*pi*(n-1)*mm'/M));
% end
[ x_hat ] = abs(rectfrgabh(tfr_dh, M, h, n0));

figure(51)
plot(abs(x_hat),'k-')
title('Module de la marginale de F_x^{Dh} (vaut 0 en theorie)')
saveas(gcf, 'figs/x_hat_dh.eps', 'epsc');


%% Fig 1 (g) reconstruction utilisant la regle de l Hopital Eq. (24) with n=1

[ x_hat ] = real(rectfrgabh(1i * omega .* tfr_dh, M, D2h, n0));

fprintf('\n Reconstruction Eq. (24) de Fx^{Dh}\t\tRQF =: %.3f dB', RQF(x,x_hat.'));


% Fig 1 (g)
figure(6)
plot(x,'k-')
hold on
plot(real(x_hat),'r-.')
xlabel(leg_temp);ylabel('amplitude');
legend('original', 'reconstruction');
title(sprintf('RQF: %.3f dB', RQF(x,x_hat.')))
saveas(gcf, 'figs/x_hat_dhhop.eps', 'epsc');

alpha = 0.25;
[tfr_x_hat] = tfrgab2h(x_hat, M, h);
plot_tfr( abs(tfr_x_hat(m_range,:)).^2, f_range, t_range, 61, alpha);
xlabel(leg_temp);ylabel(leg_freq);
title(sprintf('Reconstruction Eq. (24) de Fx^{Dh} , L=%.2f, TFR^a a=%.2f dB', L, alpha))

