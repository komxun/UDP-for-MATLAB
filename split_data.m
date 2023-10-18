function [data1,data2] = split_data(data,n)
    data1 = data(1:n);
    data2 = data(n+1:end);
end