bitStream = generateRandomBitStream(2);

plot(bitStream);
ylim([-2 2]);
grid;
hold on;
modulated_signal = BPSKModulator(bitStream, 10);
plot(modulated_signal);
ylim([-20 20]);