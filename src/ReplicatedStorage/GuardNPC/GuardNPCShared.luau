-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMgDFRyYW5zcGFyZW5jeQpDYW5Db2xsaWRlDmNvbGxpZGFibGVGdW5jBnR5cGVvZgdWZWN0b3IzEEh1bWFub2lkUm9vdFBhcnQIUG9zaXRpb24PZ2V0TWF4U2hvb3REaXN0Dk1BWF9TSE9PVF9ESVNUK2dldE1heEFsbG93ZWRTaG9vdERpc3RhbmNlRnJvbURlZmVuc2VUYXJnZXQcZ2V0SXNUYXJnZXRpbmdJbnZvbHZlZFBsYXllchNnZXREZWZlbnNlVGFyZ2V0UG9zCU1hZ25pdHVkZQRtYXRoA21pbgpjb2xsaWRhYmxlBFVuaXQISW5zdGFuY2UGUGFyZW50DklzRGVzY2VuZGFudE9mCXdvcmtzcGFjZQhWZWhpY2xlcwxjYW5TZWVUYXJnZXQEZ2FtZRFSZXBsaWNhdGVkU3RvcmFnZQpHZXRTZXJ2aWNlB3JlcXVpcmUDU3RkB1JheWNhc3QIR3VhcmROUEMOR3VhcmROUENDb25zdHMNR3VhcmROUENVdGlscwADAwEAAAAACk0BANkAAAAAbwIBAH0CAwABAAAAqQEAAIIBAgBNAQDTAgAAAIIBAgADAwECK4cW2c737z8DAgAKAwEYAAAAAAABAAIAAAsAAAAADwMEAAAAcLssAQNSBAEApAMBAAAAAECfAwIC8AMDAAIAAICpAwAAggMCAE0DAGYDAAAATQMDOwQAAAD7BAAATQQElQUAAABSBQAAnwQCAisEAwD7BAEATQQExAYAAAD7BQAATQUFfAcAAABSBgAAnwUCAvsGAABNBgZdCAAAAFIHAACfBgICKwYPAA4FDgD7BgAATQYGAAkAAABSBwAAnwYCAk0IATsEAAAAJgcIBk0HB6oKAAAAYAUDAAcAAACpCAAAgggCAE0HATsEAAAAJgYHA00IBqoKAAAAnhMIBAQAAABSCQQApAcNAAAwsICfBwMC+wgCAE0ICJoOAAAAUgkDAE0KBgcPAAAAUgsHAFIMAgD7DQMAnwgGAsYJAADGCgAADggFAE0JCPQQAAAATQoIOwQAAABlAAUAxgkAAE0MBgcPAAAACQsMB0MKAwtNCwEkEQAAAA4JDwBSDgsAvAwJrRIAAACfDAMCKwwIAKQOFAAAADBBTQ4OohUAAAC8DAmtEgAAAJ8MAwIODAIAqQwBAIIMAgBNDQE7BAAAACYMCg1NDAyqCgAAAIwNAQBgDAMADQAAAKkMAQCCDAIAqQwAAIIMAgAWAwQEAAAAQAMFAwYDBwMIAwkDCgMLAwwDDQMOAw8EADCwgAMQAxEDEgMTAxQDFQQAADBBAxYAERcBGAAAAAAAAAABAAIAAAABAAAAAAAAAAABAAAAAAEAAAAAAAEBAAAAAAEAAAAAAQABAAQAAAEAAAAAAAAAAQAAAAAAAAAAAAEBAQEAAQAAAgEAAAACAAIBAAAAAAAAAAAAAAAAAQAEAAAAAAAAAAEAAgAUAAAAAAcAAAECACejAAAApAABAAAAAEBvAgIAvAAAFgMAAACfAAMCpAEFAAAAQEBNAgChBgAAAE0CAsIHAAAAnwECAqQCBQAAAEBATQMAXAgAAABNAwPDCQAAAJ8CAgKkAwUAAABAQE0EAFwIAAAATQQE4goAAACfAwIC/wQBAAAAAADABQsAwAYMABIAAwASAAIAEgABABIABQAwBgTVDQAAAIIEAgAOAxgEAAAAQAMZAxoDGwQAAEBAAxwDHQMeAx8DIAYABgEDFwIAAQEAARgAAAAAAAAAAQAAAAAAAAEAAAAAAAABAAAAAAAAAgAEBwAAAAAAACsBAAAAAAJgbvF3lDDmsZiqUJ9389h+EHbmA1Kqm3Y=

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-04-18 23:42:45
-- Luau version 6, Types version 3
-- Time taken: 0.004205 seconds

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
    --[[ Upvalues[4]:
        [1]: GuardNPCUtils_upvr (readonly)
        [2]: GuardNPCConsts_upvr (readonly)
        [3]: Raycast_upvr (readonly)
        [4]: collidableFunc_upvr (readonly)
    ]]
    -- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
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