cover = imread('cameraman.tif');
message = imread('pout.tif');
figure(1), imshow(cover); title('Original Image (Cover Image)');
figure(2), imshow(message);title('Image to Hide (Message Image)');
cover=double(cover);
message=double(message);
imbed = 2;
%imbed= 2 %or 4 or 8 

%shift the message image over (8-imbed) bits to right
messageshift=bitshift(message,-(8-imbed));
%show the message image with only embed bits on screen
%must shift from LSBs to MSBs
showmess=uint8(messageshift);
showmess=bitshift(showmess,8-imbed);
figure(3),imshow(showmess);title('embed Image to Hide ');
%now zero out imbed bits in cover image
coverzero = cover;
for i=1:imbed
coverzero=bitset(coverzero,i,0);
end
%now add message image and cover image
coverzero1=imresize(coverzero,[250,250]);
coverzero1=double(coverzero1);
stego = uint8(cover-messageshift);
figure(4),imshow(stego);title('Stego image');
%save files if need to
%4 bit file that was embedded = same as file extracted
imwrite(showmess,'showmess4.bmp'); %use bmp to preserve lower bits
%jpg will get rid of them
%stego file
imwrite(stego,'stego_op.bmp');