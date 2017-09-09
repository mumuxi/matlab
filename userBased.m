function [UIMatrix] = userBased(UIMatrix, num_sample, negValue)


[row,column] = size(UIMatrix);
index_u = zeros(1,row);
index_i = zeros(1,column);
for x = 1:row
    index_u(x) = column - size(find(UIMatrix(x,:)==0),2);
end
for y = 1:column
    index_i(y) = row - size(find(UIMatrix(:,y)==0),1);
end

len = length(index_u);
len_i = length(index_i);
sums = sum(index_u);

culProp = index_u;
for x = 2:len
    culProp(x) = culProp(x - 1) + index_u(x);
end

%sampling
num_user_sample = zeros(1,len);
num_sample_t = num_sample;
x = 0;
while(x < num_sample_t)
    x = x + 1;
    index = 0;
    prop = randperm(sums,1);
    for y = 1:len
        index = y;
        if prop <= culProp(y)
            break;
        end
    end
    %sampling without replacement, thus the # of samples must be smaller
    %than the # of negative intances
    if num_user_sample(index) > len_i - index_u(index)
        num_sample = num_sample + 1;
    end
    num_user_sample(index) = num_user_sample(index) + 1;
end
%# of sampled negative instances
count = 0;

neg_instances = len_i - index_u;
for x = 1:len
    sampleIndex = randperm(neg_instances(x),num_user_sample(x));
    sampleIndex = sort(sampleIndex);
    samLen = length(sampleIndex);
    nonZerosIndex = find(UIMatrix(x,:)~=0);
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
    
%     for y = 1:nonZerosLen
%         if sampleIndex(index) >= nonZerosIndex(y)
%             sampleIndex(1:1,index:samLen) = sampleIndex(1:1,index:samLen) + 1;
%             continue;
%         else
%             index = index + 1;
%             if index > samLen
%                 break;
%             end
%             y = y - 2;
%         end
%     end
    for y = 1:samLen
        UIMatrix(x,sampleIndex(y)) = -1;
    end
end

end

