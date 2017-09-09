function [UIMatrix] = itemBased(UIMatrix, num_sample)

[row,column] = size(UIMatrix)
index_u = zeros(1,row);
index_i = zeros(1,column);
for x = 1:row
    index_u(x) = column - size(find(UIMatrix(x,:)==0),2);
end
for y = 1:column
    index_i(y) = row - size(find(UIMatrix(:,y)==0),1);
end

len = length(index_i);
len_u = length(index_u);

culProp = 1 ./ index_i;
culProp(find(culProp==Inf)) = 0;
for x = 2:len
    culProp(x) = culProp(x - 1) + culProp(x);
end
culProp = culProp / culProp(len);

%sampling
num_item_sample = zeros(1,len);
num_sample_t = num_sample;
x = 0;
while(x < num_sample_t)
    x = x + 1;
    index = 0;
    prop= rand(1);
    for y = 1:len
        index = y;
        if prop <= culProp(y)
            break;
        end
    end
    %sampling without replacement, thus the # of samples must be smaller
    %than the # of negative intances
    if num_item_sample(index) >= len_u - index_i(index)
        num_sample_t = num_sample_t + 1;
        continue;
    end
    num_item_sample(index) = num_item_sample(index) + 1;
end

%# of sampled negative instances
count = 0;

neg_instances = len_u - index_i;
for x = 1:len
    sampleIndex = randperm(neg_instances(x),num_item_sample(x));
    sampleIndex = sort(sampleIndex);
    samLen = length(sampleIndex);
    nonZerosIndex = find(UIMatrix(:,x)~=0);
    nonZerosLen = length(nonZerosIndex);
    index = 1;
    if samLen <= 0
           continue;
    end
    y = 1;
    while(y <= nonZerosLen)
        if sampleIndex(index) >= nonZerosIndex(y)
            sampleIndex(1:1,index:samLen) = sampleIndex(1:1,index:samLen) + 1;
            y = y + 1;
            continue;
        else
            index = index + 1;
            if index > samLen
                break;
            end
        end
    end

    for y = 1:samLen
        UIMatrix(sampleIndex(y),x) = -1;
    end
end

end

