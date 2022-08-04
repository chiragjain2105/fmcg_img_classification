function z = sigmoid(z)
[m,n]=size(z);
for i=1:1:m
    for j=1:1:n
        z(i,j)=1/(1+exp(-z(i,j)));
    end
end
end