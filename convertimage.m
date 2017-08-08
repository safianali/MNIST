function [convertedimage] = convertimage(filename)
##debugging function
##converts image file into image vector that can be treated the same as the image vectors in the rest of the program

convertedimage=imread(filename);
##reads image file into matrix

convertedimage=uint8(convertedimage);
##converts type to uint8, which is needed for functions below

convertedimage=rgb2gray(convertedimage);
##orignally a PNG image is read as 3D image (a dimension each for Red, Blue, and Green values)
##converted into a 2 dimensional matrix

convertedimage=reshape(convertedimage,784,1);
##converts matrix into vector

convertedimage=single(convertedimage);
##type converted from uint8 to single
##single type is the type that the rest of images are in, so the output of this function can be treated the same as the images from the training set

