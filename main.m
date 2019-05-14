close all
clear
clc

numberOfBits = 15;
A = 1;

inStream = generateRandomBitStream(numberOfBits);

BFSK(inStream, A);