%ps1.1 montage
a=imread('../data/baseball_field/sun_altvkyretoslcmfc.jpg');
[filterResponses] = extractFilterResponses(a, createFilterBank);
[W,H,D]=size(filterResponses);
pic=zeros(W,H,3,D/3);
for i=1:(D/3)
    pic(:,:,1:3,i)=filterResponses(:,:,(3*i-2):3*i);
end
montage(pic,'size',[4 5])