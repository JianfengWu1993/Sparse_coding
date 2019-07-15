function [Wd] = GenerateRandomPatchDictionary(featureDim, sampleDim, sampleNum, sample)
    Wd = zeros(sampleDim, featureDim);
    for i = 1:featureDim
        index = randi([1, sampleNum]);
        Wd(:,i) = sample(:,index);
    end

end