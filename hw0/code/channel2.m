function picture = channel2(x,y)     % NCC(Normalized Cross Correlation)
column = size(x,2);
row = size(x,1);
picture1 = zeros(row,column);
distance0 = 0;
for i = 1:1:30
    for j = 1:1:30
        picture1(1:row-i,1:column-j) = x(i+1:row,j+1:column);
        % distance1 = sum(diag((picture1 - green)*(picture1 - green)'));
        distance1 = sum((picture1.*y),2);
        dis1 = sum(picture1.*picture1,2).^0.5;
        dis2 = sum(y.*y,2).^0.5;
        distance1 = sum(distance1./dis1./dis2,1);
        if(distance1 > distance0)
            distance0 = distance1;
            picture = picture1;
        end 
        picture1(1:row-i,j+1:column) = x(i+1:row,1:column-j);
        % distance1 = sum(diag((picture1 - green)*(picture1 - green)'));
        distance1 = sum((picture1.*y),2);
        dis1 = sum(picture1.*picture1,2).^0.5;
        dis2 = sum(y.*y,2).^0.5;
        distance1 = sum(distance1./dis1./dis2,1);
        if(distance1 > distance0)
            distance0 = distance1;
            picture = picture1;
        end 
        picture1(i+1:row,1:column-j) = x(1:row-i,j+1:column);
        % distance1 = sum(diag((picture1 - green)*(picture1 - green)'));
        distance1 = sum((picture1.*y),2);
        dis1 = sum(picture1.*picture1,2).^0.5;
        dis2 = sum(y.*y,2).^0.5;
        distance1 = sum(distance1./dis1./dis2,1);
        if(distance1 > distance0)
            distance0 = distance1;
            picture = picture1;
        end 
        picture1(i+1:row,j+1:column) = x(1:row-i,1:column-j);
        % distance1 = sum(diag((picture1 - green)*(picture1 - green)'));
        distance1 = sum((picture1.*y),2);
        dis1 = sum(picture1.*picture1,2).^0.5;
        dis2 = sum(y.*y,2).^0.5;
        distance1 = sum(distance1./dis1./dis2,1);
        if(distance1 > distance0)
            distance0 = distance1;
            picture = picture1;
        end 
    end
end
end
