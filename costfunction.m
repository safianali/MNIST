function [cost,grad] = costfunction(parameters, input, output)
##calculates the cost function and the gradient of a function and an input

cost=0;
m=length(input);
##calculates

prediction=sigmoid(input'*parameters);
##creates predictions (h_θ (x)) using input and parameters
  

cost=(-1/m)*((output'*log(prediction))+((1-output)'*log(1-prediction)));
##calculate cost using ‘(-1/m)*((y'*h_θ (x))+((1-y)'*log(1-h_θ (x))))’ formula

grad=(1/m)*input*(prediction-output);
##calculate gradient of cost function using ‘(1/m)*x*(h_θ (x)-y)’ formula