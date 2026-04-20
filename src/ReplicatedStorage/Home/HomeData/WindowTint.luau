local module = {
    getInstance = function(arg1) -- Line 5, Named "getInstance"
        local Part = Instance.new("Part")
        Part.Shape = Enum.PartType.Ball
        Part.Size = Vector3.new(4, 4, 4)
        Part.TopSurface = 0
        Part.BottomSurface = 0
        Part.Color = Color3.new(arg1.Value, arg1.Value, arg1.Value)
        Part.Anchored = true
        Part.CFrame = CFrame.new()
        return Part
    end;
    updateCamera = function(arg1, arg2) -- Line 16, Named "updateCamera"
        local var3 = os.clock() / 2
        arg1.CFrame = CFrame.Angles(0, var3 % (-math.pi*2), 0) * CFrame.Angles(math.sin(var3) * 0.25 - 0.3, 0, 0) * CFrame.new(0, 0, 8)
    end;
}
local WindowTint_upvr = require(game:GetService("ReplicatedStorage").Game.Garage.StoreData.WindowTint)
function module.getItems() -- Line 22
    return WindowTint_upvr.Items
end
function module.apply(arg1, arg2) -- Line 25
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local Windows = arg2:FindFirstChild("Windows")
    local var14
    if not Windows then
        var14 = warn
        var14("Missing subModel")
    else
        var14 = 0
        for _, v in Windows:GetChildren() do
            if v:IsA("BasePart") then
                var14 += 1
                if not arg1 or arg1.None then
                    v.Transparency = v:GetAttribute("OriginalTransparency")
                else
                    v.Transparency = arg1.Value
                end
            end
        end
        if 0 >= var14 then
        else
        end
        assert(true, "No parts to apply to")
    end
end
return module