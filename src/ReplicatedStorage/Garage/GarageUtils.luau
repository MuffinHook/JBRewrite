local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module_upvr = {}
local CollectionService_upvr = game:GetService("CollectionService")
local CharacterUtils_upvr = require(ReplicatedStorage.Std.CharacterUtils)
local RegionUtils_upvr = require(ReplicatedStorage.Std.Region.RegionUtils)
function module_upvr.isPlayerInPhysicalGarage(arg1) -- Line 13
    local any_getRootPart_result1 = CharacterUtils_upvr.getRootPart(arg1.Character)
    local var11
    if not any_getRootPart_result1 then return end
    for _, v in ipairs(CollectionService_upvr:GetTagged("Garage")) do
        local Region = v:FindFirstChild("Region")
        if Region and RegionUtils_upvr.CastPoint(RegionUtils_upvr.getPrism(Region.CFrame, Region.Size), any_getRootPart_result1.Position) then
            var11 = true
        end
    end
    return var11
end
local Players_upvr = game:GetService("Players")
function module_upvr.inPhysicalGarage() -- Line 33
    return module_upvr.isPlayerInPhysicalGarage(Players_upvr.LocalPlayer)
end
local VehicleUtils_upvr = require(ReplicatedStorage.Vehicle.VehicleUtils)
function module_upvr.inVehicle() -- Line 36
    local var18
    if VehicleUtils_upvr.GetLocalVehiclePacket() == nil then
        var18 = false
    else
        var18 = true
    end
    return var18
end
local GamepassSystem_upvr = require(ReplicatedStorage.Gamepass.GamepassSystem)
local GamepassUtils_upvr = require(ReplicatedStorage.Gamepass.GamepassUtils)
local PrivateServerUtils_upvr = require(ReplicatedStorage.PrivateServer.PrivateServerUtils)
function module_upvr.hasPremium() -- Line 40
    local any_DoesPlayerOwn_result1 = GamepassSystem_upvr.DoesPlayerOwn(GamepassUtils_upvr.EnumGamepass.PremiumGarage)
    if not any_DoesPlayerOwn_result1 then
        any_DoesPlayerOwn_result1 = PrivateServerUtils_upvr
        any_DoesPlayerOwn_result1 = any_DoesPlayerOwn_result1.getIsBattleServer()
    end
    return any_DoesPlayerOwn_result1
end
function module_upvr.isVehicleCustomizationLimited(arg1) -- Line 44
    local var26 = true
    if arg1.Hidden ~= true then
        var26 = true
        if arg1.HiddenAll ~= true then
            var26 = true
            if arg1.Level == nil then
                var26 = true
                if arg1.Season == nil then
                    var26 = not arg1.Price
                end
            end
        end
    end
    return var26
end
function module_upvr.isVehicleLimited(arg1) -- Line 51
    local var27 = true
    if arg1.Hidden ~= true then
        var27 = true
        if arg1.Retired ~= true then
            var27 = true
            if arg1.Level == nil then
                if arg1.Season == nil then
                    var27 = false
                else
                    var27 = true
                end
            end
        end
    end
    return var27
end
local GarageConsts_upvr = require(ReplicatedStorage.Game.Garage.GarageConsts)
function module_upvr.getIsSaveSlotValid(arg1, arg2) -- Line 55
    local var29
    if typeof(arg1) ~= "number" then
        var29 = false
    else
        var29 = true
    end
    assert(var29, "saveSlotNum must be a number")
    if typeof(arg2) ~= "boolean" then
        var29 = false
    else
        var29 = true
    end
    assert(var29, "isVIP must be a boolean")
    if arg1 ~= arg1 then
        return false
    end
    if arg2 then
        local var30 = false
        var29 = 0
        if var29 < arg1 then
            var29 = GarageConsts_upvr
            var29 = var29.NUM_SAVE_SLOTS
            if arg1 > var29 then
                var30 = false
            else
                var30 = true
            end
        end
        return var30
    end
    var29 = false
    if 0 < arg1 then
        if arg1 > GarageConsts_upvr.NUM_FREE_SAVE_SLOTS then
            var29 = false
        else
            var29 = true
        end
    end
    return var29
end
return module_upvr