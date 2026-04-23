local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
local Color = require(script.Parent.Color)
local BodyColor = require(ReplicatedStorage.Game.Garage.Customize.BodyColor)
local getDefaultVehicleModel = require(ReplicatedStorage.Game.getDefaultVehicleModel)
local function GetInstance(p1) --[[ Line: 7 | Upvalues: VehicleUtils (copy), getDefaultVehicleModel (copy), BodyColor (copy) ]]
	local v1 = VehicleUtils.GetLocalVehiclePacketForCustomize()
	local v2 = getDefaultVehicleModel(v1.Make, v1.Type)
	v2:FindFirstChild("Body", true).TextureID = ""
	local t = {
		Model = v2,
		Make = v1.Make,
		Type = v1.Type
	}
	if p1.None then
		BodyColor(nil, t)
	else
		BodyColor(p1, t)
	end
	return v2
end
local function Update(p1, p2) --[[ Line: 22 ]]
	local v1 = os.clock() / 2
	p1.CFrame = CFrame.Angles(0, v1 % 6.283185307179586, 0) * CFrame.Angles(math.sin(v1) * 0.25 - 0.3, 0, 0) * CFrame.new(0, 0, p2:GetExtentsSize().Magnitude * 0.6)
end
return {
	Items = Color.Items,
	GetInstance = GetInstance,
	Update = Update
}