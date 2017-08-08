function [sigmoid] = sigmoid(input)

sigmoid = 1./(1+e.^(-input));

##hypothesis function
##calculate h_θ (x)=1/(1+e^(-θ^T x ) )
##used to obtain probabilities using a parameter vector and images(converted into vectors)
##code is more readable if hypothesis function is declared elsewhere, instead of repeating this line of code all time
##’.’ Represents by product operations, which is needed since input will be matrices


