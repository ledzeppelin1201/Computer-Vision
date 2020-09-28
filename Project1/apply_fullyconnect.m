%apply_fullyconnect
%This function makes a 1x1 scalar output following a similar process
%to convolution involving a lineaar combination of N x M x D input
%but instead uses multiplication of evey pixel of the image and filter
%the result is the total summation in each channel

function Out = apply_fullyconnect(image, filterbank, biasvals)
    [N, M, D1]=size(image); D2=size(filterbank,4);
    
    for l=1:D2
        S = 0;
        for i=1:N
            for j=1:M
                for k=1:D1
                    h = filterbank(:,:,k,l);
                    A = image(:,:,k);
                    S = S + A(i,j)*h(i,j);
                end
            end
        end
        Out(:,:,l) = S + biasvals(l);
    end
    
end