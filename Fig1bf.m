%% calcul de F_x^{Th}
[tfr_th] = tfrgab2h(x, M, Th);


%% Fig 1 (b)
plot_tfr( abs(tfr_th(m_range,:)).^2, f_range, t_range, 3);
xlabel(leg_temp);ylabel(leg_freq);
title(sprintf('|F_x^{Th}(t,w)|^2 , L=%.2f, RSB=%.2f dB', L, rsb))
saveas(gcf, 'figs/Fxth.eps', 'epsc');

%% Utilisation de l'Eq. (17) - retourne 0 en theorie

% mm = m_axis(M);
% x_hat = zeros(1, N);
% for n = 1:N
%  x_hat(n) = sum(tfr_th(:, n) .* exp(1i *2*pi*(n-1)*mm'/M));
% end
[ x_hat ] = abs(rectfrgabh(tfr_th, M, h, n0));

figure(31)
plot(abs(x_hat),'k-')
title('Module de la marginale de F_x^{Th} (vaut 0 en theorie)')
saveas(gcf, 'figs/x_hat_th.eps', 'epsc');

%% Fig 1 (f) reconstruction utilisant la regle de l Hopital Eq. (26) with n=0
[ x_hat ] = real(rectfrgabh(1i * omega .* tfr_th, M, h, n0));

% Om = repmat(1i * omega, [1 N]);
%[ x_hat ] = real(rectfrgabh(Om .* tfr_dh, M, D2h, n0)); %n0

fprintf('\n Reconstruction Eq. (24) de Fx^{Th}\t\tRQF =: %.3f dB', RQF(x,x_hat.'));

% Fig 1 (f)
figure(4)
plot(x,'k-')
hold on
plot(real(x_hat),'r-.')
xlabel(leg_temp);ylabel('amplitude');
legend('original', 'reconstruction');
title(sprintf('RQF: %.3f dB', RQF(x,x_hat.')))
saveas(gcf, 'figs/x_hat_thhop.eps', 'epsc');


alpha = 0.25;
[tfr_x_hat] = tfrgab2h(x_hat, M, h);
plot_tfr( abs(tfr_x_hat(m_range,:)).^2, f_range, t_range, 41, alpha);
xlabel(leg_temp);ylabel(leg_freq);
title(sprintf('Reconstruction Eq. (24) de Fx^{Th} , L=%.2f, TFR^a a=%.2f dB', L, alpha))



