#open test set, 'r' signifies the testset is opened for reading, 'b' for big-endian
testset=fopen('t10k-images.idx3-ubyte','r','b');

#skip magic number
fread(testset,1,'uint32=>single');

#skip number of test images, declared in train
fread(testset,1,'uint32=>single');

#extract important values
numoftestrows=fread(testset,1,'uint32=>single');
numoftestcolumns=fread(testset,1,'uint32=>single');



#create cell array, each matrix (vector) will contain pixture as matrix of pixel values
testexample = cell(1, numoftestexamples);

#read each pixture into a matrix

for i=1: numoftestexamples
#read pixel values into corresponding vector, holding all pixel values for that picture
  currentexample=fread(testset,numoftestrows*numoftestcolumns,'uint8=>single');

  currentexample=reshape(currentexample,numoftestrows,numoftestcolumns)';
  
  testexample(i)=reshape(currentexample,numoftestrows*numoftestcolumns,1);
end


clear currentexample;

#close the file
fclose(testset);