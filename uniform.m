function [UIMatrix] = uniform(UIMatrix ,num_sample)
num_sample_t = num_sample;
[row,column] = size(UIMatrix);
count = row * column;
i = 0;
while(i < num_sample_t)
    i = i + 1;
    temp = randperm(count,1);
    x = floor((temp - 1) / (column)) + 1;
    y = mod(temp + column - 1,column) + 1;
    if UIMatrix(x,y) == 0
        UIMatrix(x,y) = -1;
    else
        num_sample_t = num_sample_t + 1;
    end
end
end

