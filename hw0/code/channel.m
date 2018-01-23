function picture = channel(blue,green)
column = size(blue,2);
row = size(blue,1);
picture1 = zeros(row,column);
distance0 = 9999999999;
for i = 1:1:30
    for j = 1:1:30
        picture1(1:row-i,1:column-j) = blue(i+1:row,j+1:column);
        distance1 = sum(diag((picture1 - green)*(picture1 - green)'));
        if(distance1 < distance0)
            distance0 = distance1;
            picture = picture1 + green;
        end 
        picture1(1:row-i,j+1:column) = blue(i+1:row,1:column-j);
        distance1 = sum(diag((picture1 - green)*(picture1 - green)'));
        if(distance1 < distance0)
            distance0 = distance1;
            picture = picture1 + green;
        end 
        picture1(i+1:row,1:column-j) = blue(1:row-i,j+1:column);
        distance1 = sum(diag((picture1 - green)*(picture1 - green)'));
        if(distance1 < distance0)
            distance0 = distance1;
            picture = picture1 + green;
        end 
        picture1(i+1:row,j+1:column) = blue(1:row-i,1:column-j);
        distance1 = sum(diag((picture1 - green)*(picture1 - green)'));
        if(distance1 < distance0)
            distance0 = distance1;
            picture = picture1 + green;
        end 
    end
end
end
