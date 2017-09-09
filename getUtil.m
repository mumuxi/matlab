function [index_r, index_col, UIMatrix] = getUtil(mat)

row = max(mat(:,1));
column = max(mat(:,2));
UIMatrix = zeros(row,column);
for n = 1:size(mat,1)
    x = mat(n,1);
    y = mat(n,2);
    UIMatrix(x,y) = mat(n,3);
end
index_r = zeros(1,row);
index_col = zeros(1,column);
% for x = 1:row
%     for y = 1:column
%         if UIMatrix(x,y) > 0
%             index_r(x) = index_r(x) + 1;
%             index_col(y) = index_col(y) + 1;
%         end
%     end
% end
%another choice:
for x = 1:row
    index_r(x) = column - size(find(UIMatrix(x,:)==0),2);
end
for y = 1:column
    index_col(y) = row - size(find(UIMatrix(:,y)==0),1);
end
end

