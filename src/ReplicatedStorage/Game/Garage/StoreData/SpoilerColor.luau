local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VehicleUtils_upvr = require(ReplicatedStorage.Vehicle.VehicleUtils)
local Paint_upvr = require(ReplicatedStorage.Game.Garage.Paint)
return {
    Items = require(script.Parent.Color).Items;
    GetInstance = function(arg1) -- Line 7, Named "GetInstance"
        local any_GetLocalVehicleModel_result1 = VehicleUtils_upvr.GetLocalVehicleModel()
        assert(any_GetLocalVehicleModel_result1)
        local clone = any_GetLocalVehicleModel_result1:Clone()
        VehicleUtils_upvr.CleanVehicleModel(clone)
        clone.PrimaryPart = clone.BoundingBox
        clone:SetPrimaryPartCFrame(CFrame.new(0, 0, 0))
        local SpoilerPart = clone:FindFirstChild("SpoilerPart")
        if SpoilerPart then
            SpoilerPart.Color = Paint_upvr.GetColor(arg1.Name)
        end
        return clone
    end;
    Update = function(arg1, arg2) -- Line 21, Named "Update"
        local var7 = os.clock() / 2
        arg1.CFrame = CFrame.Angles(0, math.cos(var7 % (-math.pi*2)) * 0.1, 0) * CFrame.Angles(math.sin(var7) * 0.1 - 0.1, 0, 0) * CFrame.new(0, 0, arg2.PrimaryPart.Size.Magnitude * 0.7)
    end;
}