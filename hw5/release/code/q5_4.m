for i=1:36
   data_set(:,:,2*i - 1) = data(:,:,1,50*i-49); 
   data_set(:,:,2*i    ) = data(:,:,1,50*i   );
end