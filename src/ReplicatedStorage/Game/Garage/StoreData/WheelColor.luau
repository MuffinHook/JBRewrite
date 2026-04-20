local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VehicleUtils_upvr = require(ReplicatedStorage.Vehicle.VehicleUtils)
local getDefaultVehicleModel_upvr = require(ReplicatedStorage.Game.getDefaultVehicleModel)
local WheelColor_upvr = require(ReplicatedStorage.Game.Garage.Customize.WheelColor)
return {
    Items = require(script.Parent.Color).Items;
    GetInstance = function(arg1) -- Line 7, Named "GetInstance"
        local any_GetLocalVehiclePacketForCustomize_result1 = VehicleUtils_upvr.GetLocalVehiclePacketForCustomize()
        local getDefaultVehicleModel_upvr_result1 = getDefaultVehicleModel_upvr(any_GetLocalVehiclePacketForCustomize_result1.Make, any_GetLocalVehiclePacketForCustomize_result1.Type)
        WheelColor_upvr(arg1, {
            Model = getDefaultVehicleModel_upvr_result1;
            Make = any_GetLocalVehiclePacketForCustomize_result1.Make;
            Type = any_GetLocalVehiclePacketForCustomize_result1.Type;
        })
        return getDefaultVehicleModel_upvr_result1
    end;
    Update = function(arg1, arg2) -- Line 15, Named "Update"
        local var8 = os.clock() / 2
        arg1.CFrame = CFrame.Angles(0, var8 % (-math.pi*2), 0) * CFrame.Angles(math.sin(var8) * 0.25 - 0.3, 0, 0) * CFrame.new(0, 0, arg2.BoundingBox.Size.Magnitude * 0.7)
    end;
}