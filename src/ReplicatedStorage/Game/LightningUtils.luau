local module = {}
local GeomUtils_upvr = require(game:GetService("ReplicatedStorage").Std.GeomUtils)
function module.strikePosition(arg1) -- Line 5
    local Origin = arg1.Origin
    local Model = Instance.new("Model")
    local var7 = arg1.NumSegments or 20
    local var8 = arg1.PartWidth or 1
    local var9
    if not var9 then
        var9 = Color3.fromRGB(130, 148, 223)
    end
    local var10 = Origin
    for i = 1, var7 do
        local var11 = i / var7
        local var12 = Origin * (1 - var11) + arg1.Target * var11
        if i < var7 then
            local var13 = GeomUtils_upvr.randomPointInCircle() * (arg1.OffsetRadius or 16)
            var12 += Vector3.new(var13.X, 0, var13.Y)
        end
        local Magnitude = (var12 - var10).Magnitude
        local Part = Instance.new("Part")
        Part.Anchored = true
        Part.CanCollide = false
        Part.CanTouch = false
        Part.CanQuery = false
        Part.Material = Enum.Material.Neon
        Part.Transparency = arg1.Transparency or 0.6
        Part.Color = var9
        Part.TopSurface = 0
        Part.BottomSurface = 0
        Part.Size = Vector3.new(var8, var8, Magnitude)
        Part.CFrame = CFrame.new(var10, var12) * CFrame.new(0, 0, -Magnitude * 0.5)
        Part.Parent = Model
    end
    Model.Parent = workspace
    return Model
end
return module