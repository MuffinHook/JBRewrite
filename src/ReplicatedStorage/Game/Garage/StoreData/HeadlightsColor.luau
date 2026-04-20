local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VehicleUtils_upvr = require(ReplicatedStorage.Vehicle.VehicleUtils)
local getDefaultVehicleModel_upvr = require(ReplicatedStorage.Game.getDefaultVehicleModel)
local Paint_upvr = require(ReplicatedStorage.Game.Garage.Paint)
return {
    Items = require(script.Parent.Color).Items;
    GetInstance = function(arg1) -- Line 7, Named "GetInstance"
        local any_GetLocalVehiclePacketForCustomize_result1 = VehicleUtils_upvr.GetLocalVehiclePacketForCustomize()
        local getDefaultVehicleModel_upvr_result1 = getDefaultVehicleModel_upvr(any_GetLocalVehiclePacketForCustomize_result1.Make, any_GetLocalVehiclePacketForCustomize_result1.Type)
        local Headlights = getDefaultVehicleModel_upvr_result1.Model.Headlights
        Headlights.Transparency = 0
        Headlights.Color = Paint_upvr.GetColor(arg1.Name)
        return getDefaultVehicleModel_upvr_result1
    end;
    Update = function(arg1, arg2) -- Line 16, Named "Update"
        local var8 = os.clock() / 2
        arg1.CFrame = CFrame.Angles(0, math.pi + math.cos(var8 % (-math.pi*2)) * 0.1, 0) * CFrame.Angles(math.sin(var8) * 0.1 - 0.05, 0, 0) * CFrame.new(0, 0, arg2.BoundingBox.Size.Magnitude * 0.7)
    end;
}