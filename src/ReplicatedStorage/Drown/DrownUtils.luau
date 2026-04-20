local Players_upvr = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DrownConsts_upvr = require(ReplicatedStorage.Drown.DrownConsts)
local module = {
    setDrownPercent = function(arg1, arg2) -- Line 7, Named "setDrownPercent"
        local var5
        if var5 then
            if arg1.Parent ~= Players_upvr then
                var5 = false
            else
                var5 = true
            end
        end
        assert(var5, "Invalid player")
        if type(arg2) ~= "number" then
            var5 = false
        else
            var5 = true
        end
        assert(var5, "Invalid value")
        arg1:SetAttribute(DrownConsts_upvr.DROWN_PERCENT_ATTR_NAME, arg2)
    end;
    getDrownPercent = function(arg1) -- Line 12, Named "getDrownPercent"
        local var6 = arg1
        if var6 then
            if arg1.Parent ~= Players_upvr then
                var6 = false
            else
                var6 = true
            end
        end
        assert(var6, "Invalid player")
        return arg1:GetAttribute(DrownConsts_upvr.DROWN_PERCENT_ATTR_NAME)
    end;
    getDrownPercentChangedSignal = function(arg1) -- Line 16, Named "getDrownPercentChangedSignal"
        local var7 = arg1
        if var7 then
            if arg1.Parent ~= Players_upvr then
                var7 = false
            else
                var7 = true
            end
        end
        assert(var7, "Invalid player")
        return arg1:GetAttributeChangedSignal(DrownConsts_upvr.DROWN_PERCENT_ATTR_NAME)
    end;
}
local Raycast_upvr = require(ReplicatedStorage.Std.Raycast)
function module.getIsPlayerDrowning(arg1) -- Line 20
    local Character = arg1.Character
    if not Character then
        return false
    end
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
    if not HumanoidRootPart then
        return false
    end
    local Head = Character:FindFirstChild("Head")
    if not Head then
        return false
    end
    if 180 < HumanoidRootPart.Position.Y then
        return false
    end
    debug.profilebegin("getIsPlayingDrowning ReadVoxels")
    local any_ReadVoxels_result1_upvr = workspace.Terrain:ReadVoxels(Region3.new(Head.CFrame.Position - Vector3.new(2, 2, 2), Head.CFrame.Position + Vector3.new(2, 2, 2)):ExpandToGrid(4), 4)
    debug.profileend()
    local Size_upvr = any_ReadVoxels_result1_upvr.Size
    if (function() -- Line 47, Named "doesWaterVoxelExist"
        for i = 1, Size_upvr.X do
            for i_2 = 1, Size_upvr.Y do
                for i_3 = 1, Size_upvr.Z do
                    if any_ReadVoxels_result1_upvr[i][i_2][i_3] == Enum.Material.Water then
                        return true
                    end
                end
            end
        end
        return false
    end)() then
        local RaycastParams_new_result1 = RaycastParams.new()
        RaycastParams_new_result1.IgnoreWater = false
        RaycastParams_new_result1.FilterDescendantsInstances = {workspace.Terrain}
        RaycastParams_new_result1.FilterType = Enum.RaycastFilterType.Include
        local any_collidable_result1 = Raycast_upvr.collidable(Head.Position, Vector3.new(-0, -1, -0), 10, RaycastParams_new_result1)
        if any_collidable_result1 and any_collidable_result1.Material == Enum.Material.Water then
            return false
        end
        return true
    end
    return false
end
return module