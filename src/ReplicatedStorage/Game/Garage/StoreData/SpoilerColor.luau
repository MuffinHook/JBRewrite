local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VehicleUtils = require(ReplicatedStorage.Vehicle.VehicleUtils)
local Color = require(script.Parent.Color)
local Paint = require(ReplicatedStorage.Game.Garage.Paint)
local function GetInstance(p1) --[[ Line: 7 | Upvalues: VehicleUtils (copy), Paint (copy) ]]
	local v1 = VehicleUtils.GetLocalVehicleModel()
	assert(v1)
	local v2 = v1:Clone()
	VehicleUtils.CleanVehicleModel(v2)
	v2.PrimaryPart = v2.BoundingBox
	v2:SetPrimaryPartCFrame(CFrame.new(0, 0, 0))
	local SpoilerPart = v2:FindFirstChild("SpoilerPart")
	if SpoilerPart then
		SpoilerPart.Color = Paint.GetColor(p1.Name)
	end
	return v2
end
local function Update(p1, p2) --[[ Line: 21 ]]
	local v1 = os.clock() / 2
	p1.CFrame = CFrame.Angles(0, math.cos(v1 % 6.283185307179586) * 0.1, 0) * CFrame.Angles(math.sin(v1) * 0.1 - 0.1, 0, 0) * CFrame.new(0, 0, p2.PrimaryPart.Size.Magnitude * 0.7)
end
return {
	Items = Color.Items,
	GetInstance = GetInstance,
	Update = Update
}