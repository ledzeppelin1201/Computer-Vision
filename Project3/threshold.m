function tf = threshold(f,th)

[M, N] = size(f);
for x = 1 : M
    for y = 1 : N
        if f(x,y) < th
            tf(x,y) = 0;
        else
            tf(x,y) = 1;
        end
    end
end

end