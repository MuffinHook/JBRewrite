local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module = {}
local function collidableFunc_upvr(arg1) -- Line 10, Named "collidableFunc"
    if 0.999 <= arg1.Transparency then
        return false
    end
    return arg1.CanCollide
end
local GuardNPCUtils_upvr = require(ReplicatedStorage.GuardNPC.GuardNPCUtils)
local GuardNPCConsts_upvr = require(ReplicatedStorage.GuardNPC.GuardNPCConsts)
local Raycast_upvr = require(ReplicatedStorage.Std.Raycast)
function module.canSeeTarget(arg1, arg2, arg3) -- Line 17
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var6
    if typeof(arg2) == "Vector3" then
        return false
    end
    local Position = arg1.HumanoidRootPart.Position
    var6 = GuardNPCUtils_upvr
    var6 = var6.getMaxShootDist(arg1)
    if not var6 then
        var6 = GuardNPCConsts_upvr
        var6 = var6.MAX_SHOOT_DIST
    end
    local any_getMaxAllowedShootDistanceFromDefenseTarget_result1 = GuardNPCUtils_upvr.getMaxAllowedShootDistanceFromDefenseTarget(arg1)
    local var9
    if not GuardNPCUtils_upvr.getIsTargetingInvolvedPlayer(arg1) and any_getMaxAllowedShootDistanceFromDefenseTarget_result1 and any_getMaxAllowedShootDistanceFromDefenseTarget_result1 < (arg2.Position - GuardNPCUtils_upvr.getDefenseTargetPos(arg1)).Magnitude then
        return false
    end
    local var10 = arg2.Position - Position
    var9 = var6
    local minimum = math.min(var10.Magnitude, var9)
    var9 = Position
    local any_collidable_result1 = Raycast_upvr.collidable(var9, var10.Unit, minimum, arg3, collidableFunc_upvr)
    var9 = nil
    if any_collidable_result1 then
        var9 = any_collidable_result1.Instance
    else
        var9 = nil
    end
    if var9 and (var9:IsDescendantOf(arg2.Parent) or var9:IsDescendantOf(workspace.Vehicles)) then
        return true
    end
    if (Position + var10.Unit * minimum - arg2.Position).Magnitude < 1 then
        return true
    end
    return false
end
return module