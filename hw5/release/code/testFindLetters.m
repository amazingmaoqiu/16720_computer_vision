% Your code here.
img1 = imread('../images/01_list.jpg');
figure(1);
[lines1, bw1] = findLetters(img1);

img2 = imread('../images/02_letters.jpg');
figure(2);
[lines2, bw2] = findLetters(img2);

img3 = imread('../images/03_haiku.jpg');
figure(3);
[lines3, bw3] = findLetters(img3);

img4 = imread('../images/04_deep.jpg');
figure(4);
[lines4, bw4] = findLetters(img4);