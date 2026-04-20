local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local module = {
    getUpdateCamera = function() -- Line 6, Named "getUpdateCamera"
        local var4_upvw
        local var5_upvw
        return function(arg1, arg2) -- Line 9
            if not arg2 then
            else
                if arg2 ~= var4_upvw then
                    local any_GetBoundingBox_result1, any_GetBoundingBox_result2 = arg2:GetBoundingBox()
                    _ = any_GetBoundingBox_result1 -- Setting global
                    var5_upvw = any_GetBoundingBox_result2
                    var4_upvw = arg2
                end
                local os_clock_result1 = os.clock()
                arg1.CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(0, os_clock_result1 % (-math.pi*2), 0) * CFrame.Angles(math.sin(os_clock_result1 * 0.5) * 0.3 - 0.4, 0, 0) * CFrame.new(0, 0, var5_upvw.Magnitude * 0.8)
            end
        end
    end;
}
local ItemSkinIds_upvr = require(ReplicatedStorage_upvr.Game.ItemSkin.ItemSkinIds)
function module.getModel(arg1, arg2) -- Line 26
    local var26 = arg2 or "RocketLauncher"
    assert(var26)
    local clone = ReplicatedStorage_upvr.Resource.ItemSystem.Models:FindFirstChild(var26):Clone()
    clone.PrimaryPart = clone:FindFirstChild("Skeleton"):FindFirstChild("BoundingBox")
    clone:SetPrimaryPartCFrame(clone.PrimaryPart.CFrame:ToObjectSpace(clone:GetBoundingBox()):Inverse())
    local var28
    if arg1 ~= "None" then
        local var29 = ItemSkinIds_upvr[arg1]
        if not var29 then
            error("No skin by name of %s exists.":format(arg1))
        end
        var28 = var29[var26]
        if not var28 then
            error("Skin %s has no image id for item: %s":format(arg1, var26))
        end
    end
    for _, v in clone:GetDescendants() do
        if v:IsA("MeshPart") then
            local ApplyGunTexture = v:GetAttribute("ApplyGunTexture")
            if ApplyGunTexture == true then
                if var28 then
                    ApplyGunTexture = "rbxassetid://%d":format(var28)
                else
                    ApplyGunTexture = ""
                end
                v.TextureID = ApplyGunTexture
            end
        end
    end
    return clone
end
return module