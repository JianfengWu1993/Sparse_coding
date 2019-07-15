function res=ShrinkageFunction(value, theta)
    res = 0;
    if value < -theta
        res = value + theta;
    elseif value > theta
        res = value - theta; 
    end
end