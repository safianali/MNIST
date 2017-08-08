#open training set, 'r' signifies the trainingset is opened for reading, 'b' for big-endian
trainingset=fopen('trainingset.idx3-ubyte','r','b');

#skip magic number
fread(trainingset,1,'uint32=>single');

#extract important values

fread(trainingset,1,'uint32=>single');
##skip number of images, declared in train

numoftrainingrows=fread(trainingset,1,'uint32=>single');
numoftrainingcolumns=fread(trainingset,1,'uint32=>single');



#create cell array, each matrix (vector) will contain pixture as matrix of pixel values
trainingexample = cell(1, numoftrainingexamples);

#read each pixture into a matrix

for i=1: numoftrainingexamples
#read pixel values into corresponding vector, holding all pixel values for that picture
  currentexample=fread(trainingset,numoftrainingrows*numoftrainingcolumns,'uint8=>single');

  currentexample=reshape(currentexample,numoftrainingrows,numoftrainingcolumns)';
  
  trainingexample(i)=reshape(currentexample,numoftrainingrows*numoftrainingcolumns,1);
end




clear currentexample;

#close the file
fclose(trainingset);

