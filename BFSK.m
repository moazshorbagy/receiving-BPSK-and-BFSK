% realization is sent to be able to plot one realization
function detectedStream = BFSK(randBits, A, realization)

inStream = generateRandomBitStream(randBits);
% obtaining the PSD of input to get the BW
[pxx, Wout] = periodogram(inStream, [], [], 1);

%% Modulating the input stream
modulatedStream = BFSKModulator(inStream, A);

%% Adding White Gaussain Noise
w = wgn(1, length(inStream), 1);
receivedStream = modulatedStream + w;

%% Passing by the matched filters
w1 = 2 * pi * (4+1) / 40;
w2 = 2 * pi * (4-1) / 40;
mf1 = MatchedFilter(A, w1, 40);
mf2 = MatchedFilter(A, w2, 40);

out1 = conv(receivedStream, mf1);
out2 = conv(receivedStream, mf2);

%% Comparing with the threshold

index = 1;
detectedStream = zeros (1, length(inStream)/40);
for i = 40:40:length(inStream)
    if(out1(i) > out2(i))
        detectedStream(index) = 1;
    else
        detectedStream(index) = 0;
    end
    index = index + 1;
end

%% Plotting
if(A>0.5 && realization==1)
    figure;
    set(gcf, 'name', 'Modulator Output', 'numbertitle', 'off');

    subplot(4, 1, 1);
    stairs(inStream);
    ylim([-1.5 1.5]);
    xlim([1 length(inStream)+1]);
    title('Input Stream');

    subplot(4, 1, 2);
    plot(modulatedStream);
    ylim([-A A]);
    title('Modulated Stream');

    subplot(4, 1, 3);
    plot(receivedStream);
    title('Received Stream');

    tempStream = detectedStream;
    tempStream(length(detectedStream)+1) = detectedStream(length(detectedStream));
    subplot(4, 1, 4);
    stairs(tempStream);
    ylim([-0.5 1.5]);
    xlim([1 length(tempStream)]);
    title('Detected Stream');

    % PSD of input
    figure;
    plot(Wout,pxx);
    title('PSD');
end
