function predict(image,example)
##predicts most likely number and 2nd most likely prediction (and )

switch nargin
  
  case 2
  ##if 2 arguments, assume that first argument is either trainingset or testset
  ##and 2nd is the image that the user desires to be shown

    image=image(:,example);
    ##gets the desired image vector

    pixellength=sqrt(size(image,1));
    ##since images are stired in vector form, and assuming images have same number of column/rows, square rooting the length of the vector should return the number of pixels in a row/column

    vectorpixellength=size(image,1);
    ##calculates length of image when in vector form
    
    image=reshape(image,pixellength,pixellength);
    ##reshapes vector into image matrix

    imshow(image, [0 255]);
    ##shows image
  
  case 1
    image=imread(image);
    ##if only 1 argument, assume that user want to show image from file

    image=uint8(image);
    ##converts type to uint8, which is needed for functions below

    image=rgb2gray(image);
    ##orignally a PNG image is read as 3D image (a dimension each for Red, Blue, and Green values)
    ##converted into a 2 dimensional matrix
    
    pixellength=size(image,1);
    ##since images are stired in vector form, and assuming images have same number of column/rows, square rooting the length of the vector should return the number of pixels in a row/column

    vectorpixellength=(size(image,1))^2;
    ##calculates length of image when in vector form
    
    imshow(image, [0 255]);
    ##shows image
    
    image=reshape(image,vectorpixellength,1);
    ##reshapes image matrix into vector

    image=zoom(image);
    ##shows image
    
    image=reshape(image,pixellength,pixellength);
    ##reshapes image vector back to matrix
    
    disp('Press any key to see zoomed image');
    pause();
    ##while unzoomed image is shown, wait for user input to show zoomed image
    
    imshow(image, [0 255]);
    ##show image
    
    
end

image=reshape(image,vectorpixellength,1);
##reshape image matrix into vector

image=single(image);
##single type is the type that the rest of images are in, so the output of this function can be treated the sae as the images from the training set

global zeroparameters;
global oneparameters;
global twoparameters;
global threeparameters;
global fourparameters;
global fiveparameters;
global sixparameters;
global sevenparameters;
global eightparameters;
global nineparameters;
##imports global parameter vectors, should have been declared in train

zeroprobability=sigmoid(image'*zeroparameters);
oneprobability=sigmoid(image'*oneparameters);
twoprobability=sigmoid(image'*twoparameters);
threeprobability=sigmoid(image'*threeparameters);
fourprobability=sigmoid(image'*fourparameters);
fiveprobability=sigmoid(image'*fiveparameters);
sixprobability=sigmoid(image'*sixparameters);
sevenprobability=sigmoid(image'*sevenparameters);
eightprobability=sigmoid(image'*eightparameters);
nineprobability=sigmoid(image'*nineparameters);
##create probabilities for image being each number

vectorofprobabilities=[zeroprobability,oneprobability,twoprobability,threeprobability,fourprobability,fiveprobability,sixprobability,sevenprobability,eightprobability,nineprobability];
##store in vector

topprediction = createfinalpredictions(vectorofprobabilities(1),vectorofprobabilities(2),vectorofprobabilities(3),vectorofprobabilities(4),vectorofprobabilities(5),vectorofprobabilities(6),vectorofprobabilities(7),vectorofprobabilities(8),vectorofprobabilities(9),vectorofprobabilities(10));
##get most likely prediction and corresponding probability

disp('Top prediction');
disp(topprediction(1));
disp('Probability of top prediction');
disp(topprediction(2));
##display the top prediction and the corresponding probability

vectorofprobabilities((topprediction(1)+1))=0;
##set top prediction to 0 so second highest prediction can be found

secondprediction = createfinalpredictions(vectorofprobabilities(1),vectorofprobabilities(2),vectorofprobabilities(3),vectorofprobabilities(4),vectorofprobabilities(5),vectorofprobabilities(6),vectorofprobabilities(7),vectorofprobabilities(8),vectorofprobabilities(9),vectorofprobabilities(10));
##get second most likely prediction and corresponding probability

disp('Second prediction');
disp(secondprediction(1));
disp('Probability of second prediction');
disp(secondprediction(2));
##display the second most likely prediction and the corresponding probability