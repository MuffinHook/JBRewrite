return {
    getPlacementPrism = function(arg1, arg2) -- Line 3, Named "getPlacementPrism"
        return arg1 * CFrame.new(0, arg2.Y * 0.5 + 0.05 - 0.05, 0), Vector3.new(arg2.X, 0.2, arg2.Z)
    end;
    getStandingPrism = function(arg1, arg2) -- Line 11, Named "getStandingPrism"
        return arg1 * CFrame.new(0, arg2.Y * 0.5 + 7.5 - 0.05, 0), Vector3.new(arg2.X, 15.1, arg2.Z)
    end;
}