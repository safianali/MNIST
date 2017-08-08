function [errors] = errors(predictions,correctoutput)

m=length(predictions);
##find number of predictions made, store in m

errors=0;
for i= 1:m
  if (predictions(i)!= correctoutput(i))
    errors=errors+1;
   ##if the 2 values differ, increment error by 1 
  end  
end
##repeat for the number of predictions made