clear
close all

theta_0=1/25;
eta = sqrt(2)/2;
eta=1.0*eta;
denom = (1+2*eta*theta_0+theta_0*theta_0)
k_i = (4*theta_0*theta_0)/denom;
k_p = (4*eta*theta_0)/denom;

dphi=[0.05*ones(1,200) 0.10*ones(1,200)];
phi_1=filter(1,[1 -1],dphi);

s_1 = exp(j*2*pi*phi_1);
phi_sv = zeros(1,400);
int_sv = zeros(1,400);
accum_sv = zeros(1,400);
dphi_sv = zeros(1,400);
phi_2_sv= zeros(1,400);
int = 0;
accum = 0;
for nn=1:400
    % Multiplier
    prod = s_1(nn)*exp(-j*2*pi*accum);
    phi = angle(prod)/(2*pi);
    phi_sv(nn) = phi;   
    % Loop filter
    int = int + k_i*phi;
    dphi = k_p*phi+int;
    dphi_sv(nn) = dphi;
    % DSS
    phi_2_sv(nn) = accum;
    accum = accum+dphi;
end

figure
subplot(2,1,1)
plot(0:length(phi_sv)-1,phi_sv)
title('Loop phase error')
subplot(2,1,2)
plot(dphi_sv);
grid on;
title('Output of Loop Filter, DDS Control Frequency')

figure
plot(0:length(phi_1)-1,phi_1)
hold on
plot(0:length(phi_2_sv)-1,phi_2_sv, 'r')
title('Input and output phase')
legend('Input Phase','Output Phase')
ylim([0 max(phi_1)])

figure
subplot(2,1,1)
plot(0:length(s_1)-1,real(s_1))
hold on
plot(0:length(phi_2_sv)-1,cos(2*pi*phi_2_sv))
title('Real Part of input/output signals')
legend('Input', 'Output')

subplot(2,1,2)
plot(0:length(s_1)-1,imag(s_1))
hold on
plot(0:length(phi_2_sv)-1,sin(2*pi*phi_2_sv))
title('Imaginary Part of input/output signals')
legend('Input', 'Output')


