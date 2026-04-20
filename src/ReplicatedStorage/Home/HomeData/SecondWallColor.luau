local WallColor = require(script.Parent.WallColor)
local module = {}
local tbl_upvr = {
    DefaultReflectance = 0;
    DefaultMaterial = Enum.Material.SmoothPlastic;
    DisableReflectance = true;
}
module.getInstance = WallColor.getInstance
module.updateCamera = WallColor.updateCamera
module.getItems = WallColor.getItems
local Paint_upvr = require(game:GetService("ReplicatedStorage").Game.Garage.Paint)
function module.apply(arg1, arg2) -- Line 15
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local SecondWallColor = arg2:FindFirstChild("SecondWallColor")
    local var14
    if not SecondWallColor then
        var14 = warn
        var14("Missing subModel")
    else
        var14 = 0
        for _, v in SecondWallColor:GetChildren() do
            if v:IsA("BasePart") then
                var14 += 1
                if not arg1 or arg1.None then
                    v.Color = v:GetAttribute("OriginalColor")
                else
                    tbl_upvr.DefaultMaterial = v.Material
                    Paint_upvr.Part(v, arg1.Name, tbl_upvr)
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