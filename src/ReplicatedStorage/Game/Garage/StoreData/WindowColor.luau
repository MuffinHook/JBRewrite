local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VehicleUtils_upvr = require(ReplicatedStorage.Vehicle.VehicleUtils)
local getDefaultVehicleModel_upvr = require(ReplicatedStorage.Game.getDefaultVehicleModel)
local WindowColor_upvr = require(ReplicatedStorage.Game.Garage.Customize.WindowColor)
return {
    Items = require(script.Parent.Color).Items;
    GetInstance = function(arg1) -- Line 7, Named "GetInstance"
        local any_GetLocalVehiclePacketForCustomize_result1 = VehicleUtils_upvr.GetLocalVehiclePacketForCustomize()
        local getDefaultVehicleModel_upvr_result1 = getDefaultVehicleModel_upvr(any_GetLocalVehiclePacketForCustomize_result1.Make, any_GetLocalVehiclePacketForCustomize_result1.Type)
        local tbl = {
            Model = getDefaultVehicleModel_upvr_result1;
            Make = any_GetLocalVehiclePacketForCustomize_result1.Make;
            Type = any_GetLocalVehiclePacketForCustomize_result1.Type;
        }
        if arg1.None then
            WindowColor_upvr(nil, tbl)
            return getDefaultVehicleModel_upvr_result1
        end
        WindowColor_upvr(arg1, tbl)
        return getDefaultVehicleModel_upvr_result1
    end;
    Update = function(arg1, arg2) -- Line 19, Named "Update"
        local var8 = os.clock() / 2
        arg1.CFrame = CFrame.Angles(0, 2.356194490192345 + math.cos(var8 % (-math.pi*2)) * 0.1, 0) * CFrame.Angles(math.sin(var8) * 0.25 - 0.3, 0, 0) * CFrame.new(0, 0, arg2.BoundingBox.Size.Magnitude * 0.6)
    end;
}