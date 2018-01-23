function [ F ] = sevenpoint( pts1, pts2, M )
% sevenpoint:
%   pts1 - 7x2 matrix of (x,y) coordinates
%   pts2 - 7x2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.2:
%     Implement the eightpoint algorithm
%     Generate a matrix F from some '../data/some_corresp.mat'
%     Save recovered F (either 1 or 3 in cell), M, pts1, pts2 to q2_2.mat

%     Write recovered F and display the output of displayEpipolarF in your writeup
pts1 = pts1/M;
pts2 = pts2/M;
pts11 = [pts1,ones(size(pts1,1),1)];
pts22 = [pts2,ones(size(pts2,1),1)];
T = diag([1.0/M,1.0/M,1.0]);
A =[pts22(:,1).*pts11(:,1),pts22(:,1).*pts11(:,2),pts22(:,1),pts22(:,2).*pts11(:,1), ...
    pts22(:,2).*pts11(:,2),pts22(:,2),pts11(:,1),pts11(:,2),ones(size(pts11,1),1)];
[~,~,V] = svd(A);
F1 = reshape(V(:,8),[3,3])';
F2 = reshape(V(:,9),[3,3])';

syms h;
y=det(F1+h*F2);
lamda=double(solve(y));

lamda = real(lamda);

if(lamda(1) == lamda(2))
    F = cell(1);
    F{1} = refineF(F1 + lamda(3)*F2,pts11(:,1:2),pts22(:,1:2));
    F{1} = T'*F{1}*T;
else
    if(lamda(3) == lamda(2))
    F = cell(1);
    F{1} = refineF(F1 + lamda(1)*F2,pts11(:,1:2),pts22(:,1:2));
    F{1} = T'*F{1}*T;
else
    F = cell([3,1]);
    F{1} = refineF(F1 + lamda(1)*F2,pts11(:,1:2),pts22(:,1:2));
    F{1} = T'*F{1}*T;
    F{2} = refineF(F1 + lamda(2)*F2,pts11(:,1:2),pts22(:,1:2));
    F{2} = T'*F{2}*T;
    F{3} = refineF(F1 + lamda(3)*F2,pts11(:,1:2),pts22(:,1:2));
    F{3} = T'*F{3}*T;
    end
end
end

