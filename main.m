close all
clear
clc

numberOfBits = 200;
Tb = 40;
N_0 = 2;

Average_BFSK_BER = zeros(1, 9);
Average_BPSK_BER = zeros(1, 9);

Theoritical_BFSK_BER = zeros(1, 9);
Theoritical_BPSK_BER = zeros(1, 9);

for snr = -4:4
    BPSK_BER = zeros(1, 20);
    BFSK_BER = zeros(1, 20);
    A = sqrt(10.^(snr/10)*2*2/Tb);
    for realization = 1:20
        
        % obtaining the random stream
        randBits = round(rand(1, numberOfBits));

        % passing the input stream to the BFSK module
        BPSK_detectedStream = BPSK(randBits, A, realization, Tb);
        %Tb is imbedded in the BFSK function
        BFSK_detectedStream = BFSK(randBits, A, realization);
        
        % Finding the error
        BPSKerror = 0;
        BFSKerror = 0;
        for i = 1:length(BPSK_detectedStream)
            if(BPSK_detectedStream(i) ~= randBits(i))
                BPSKerror = BPSKerror + 1;
            end
             if(BFSK_detectedStream(i) ~= randBits(i))
                BFSKerror = BFSKerror + 1;
            end           
        end

        BPSK_BER(realization) = BPSKerror/numberOfBits;
        BFSK_BER(realization) = BFSKerror/numberOfBits;
    end
    % the observed average bit error rate
    Average_BPSK_BER(snr+5) = sum(BPSK_BER)/length(BPSK_BER);
    Average_BFSK_BER(snr+5) = sum(BFSK_BER)/length(BFSK_BER);
    % the theoritical bit error rate
    Theoritical_BFSK_BER(snr+5) = 0.5 * erfc(sqrt(((A.^2)*Tb)/4));
    Theoritical_BPSK_BER(snr+5) = 0.5 * erfc(sqrt(((A.^2)*Tb)/2));
end

%% plotting bit error rate
snr = -4:4;
figure('name', 'BPSK performance', 'NumberTitle', 'off');
semilogy(snr, Average_BPSK_BER, 'r');
hold on
semilogy(snr, Theoritical_BPSK_BER, 'b');
hold off;

figure('name', 'BFSK performance', 'NumberTitle', 'off');
semilogy(snr, Average_BFSK_BER, 'r');
hold on
semilogy(snr, Theoritical_BFSK_BER, 'b');

