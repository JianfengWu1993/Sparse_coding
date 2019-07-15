clear;
clc;
sample = dlmread('Input.txt');

epochNum = 10;
sampleDim = 128;
sampleNum = length(sample);
featureDim = 1000; %The dimension of dictionary.
lambda = 0.13;
layers = 3;

iterNum = epochNum * sampleNum;

sample = normalize(sample-mean(sample), 'norm');

Wd = GenerateRandomPatchDictionary(featureDim, sampleDim, sampleNum, sample);
%%
Wd = dlmread('RandomPatchDictionary.txt');%Delete this after coding
Wd = normalize(Wd, 'norm');
feature = zeros(sampleNum, featureDim);
nonZeroIndex = logical(feature);
residuals = zeros(sampleDim, 1);
%%
A = zeros(1, featureDim);
A_copy = zeros(1, featureDim);

for i = 0:iterNum
    index = mod(i, sampleNum) + 1;
    if index == 1
        A = A_copy;
        A_copy = zeros(featureDim, 1);
    end
    [nonZeroIndex(index,:), feature(index,:)] = UpdateFeature(Wd, sample(:,index),residuals, feature(index,:), nonZeroIndex(index,:), lambda, layers, featureDim, sampleDim);

    A = feature(index,:) .* feature(index,:);
    A_copy = A;

    Wd = UpdateWd(Wd, residuals, feature(index,:), A, nonZeroIndex(index,:), sampleDim);
    Wd = normalize(Wd, 'norm');
end

