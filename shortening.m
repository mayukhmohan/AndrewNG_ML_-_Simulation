a=imread('cameraman.tif');
[row,column]=size(a);
c=zeros(row/2,column/2);
i=1;j=1;
for x=1:2:row
    for y=1:2:column
        c(i,j)=a(x,y);
        j=j+1;
    end
    i=i+1;
    j=1;
end
figure,imshow(a);
figure,imshow(c/255);
figure,imagesc(c),colormap(gray);
