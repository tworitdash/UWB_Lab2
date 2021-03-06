clear all;
close all;

[serial_1, time_1, signal_1] = textread('basicpulsewo_matched_load.txt', '%f %f %f');
[serial_2, time_2, signal_2] = textread('basicpulsewo_matched_load.txt', '%f %f %f');

% plot(time_1, signal_1, 'LineWidth', 2);
% hold on;
% plot(time_2, signal_2, 'LineWidth', 2);

grid on;

inc = signal_1 + abs(signal_1(1));
ref = signal_2 + abs(signal_2(1)) - (inc);

%% PLot of incident and reflected pulses

plot(time_1, inc, 'LineWidth', 2, 'Color', [0.6350, 0.0780, 0.1840]);
hold on;
plot(time_1, ref, 'LineWidth', 2, 'Color', [0.25, 0.25, 0.25]);
grid on;

xlabel('time(nS)', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Incident and Reflected Pulse', 'FontSize', 12, 'FontWeight', 'bold');
title('Time domain plot of incident and reflected pulses', 'FontSize', 12, 'FontWeight', 'bold');
legend({'Incident Pulse', 'Reflected Pulse'}, 'FontSize', 12, 'FontWeight', 'bold', 'Location', 'northeast');

%print('ir_short', '-depsc');

%print('ir_another_load', '-depsc');

%print('ir_another_load_finger', '-depsc');

%print('ir_another_load_less', '-depsc');

%% Window to take average: 


win_1 = zeros(size(time_1, 1), size(time_1, 2));
win_2 = zeros(size(time_2, 1), size(time_2, 2));
count_1 = 0;
count_2 = 0;

% on incident pulse
for i = 1:size(time_1, 1)
     if time_1(i) > 6.5 && time_1(i) < 16
         count_1 = count_1 + 1;
         win_1(i) = 1;
     end
end

% on reflected pulse

for j = 1:size(time_2, 1)
     if time_2(j) > 25.5 && time_2(j) < 34
         count_2 = count_2 + 1;
         win_2(j) = 1;
     end
end

%% Gamma calculation:

sig_1_avg = sum(win_1 .* inc)./count_1; % Average of incident pulse

sig_2_avg = sum(win_2 .* ref)./count_2; % Average of reflected pulse

Gamma = sig_2_avg ./ sig_1_avg

%hold on;
%plot(time_1, Gamma, 'LineWidth', 2);

