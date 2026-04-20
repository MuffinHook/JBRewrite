return require(game:GetService("ReplicatedStorage").RoactRodux).connect(function(arg1, arg2) -- Line 5
    return {
        points = arg1.minimapPoints;
        circles = arg1.minimapCircles;
    }
end)(require(script.Parent.Minimap))