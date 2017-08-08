#open test label set, 'r' signifies the testlabelset is opened for reading, 'b' for big-endian (data is in big-endian format)
testlabelset=fopen('t10k-labels.idx1-ubyte','r','b');

#skip magic number
fread(testlabelset,1,'uint32=>single');

#skip number of labels, declared in train (same as number of examples)
fread(testlabelset,1,'uint32=>single');



#create vector for storing labels
testlabel = (zeros(numoftestexamples,1));


#place each value from the file into the label vector
for i=1: numoftestexamples
  testlabel(i)=fread(testlabelset,1,'uint8=>single');
end

#close label file
fclose(testlabelset);