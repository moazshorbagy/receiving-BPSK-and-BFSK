function x = generateRandomBitStream(size)

randBits = round(rand(1,size));
%Tb = 40
x = zeros(1, length(randBits) * 40);
k = 1;
for i = 1 : length(randBits)
    if(randBits(i) == 0)
        amplitude = -1;
    else 
        amplitude = 1;
    end
    x(k : k + 40) = amplitude;
    k = 40 * i + 1;
end