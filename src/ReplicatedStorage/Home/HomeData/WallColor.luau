local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Paint_upvr = require(ReplicatedStorage.Game.Garage.Paint)
local module = {}
local tbl_upvr = {
    DefaultReflectance = 0;
    DefaultMaterial = Enum.Material.SmoothPlastic;
    DisableReflectance = true;
}
function module.getInstance(arg1) -- Line 12
    local Part = Instance.new("Part")
    Part.Shape = Enum.PartType.Ball
    Part.Size = Vector3.new(4, 4, 4)
    Part.TopSurface = 0
    Part.BottomSurface = 0
    if arg1.None then
        Part.Color = Color3.new(1, 1, 1)
    else
        Part.Color = Paint_upvr.GetColor(arg1.Name)
    end
    Part.Anchored = true
    Part.CFrame = CFrame.new()
    return Part
end
function module.updateCamera(arg1, arg2) -- Line 27
    local var6 = os.clock() / 2
    arg1.CFrame = CFrame.Angles(0, var6 % (-math.pi*2), 0) * CFrame.Angles(math.sin(var6) * 0.25 - 0.3, 0, 0) * CFrame.new(0, 0, 8)
end
local clone_upvr = table.clone(require(ReplicatedStorage.Game.Garage.StoreData.Color).Items)
table.insert(clone_upvr, 1, {
    Name = "Default";
    None = true;
})
function module.getItems() -- Line 38
    return clone_upvr
end
function module.apply(arg1, arg2) -- Line 41
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local WallColor = arg2:FindFirstChild("WallColor")
    local var18
    if not WallColor then
        var18 = warn
        var18("Missing subModel")
    else
        var18 = 0
        for _, v in WallColor:GetChildren() do
            if v:IsA("BasePart") then
                var18 += 1
                if not arg1 or arg1.None then
                    v.Color = v:GetAttribute("OriginalColor")
                else
                    tbl_upvr.DefaultMaterial = v.Material
                    Paint_upvr.Part(v, arg1.Name, tbl_upvr)
                end
            end
        end
        if 0 >= var18 then
        else
        end
        assert(true, "No parts to apply to")
    end
end
return module