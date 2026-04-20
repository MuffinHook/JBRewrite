local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VehicleUtils_upvr = require(ReplicatedStorage.Vehicle.VehicleUtils)
local getDefaultVehicleModel_upvr = require(ReplicatedStorage.Game.getDefaultVehicleModel)
local SecondTexture_upvr = require(ReplicatedStorage.Game.Garage.Customize.SecondTexture)
local clone = table.clone(require(script.Parent.Texture))
function clone.GetInstance(arg1) -- Line 7
    local any_GetLocalVehiclePacketForCustomize_result1 = VehicleUtils_upvr.GetLocalVehiclePacketForCustomize()
    local getDefaultVehicleModel_upvr_result1 = getDefaultVehicleModel_upvr(any_GetLocalVehiclePacketForCustomize_result1.Make, any_GetLocalVehiclePacketForCustomize_result1.Type)
    local tbl = {
        Model = getDefaultVehicleModel_upvr_result1;
        Make = any_GetLocalVehiclePacketForCustomize_result1.Make;
        Type = any_GetLocalVehiclePacketForCustomize_result1.Type;
    }
    if arg1.None then
        SecondTexture_upvr(nil, tbl)
        return getDefaultVehicleModel_upvr_result1
    end
    SecondTexture_upvr(arg1, tbl)
    return getDefaultVehicleModel_upvr_result1
end
return clone