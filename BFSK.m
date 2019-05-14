function BFSK(inStream, A)

%% Modulating the input stream
modulatedStream = BFSKModulator(inStream, A);

numberOfBits = length(inStream);
t = 1:numberOfBits*40;

% expanding the input stream by 1 for plotting
inStream(numberOfBits+1) = inStream(numberOfBits);

% plotting the modulated stream
figure;
set(gcf, 'name', 'Modulator Output', 'numbertitle', 'off');
subplot(2, 1, 1);
plot(t, modulatedStream(:));
title('Modulator Stream');
hold on;
subplot(2, 1, 2);
stairs(inStream);
ylim([-1 2]);
xlim([1 numberOfBits+1]);
title('Input Stream');
hold off;

%%

