close all
clear
clc

numberOfBits = 15;
AverageBER = zeros(1, 9);
ActualBER = zeros(1, 9);
for snr = -4:4
    BER = zeros(1, 20);
    A = sqrt(10.^(snr/10)*2*2/40);
    for realization = 1:20
        
        % obtaining the random stream
        randBits = round(rand(1, numberOfBits));

        % passing the input stream to the BFSK module
        detectedStream = BFSK(randBits, A, realization);
        
        % Finding the error
        error = 0;
        for i = 1:length(detectedStream)
            if(detectedStream(i) ~= randBits(i))
                error = error + 1;
            end
        end

        BER(realization) = error/numberOfBits;
    end
    % the observed average bit error rate
    AverageBER(snr+5) = sum(BER)/length(BER);
    % the actual bit error rate
    ActualBER(snr+5) = 0.5 * erfc(sqrt(((A.^2)*40)/8));
end

%% plotting bit error rate
snr = -4:4;
figure;
semilogy(snr, AverageBER, 'r')
hold on
semilogy(snr, ActualBER, 'b')
