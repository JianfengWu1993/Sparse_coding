function Wd = UpdateWd(Wd, residuals, feature_row, A, nonZeroIndex_row, SampleDim)
    for i = 1:SampleDim
        Wd(i, nonZeroIndex_row) = Wd(i, nonZeroIndex_row) - residuals(i) * feature_row(nonZeroIndex_row) .* (1 ./ A(nonZeroIndex_row));
    end
end