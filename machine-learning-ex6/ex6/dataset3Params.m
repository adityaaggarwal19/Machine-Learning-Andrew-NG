function [C, sigma] = dataset3Params(X, y, Xval, yval)
%DATASET3PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = DATASET3PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%

res = eye(64,3);
eRow = 0;

for test_C = [0.01 0.03 0.1 0.3 1, 3, 10 30]
  for test_sig = [0.01 0.03 0.1 0.3 1, 3, 10 30]
    eRow = eRow + 1;
    model = svmTrain(X, y, test_C, @(x1, x2) gaussianKernel(x1, x2, test_sig));
    pred = svmPredict(model, Xval);
    pred_err = mean(double(pred ~= yval));
    res(eRow,:) = [test_C, test_sig, pred_err];
  endfor
endfor
res_sort = sortrows(res, 3);
C = res_sort(1,1);
sigma = res_sort(1,2);



% =========================================================================

end
