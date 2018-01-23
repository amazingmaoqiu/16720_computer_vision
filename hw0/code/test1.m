function picture = test1(a,b)
distance0 = 9999999999;
for i = 1:1:30
    for j = 1:1:30
        picture1(1:row-i,1:column-j) = b(i+1:row,j+1:column);
        distance1 = sum(diag((picture1 - a)*(picture1 - a)'));
        if(distance1 < distance0)
            distance0 = distance1;
            picture = picture1 + a;
        end 
        picture1(1:row-i,j+1:column) = b(i+1:row,1:column-j);
        distance1 = sum(diag((picture1 - a)*(picture1 - a)'));
        if(distance1 < distance0)
            distance0 = distance1;
            picture = picture1 + a;
        end 
        picture1(i+1:row,1:column-j) = b(1:row-i,j+1:column);
        distance1 = sum(diag((picture1 - a)*(picture1 - a)'));
        if(distance1 < distance0)
            distance0 = distance1;
            picture = picture1 + a;
        end 
        picture1(i+1:row,j+1:column) = b(1:row-i,1:column-j);
        distance1 = sum(diag((picture1 - a)*(picture1 - a)'));
        if(distance1 < distance0)
            distance0 = distance1;
            picture = picture1 + a;
        end 
    end
end

end








