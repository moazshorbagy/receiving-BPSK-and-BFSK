% x: Array of symbols
function x = BFSKModulator(inStream, A)

w1 = 2 * pi * (4+1) / 40;
w2 = 2 * pi * (4-1) / 40;

x = zeros(1, length(inStream));

% for each bit sent
for i = 1:length(inStream)
    if inStream(i) == 1 
        x(i) = A * cos(w1*i);
    else
        x(i) = A * cos(w2*i);
    end
end
