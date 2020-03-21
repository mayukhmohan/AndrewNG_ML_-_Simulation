a=imread('cameraman.tif');
d=im2double(a);
x=d;
[row,col]=size(d);
f=2;
for i=1:row
    for j=1:col
        x(i,j)=f*log(1+d(i,j));
    end
end
subplot(1,2,1);imshow(x);
subplot(1,2,2);imshow(d);