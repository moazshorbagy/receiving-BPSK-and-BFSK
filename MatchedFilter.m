function x = MatchedFilter(A, w, Tb)
x = zeros(1, Tb);
for t=1:Tb
    x(t) = A * cos(w*(Tb-t));
end