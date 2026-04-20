local Paint_upvr = require(game:GetService("ReplicatedStorage").Game.Garage.Paint)
return {
    Items = require(script.Parent.Color).Items;
    GetInstance = function(arg1) -- Line 5, Named "GetInstance"
        local Part = Instance.new("Part")
        Part.Shape = Enum.PartType.Ball
        Part.Size = Vector3.new(4, 4, 4)
        Part.TopSurface = 0
        Part.BottomSurface = 0
        Part.Color = Paint_upvr.GetColor(arg1.Name)
        Part.Anchored = true
        Part.CFrame = CFrame.new()
        return Part
    end;
    Update = function(arg1, arg2) -- Line 16, Named "Update"
        local var3 = os.clock() / 2
        arg1.CFrame = CFrame.Angles(0, var3 % (-math.pi*2), 0) * CFrame.Angles(math.sin(var3) * 0.25 - 0.3, 0, 0) * CFrame.new(0, 0, 8)
    end;
}