% x: Array of symbols
function x = BFSKModulator(inStream, A)

w1 = 2 * pi * (4+1) / 40;
w2 = 2 * pi * (4-1) / 40;

x = zeros(40, length(inStream));
t = 1:40;

s1 = A * cos(w1*t);
s2 = A * cos(w2*t);
% for each bit sent
for i = 1:length(inStream)
    if inStream(i) == 1 
        x(:, i) = s1;
    else
        x(:, i) = s2;
    end
end
