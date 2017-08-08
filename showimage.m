function [showimage] = showimage(image,example)
##debugging function
##shows image


switch nargin
  
  case 2
  ##if 2 arguments, assume that first argument is either trainingset or testset
  ##and 2nd is the image that the user desires to be shown
    
    image=image(:,example);
    ##gets the desired image vector
    
    image=reshape(image,28,28);
    ##reshape into matrix
    
    showimage=imshow(image, [0 255]);
    ##show image
  
  case 1
    ##if only 1 argument, assume that user want to show image from file

    image=imread(image);
    ##reads image file into matrix

    image=uint8(image);
    ##converts type to uint8, which is needed for functions below

    image=rgb2gray(image);
    ##orignally a PNG image is read as 3D image (a dimension each for Red, Blue, and Green values)
    ##converted into a 2 dimensional matrix

    showimage=imshow(image, [0 255]);
    ##show image
end