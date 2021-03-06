load workspace
close all
figure
subplot(2,1,1)
plot(0,0)
hold on
for n=1:8:8*N-16
    plot(-1:1/8:1, real(x1(n:n+16)), 'k')
end
hold off
title('Eye Diagram at output of shaping filter when alpha = 0.2')
subplot(2,1,2)
plot(0,0)
hold on
for n=1:8:8*N-16
    plot(-1:1/8:1, real(x2(n:n+16)), 'k')
end
hold off
title('Eye Diagram at output of shaping filter when alpha = 0.4')
save('workspace.mat')