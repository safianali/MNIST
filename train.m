clear all;
##remove all variables
##just in case one has already been declared, could cause errors

numoftrainingexamples=30000;
numoftestexamples=0;
##user can choose number of training examples to extract from the training set to use for training
##the more examples used, the longer training will take, but the resultant accuracy of the parameters will be higher
##number of test examples to test on can also be chosen
##numoftestexamples has similar principle (can also be changed by the user)
##the more examples to test the model on, the more accurate the estimate of test set accuracy will be when estimating how well the model will do on examples it hasn't seen before


numofiterations=100;
##number of iterations that fminunc will run for
##the more iterations used, the longer training will take, but the resultant accuracy of the parameters will be higher

maxrotation=0;
##images in the training set will be rotated upto maxrotation degrees
##this is to add variance to the training set, so the model will make better predictions on rotated numbers
##also can be changed by the user


loadtrainingset;
loadtrainingsetlabels;
##loads training set and labels by calling the appropiate functions

#create parameter vector of zeros (initially) for each model
##needs to be global so they can be accessed by other functions
global zeroparameters=(((zeros(numoftrainingrows*numoftrainingcolumns,1))));
global oneparameters=(((zeros(numoftrainingrows*numoftrainingcolumns,1))));
global twoparameters=(((zeros(numoftrainingrows*numoftrainingcolumns,1))));
global threeparameters=(((zeros(numoftrainingrows*numoftrainingcolumns,1))));
global fourparameters=(((zeros(numoftrainingrows*numoftrainingcolumns,1))));
global fiveparameters=(((zeros(numoftrainingrows*numoftrainingcolumns,1))));
global sixparameters=(((zeros(numoftrainingrows*numoftrainingcolumns,1))));
global sevenparameters=(((zeros(numoftrainingrows*numoftrainingcolumns,1))));
global eightparameters=(((zeros(numoftrainingrows*numoftrainingcolumns,1))));
global nineparameters=(((zeros(numoftrainingrows*numoftrainingcolumns,1))));

trainingdata=cell2mat(trainingexample);
##convert trainingexample cell matrix into matrix, so matrix operations are possible

pkg load image;
##loads image package from source-forge (https://octave.sourceforge.io/image/index.html)
##necessary, as the image package has necessary functions like imcrop, imrotate, imresize

trainingdata=rotateandzoom(trainingdata,maxrotation);
##rotates training images by a maximum of maxrotation
##also zooms in on the images by removing the bordering empty space, improving accuracy


options = optimset('GradObj' ,'on', 'MaxIter', numofiterations);
##creates options variable, which holds the optimization options, which configures fminunc (the optimization function) (https://www.gnu.org/software/octave/doc/v4.0.0/Linear-Least-Squares.html#XREFoptimset)
##('GradObj' ,'on') tells fminunc to look for a 2nd argument in the function to be minimized, which it will use as the gradient 
##('MaxIter', numofiterations) sets the maximum number of iterations that the optimization function will go iterate for the value stored in 'maxiterations'

[zeroparameters] = fminunc(@(x)(costfunction(x,trainingdata,isitzero)), zeroparameters,options);
[oneparameters] = fminunc(@(x)(costfunction(x,trainingdata,isitone)), oneparameters,options);
[twoparameters] = fminunc(@(x)(costfunction(x,trainingdata,isittwo)), twoparameters,options);
[threeparameters] = fminunc(@(x)(costfunction(x,trainingdata,isitthree)), threeparameters,options);
[fourparameters] = fminunc(@(x)(costfunction(x,trainingdata,isitfour)), fourparameters,options);
[fiveparameters] = fminunc(@(x)(costfunction(x,trainingdata,isitfive)), fiveparameters,options);
[sixparameters] = fminunc(@(x)(costfunction(x,trainingdata,isitsix)), sixparameters,options);
[sevenparameters] = fminunc(@(x)(costfunction(x,trainingdata,isitseven)), sevenparameters,options);
[eightparameters] = fminunc(@(x)(costfunction(x,trainingdata,isiteight)), eightparameters,options);
[nineparameters] = fminunc(@(x)(costfunction(x,trainingdata,isitnine)), nineparameters,options);
##train parameters by using fminunc to find parameters that give the closest predictions to 'isit__' when applied to images in trainingdata
##@x signifies the 'x' in the cost function is to be minimized
##first argument is the function to be minimized, it's arguments are x, which is the parameter vector, the training images, and the isit__ vector
##as fminunc iterates, it gets parameters that when inputted into the hypothesis function with the training images, get predictions closest to isit__ vector
##second argument is the initial guess, which isn't important, unless numofiterations is low. Although they are all set to the corresponding parameter vector, there is no reason for this - it is completely arbitary
##third argument is the options configured above 

trainingpredictionszero=sigmoid(trainingdata'*zeroparameters);
trainingpredictionsone=sigmoid(trainingdata'*oneparameters);
trainingpredictionstwo=sigmoid(trainingdata'*twoparameters);
trainingpredictionsthree=sigmoid(trainingdata'*threeparameters);
trainingpredictionsfour=sigmoid(trainingdata'*fourparameters);
trainingpredictionsfive=sigmoid(trainingdata'*fiveparameters);
trainingpredictionssix=sigmoid(trainingdata'*sixparameters);
trainingpredictionsseven=sigmoid(trainingdata'*sevenparameters);
trainingpredictionseight=sigmoid(trainingdata'*eightparameters);
trainingpredictionsnine=sigmoid(trainingdata'*nineparameters);
##create prediction vectors
##e.g. trainingpredictionsone(500) will contain the probability of trainingimage(500) in the trainingset being a one


trainingpredictions=createfinalpredictions(trainingpredictionszero,trainingpredictionsone,trainingpredictionstwo,trainingpredictionsthree,trainingpredictionsfour,trainingpredictionsfive,trainingpredictionssix,trainingpredictionsseven,trainingpredictionseight,trainingpredictionsnine);
##finds the most certain prediction for each image, and stores it in trainingpredictions, with the corresponing probability in the next column
##e.g. trainingpredictions(500,1:2) (meaning both columns of the 500th row of trainingpredictions) may contain [1,0.93], meaning of each of the predictions for training image 500, 1 had the highest probability of all of them of 0.93.

trainingseterrors=errors(trainingpredictions,traininglabel);
##calculates number of errors in trainingpredictions by comparing it with traininglabel (which holds training label set)

trainingsetaccuracy=((numoftrainingexamples-trainingseterrors)/numoftrainingexamples);
##calculates accuarcy of training set predictions

disp('Accuracy rate on training set: ');
disp(trainingsetaccuracy);
##outputs training set accuracy

loadtestset;
loadtestsetlabels;
##loads test set and labels by calling the appropiate functions

testdata=cell2mat(testexample);
##convert testexample cell matrix into matrix, so matrix operations are possible

testdata=zoom(testdata);
## zooms in on the images by removing the bordering empty space, improving accuracy

testpredictionszero=sigmoid(testdata'*zeroparameters);
testpredictionsone=sigmoid(testdata'*oneparameters);
testpredictionstwo=sigmoid(testdata'*twoparameters);
testpredictionsthree=sigmoid(testdata'*threeparameters);
testpredictionsfour=sigmoid(testdata'*fourparameters);
testpredictionsfive=sigmoid(testdata'*fiveparameters);
testpredictionssix=sigmoid(testdata'*sixparameters);
testpredictionsseven=sigmoid(testdata'*sevenparameters);
testpredictionseight=sigmoid(testdata'*eightparameters);
testpredictionsnine=sigmoid(testdata'*nineparameters);
##create prediction vectors
##e.g. testpredictionsone(500) will contain the probability of testimage(500) in the testset being a one

testpredictions=createfinalpredictions(testpredictionszero,testpredictionsone,testpredictionstwo,testpredictionsthree,testpredictionsfour,testpredictionsfive,testpredictionssix,testpredictionsseven,testpredictionseight,testpredictionsnine);
##finds the most certain prediction for each image, and stores it in testpredictions, with the corresponing probability in the next column
##e.g. testpredictions(500,1:2) (meaning both columns of the 500th row of testpredictions) may contain [1,0.93], meaning of each of the predictions for training image 500, 1 had the highest probability of all of them of 0.93.

testseterrors=errors(testpredictions,testlabel);
##calculates number of errors in testpredictions by comparing it with testlabel (which holds test label set)

testsetaccuracy=((numoftestexamples-testseterrors)/numoftestexamples);
##calculate accuracy on test set

disp('Accuracy rate on test set: ');
disp(testsetaccuracy);
##output test set accuracy


