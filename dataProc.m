function [UIMatrix] = dataProc(dir, filename, tsU, tsI)

file = fullfile(dir,filename);
fid = fopen(file);
M = textscan(fid,'%f,%f,%f,%f')
fclose(fid);

row_M = size(M{1})
row = max(M{1});
column = max(M{2});
UIMatrix = zeros(row, column);
count_r = zeros(1,row);
count_col = zeros(1,column);

for n = 1:row_M
    x = M{1}(n);
    y = M{2}(n);
    val = M{3}(n);
    UIMatrix(x,y) = val;
    count_r(x) = count_r(x) + 1;
    count_col(y) = count_col(y) + 1;
end

for x = 1:row
    if count_r(x) <= tsU
        UIMatrix(x,:) = 0;
    end
end

for y = 1:column
    if count_col(y) <= tsI
        UIMatrix(:,y) = 0;
    end
end

save(fullfile(dir,'matrix.mat'),'UIMatrix');
end

