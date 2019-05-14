%inStream: the message bit stream
%Tb: bit duration
%A: Amplitude of s(t)
function x = BPSKModulator(inStream, A)

w_c = 4 * 2 * pi / 40;

x = zeros(1,length(inStream));
for i = 1 : length(inStream)
    x(i) = inStream(i) * A * cos(w_c * i);
end