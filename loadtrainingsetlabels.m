#open training label set, 'r' signifies the traininglabelset is opened for reading, 'b' for big-endian (data is in big-endian format)
traininglabelset=fopen('train-labels.idx1-ubyte','r','b');

#skip magic number
fread(traininglabelset,1,'uint32=>single');

#skip number of labels, instead declared in train (same as num of examples)
fread(traininglabelset,1,'uint32=>single');



#create vector for storing labels
traininglabel = (zeros(numoftrainingexamples,1));


#place each value from the file into the label vector
for i=1: numoftrainingexamples
  traininglabel(i)=fread(traininglabelset,1,'uint8=>single');
end

isitzero=(zeros(numoftrainingexamples,1));
isitone=(zeros(numoftrainingexamples,1));
isittwo=(zeros(numoftrainingexamples,1));
isitthree=(zeros(numoftrainingexamples,1));
isitfour=(zeros(numoftrainingexamples,1));
isitfive=(zeros(numoftrainingexamples,1));
isitsix=(zeros(numoftrainingexamples,1));
isitseven=(zeros(numoftrainingexamples,1));
isiteight=(zeros(numoftrainingexamples,1));
isitnine=(zeros(numoftrainingexamples,1));
##create 10 label sets, 1 for each number
##to start, they all contain just zeros


for i=1: numoftrainingexamples

  if (traininglabel(i)==0)
    isitzero(i,1)=1;
  elseif (traininglabel(i)==1)
    isitone(i,1)=1;
  elseif (traininglabel(i)==2)
    isittwo(i,1)=1;
  elseif (traininglabel(i)==3)
    isitthree(i,1)=1;
  elseif (traininglabel(i)==4)
    isitfour(i,1)=1;
  elseif (traininglabel(i)==5)
    isitfive(i,1)=1;
  elseif (traininglabel(i)==6)
    isitsix(i,1)=1;
  elseif (traininglabel(i)==7)
    isitseven(i,1)=1;
  elseif (traininglabel(i)==8)
    isiteight(i,1)=1;
  elseif (traininglabel(i)==9)
    isitnine(i,1)=1;  
  endif
    
end


##each label set now says whether a particular training example is that number or not
##e.g. isiteight will store a label as 1 if the corresponding training example is an 8, but if the example is any other number, then the vector will store a 0 instead




#close label file
fclose(traininglabelset);