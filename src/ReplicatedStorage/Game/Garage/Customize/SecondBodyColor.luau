-- Reviewed by Claude
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Resource.Settings)
local HyperChromeConsts = require(ReplicatedStorage.HyperChrome.HyperChromeConsts)
local HyperChromeUtils = require(ReplicatedStorage.HyperChrome.HyperChromeUtils)
local Paint = require(ReplicatedStorage.Game.Garage.Paint)
local PaintUtils = require(ReplicatedStorage.Game.Garage.PaintUtils)
return function(p1, p2)
	local Model = p2.Model
	local Type = p2.Type
	local Make = p2.Make
	if Make == "MCL36FREE" then
		Make = "MCL36"
	end
	local v1 = p1 and p1.Name
	local list = {}
	for i, v in ipairs(Model:GetDescendants()) do
		if v.Name == "SecondBody" then
			table.insert(list, v)
		end
	end
	if Make == "Tank" then
		local Top = Model:FindFirstChild("Top")
		table.insert(list, Top:FindFirstChild("Turret"))
		local Top_2 = Model:FindFirstChild("Top")
		table.insert(list, Top_2:FindFirstChild("Hatch"))
		local Gun = Model:FindFirstChild("Top"):FindFirstChild("Gun")
		table.insert(list, Gun:FindFirstChild("Barrel"))
	elseif Make == "TheRattler" then
		table.insert(list, Model.Model:FindFirstChild("GoldTrim"))
		local RattlerEngine = Model:FindFirstChild("Preset"):FindFirstChild("RattlerEngine")
		table.insert(list, RattlerEngine:FindFirstChild("EngineFlaps"))
		local RattlerEngine_2 = Model:FindFirstChild("Preset"):FindFirstChild("RattlerEngine")
		table.insert(list, RattlerEngine_2:FindFirstChild("EngineGold"))
	elseif Make == "MCL36" then
		table.insert(list, Model.Model:FindFirstChild("FrontWing"))
		table.insert(list, Model.Model:FindFirstChild("Wing"))
	elseif Make == "Stunt" then
		table.insert(list, Model.Physics:FindFirstChild("Propeller"))
	elseif Make == "Sloop" then
		local SteeringWheel = Model.Physics:FindFirstChild("SteeringWheel")
		table.insert(list, SteeringWheel:FindFirstChild("Stump"))
		local SteeringWheel_2 = Model.Physics:FindFirstChild("SteeringWheel")
		table.insert(list, SteeringWheel_2:FindFirstChild("Wheel"))
		table.insert(list, Model.Visual:FindFirstChild("Floorboards"))
	end
	for i, v in ipairs(list) do
		local v2 = PaintUtils.GetDefaultVehiclePart(v)
		local t = {
			DefaultReflectance = v2.Reflectance,
			DefaultMaterial = v2.Material
		}
		if v1 then
			Paint.Part(v, v1, t)
		else
			v.Color = v2.Color
			v.Material = v2.Material
			v.Reflectance = v2.Reflectance
		end
		if not CollectionService:HasTag(v, "VehicleColorPart") then
			CollectionService:AddTag(v, "VehicleColorPart")
		end
		if HyperChromeUtils.isHyperChromeName(v1) then
			v:SetAttribute(HyperChromeConsts.HYPERCHROME_NAME_ATTRIBUTE_NAME, v1)
		else
			v:SetAttribute(HyperChromeConsts.HYPERCHROME_NAME_ATTRIBUTE_NAME, nil)
		end
	end
end