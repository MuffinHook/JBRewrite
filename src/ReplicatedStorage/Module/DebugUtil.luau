return {
    DrawPoint = function(arg1, arg2) -- Line 3, Named "DrawPoint"
        local var1 = arg2 or 0.5
        local Part_2 = Instance.new("Part")
        Part_2.Anchored = true
        Part_2.Size = Vector3.new(var1 * 2, var1 * 2, var1 * 2)
        Part_2.CFrame = CFrame.new(arg1)
        Part_2.Parent = workspace
        return Part_2
    end;
    DrawLine = function(arg1, arg2) -- Line 16, Named "DrawLine"
        local Magnitude = (arg2 - arg1).Magnitude
        local Part = Instance.new("Part")
        Part.Anchored = true
        Part.Size = Vector3.new(1, 1, Magnitude)
        Part.CFrame = CFrame.new(arg1, arg2) * CFrame.new(0, 0, -Magnitude * 0.5)
        Part.Parent = workspace
        return Part
    end;
}