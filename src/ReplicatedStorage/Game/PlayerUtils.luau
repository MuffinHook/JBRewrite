local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Settings_upvr = require(ReplicatedStorage_upvr.Resource.Settings)
local Players_upvr = game:GetService("Players")
local LocalPlayer_upvr = Players_upvr.LocalPlayer
local var5_upvw
local module_upvr = {
    init = function() -- Line 16, Named "init"
        var5_upvw = require(ReplicatedStorage_upvr.Inventory.InventoryItemSystem)
    end;
}
local PlayerConsts_upvr = require(script.Parent.PlayerConsts)
function module_upvr.getLastVehicleSpawnedAt() -- Line 19
    local SOME = LocalPlayer_upvr:FindFirstChild(PlayerConsts_upvr.LAST_VEHICLE_SPAWNED_AT_VALUE_NAME)
    assert(SOME)
    return SOME.Value
end
function module_upvr.getHumanoid(arg1) -- Line 24
    local Character_2 = arg1.Character
    if not Character_2 then return end
    return Character_2:FindFirstChild("Humanoid")
end
function module_upvr.getRootPart(arg1) -- Line 31
    local Character = arg1.Character
    if not Character then return end
    return Character.PrimaryPart
end
function module_upvr.getTeam(arg1) -- Line 39
    local TeamValue = arg1:FindFirstChild("TeamValue")
    local var12 = TeamValue
    if var12 then
        var12 = TeamValue.Value
    end
    return var12
end
local Teams_upvr = game:GetService("Teams")
function module_upvr.getTeamId(arg1) -- Line 43
    if arg1.Team == Teams_upvr:FindFirstChild("Prisoner") then
        return Settings_upvr.EnumTeam.Prisoner
    end
    if arg1.Team == Teams_upvr:FindFirstChild("Criminal") then
        return Settings_upvr.EnumTeam.Criminal
    end
    if arg1.Team == Teams_upvr:FindFirstChild("Police") then
        return Settings_upvr.EnumTeam.Police
    end
    return nil
end
local GameUtil_upvr = require(ReplicatedStorage_upvr.Game.GameUtil)
function module_upvr.hasKey() -- Line 53
    if GameUtil_upvr.Team == Settings_upvr.EnumTeam.Police then
        return true
    end
    return var5_upvw.playerHasItem(LocalPlayer_upvr, "Key")
end
function module_upvr.getPlayerFromDescendant(arg1) -- Line 59
    if not arg1 then
    else
        for _, v in ipairs(Players_upvr:GetPlayers()) do
            if v.Character and arg1:IsDescendantOf(v.Character) then
                return v
            end
        end
    end
end
local CharacterUtils_upvr = require(ReplicatedStorage_upvr.Std.CharacterUtils)
function module_upvr.isInVehicle(arg1) -- Line 71
    return module_upvr.isHumanoidInVehicle(CharacterUtils_upvr.getHumanoid(arg1.Character))
end
function module_upvr.isHumanoidInVehicle(arg1) -- Line 75
    if not arg1 then
        return false
    end
    if arg1.Parent:GetAttribute("InVehicle") ~= true then
    else
    end
    return true
end
return module_upvr