function [finalpredictions] = createfinalpredictions(probzero,probone,probtwo,probthree,probfour,probfive,probsix,probseven,probeight,probnine)
##finds the most likely prediction for each image

m=length(probzero);
##finds number of images

finalpredictions=zeros(m,2);
##creates matrix that will be outputted, currently empty

matrixofprobabilities=zeros(10,1);
##creates matrix that will hold the probabilies for an image being each number

for i=1: m
  
  matrixofprobabilities=[probzero(i);probone(i);probtwo(i);probthree(i);probfour(i);probfive(i);probsix(i);probseven(i);probeight(i);probnine(i)];
  ##get probabilities for ith image
  
  [probofprediction,prediction] = max(matrixofprobabilities);
  ##most likely prediction stored in 'prediction', the corresponing probability is stored in 'probofprediction'
  
  finalpredictions(i,1)=prediction-1;
  ##store the prediction for the ith image in the first column of the ith row of finalpredictions (the output)
  ##need to subtract 1 since arrays are one-indexed in Octave
  
  finalpredictions(i,2)=probofprediction;
  ##store the corresponding probability for the ith image in the second column of the ith row of finalpredictions (the output)
  
  
  
end

##repeat for each image
  
