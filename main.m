clc;
clear;
src = imread('D:\lena256rgb.png');
[r,c]=size(src);
a=size(src);
dimension=numel(a);
%灰度图像处理(9至50行)
if dimension==2
disp('灰度图像');
subplot(1,3,1);
imshow(src);
imwrite(src,'D:\GrayImage.png','png');
axis square;
title('原始图像');

thr=10;  %指定阈值

%一级小波变换
[ca1,ch1,cv1,cd1]=dwt2(src,'haar');
res0=idwt2(ca1,ch1,cv1,cd1,'haar');  %直接重构的无损对照组
subplot(1,3,2);
imshow(uint8(res0))  %等价于imshow(res0/255)，double类型在使用imshow时被认为在[0,1]内
title ('无损重构(对照组)');
%对一级变换的低频信息进行二级变换
[ca2,ch2,cv2,cd2]=dwt2(ca1,'haar');
%对二级变换的低频信息进行三级变换
[ca3,ch3,cv3,cd3]=dwt2(ca2,'haar');

%三级小波阈值处理
disp('三级小波阈值处理置零个数：');
[ch3,cv3,cd3]=threshold(ch3,cv3,cd3,thr,r/8,c/8);
%重构三级
res3=idwt2(ca3,ch3,cv3,cd3,'haar');

%二级小波阈值处理
disp('二级小波阈值处理置零个数：');
[ch2,cv2,cd2]=threshold(ch2,cv2,cd2,thr,r/4,c/4);
%重构二级
res2=idwt2(res3,ch2,cv2,cd2,'haar');

%一级小波阈值处理
disp('一级小波阈值处理置零个数：');
[ch1,cv1,cd1]=threshold(ch1,cv1,cd1,thr,r/2,c/2);
%重构一级
res1=idwt2(res2,ch1,cv1,cd1,'haar');

subplot(1,3,3);
imshow(uint8(res1));
imwrite(uint8(res1),'D:\CompressedGrayImage(10).png','png');
title ('三级变换阈值处理后重构');
end

%真彩色图像处理
if dimension==3
disp('彩色图像');
subplot(1,2,1);
imshow(src);title('原始图像');
imwrite(src,'D:\RGBImage.png','png');  %png压缩参考大小
imageR = src(:,:,1);
imageG = src(:,:,2);
imageB = src(:,:,3);
thr=10;  %指定阈值

%/****************\%
 %  R分量矩阵变换  %
%\****************/%
%一级变换
[ca1,ch1,cv1,cd1]=dwt2(imageR,'haar');
%二级变换
[ca2,ch2,cv2,cd2]=dwt2(ca1,'haar');
%三级变换
[ca3,ch3,cv3,cd3]=dwt2(ca2,'haar');

%三级小波阈值处理
disp('R分量三级小波阈值处理置零个数：');
[ch3,cv3,cd3]=threshold(ch3,cv3,cd3,thr,r/8,c/24);
%重构三级
res3=idwt2(ca3,ch3,cv3,cd3,'haar');
%二级小波阈值处理
disp('R分量二级小波阈值处理置零个数：');
[ch2,cv2,cd2]=threshold(ch2,cv2,cd2,thr,r/4,c/12);
%重构二级
res2=idwt2(res3,ch2,cv2,cd2,'haar');
%一级小波阈值处理
disp('R分量一级小波阈值处理置零个数：');
[ch1,cv1,cd1]=threshold(ch1,cv1,cd1,thr,r/2,c/6);
%重构一级
resR=idwt2(res2,ch1,cv1,cd1,'haar');


%/****************\%
 %  G分量矩阵变换  %
%\****************/%
%一级变换
[ca1,ch1,cv1,cd1]=dwt2(imageG,'haar');
%二级变换
[ca2,ch2,cv2,cd2]=dwt2(ca1,'haar');
%三级变换
[ca3,ch3,cv3,cd3]=dwt2(ca2,'haar');

%三级小波阈值处理
disp('G分量三级小波阈值处理置零个数：');
[ch3,cv3,cd3]=threshold(ch3,cv3,cd3,thr,r/8,c/24);
%重构三级
res3=idwt2(ca3,ch3,cv3,cd3,'haar');
%二级小波阈值处理
disp('G分量二级小波阈值处理置零个数：');
[ch2,cv2,cd2]=threshold(ch2,cv2,cd2,thr,r/4,c/12);
%重构二级
res2=idwt2(res3,ch2,cv2,cd2,'haar');
%一级小波阈值处理
disp('G分量一级小波阈值处理置零个数：');
[ch1,cv1,cd1]=threshold(ch1,cv1,cd1,thr,r/2,c/6);
%重构一级
resG=idwt2(res2,ch1,cv1,cd1,'haar');


%/****************\%
 %  B分量矩阵变换  %
%\****************/%
%一级变换
[ca1,ch1,cv1,cd1]=dwt2(imageB,'haar');
%二级变换
[ca2,ch2,cv2,cd2]=dwt2(ca1,'haar');
%三级变换
[ca3,ch3,cv3,cd3]=dwt2(ca2,'haar');

%三级小波阈值处理
disp('B分量三级小波阈值处理置零个数：');
[ch3,cv3,cd3]=threshold(ch3,cv3,cd3,thr,r/8,c/24);
%重构三级
res3=idwt2(ca3,ch3,cv3,cd3,'haar');
%二级小波阈值处理
disp('B分量二级小波阈值处理置零个数：');
[ch2,cv2,cd2]=threshold(ch2,cv2,cd2,thr,r/4,c/12);
%重构二级
res2=idwt2(res3,ch2,cv2,cd2,'haar');
%一级小波阈值处理
disp('B分量一级小波阈值处理置零个数：');
[ch1,cv1,cd1]=threshold(ch1,cv1,cd1,thr,r/2,c/6);
%重构一级
resB=idwt2(res2,ch1,cv1,cd1,'haar');

image_RGB(:,:,1)=uint8(resR);
image_RGB(:,:,2)=uint8(resG);
image_RGB(:,:,3)=uint8(resB);
imwrite(image_RGB,'D:\CompressedRGBImage(10).png','png');
subplot(1,2,2);
imshow(image_RGB);title('阈值处理三级重构图像');
end 
