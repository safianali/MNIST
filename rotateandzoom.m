function [rotatedandzoomedimages] = rotateandzoom(image,degrees)

image=uint8(image);
##image functions only work on uint8 tyoe, so need to convert image(s)

numofimages=size(image,2);
##finds how many images are in the matrix

pixellength=sqrt(size(image,1));
##since images are stired in vector form, and assuming images have same number of column/rows, square rooting the length of the vector should return the number of pixels in a row/column

vectorpixellength=size(image,1);
##calculates length of image when in vector form

for i = 1:numofimages
  currentimage=image(:,i);
  currentimage=reshape(currentimage,pixellength,pixellength);
  ##obtain next image from matrix, and reshape from vector into matrix  
  
  xvalues=ceil((find(currentimage)/pixellength));
  ##obtains the x-values of the indices of non-zero values from the image matrix

  highx=max(xvalues);
  lowx=min(xvalues);
  width=highx-lowx;
  ##finds the highest and the lowest x-values i.e. the pixels in the image that are furthest to the sides
  ##and calculates the distance between them, storing this value in width
  
  yvalues=ceil(mod(find(currentimage),pixellength));
  ##obtains the y-values of the indices of non-zero values from the image matrix

  highy=max(yvalues)+1;
  lowy=min(yvalues)+1;
  height=(highy-lowy-1);
  ##finds the highest and the lowest y-values i.e. the pixels in the image that are furthest to the top/bottom
  ##and calculates the distance between them, storing this value in height
  
  
  currentimage=imcrop(currentimage, [lowx lowy width height]);
  ##crops image so only the actual number itself is included
  ##all of the zero values in the matrix that are outside the rows or columns non-zero values are on have been removed

  currentimage=imrotate(currentimage,randi([-degrees degrees]));
  ##rotates the image some integer upto degrees either clockwise or anti-clockwise

  currentimage=imresize(currentimage, [pixellength pixellength]);
  ##after cropping, image no longer has pixellength*pixellength deimensions, so this line reshapes it so it does 
 
  
  currentimage=reshape(currentimage,vectorpixellength,1);
  ##reshape image matrix into vector
  
  if (i==1)
    rotatedandzoomedimages=currentimage;
    ##if this is the first image, set it as zoomed images (the output)
  else
    rotatedandzoomedimages=horzcat(rotatedandzoomedimages,currentimage);
    ##if not, then combine it with the current output (zoomed images)
  end  
end
##repeat for each image

rotatedandzoomedimages=single(rotatedandzoomedimages);
##single type is the type that the rest of images are in, so the output of this function can be treated the sae as the images from the training set