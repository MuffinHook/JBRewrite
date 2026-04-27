local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Resource.Settings)
local HyperChromeConsts = require(ReplicatedStorage.HyperChrome.HyperChromeConsts)
local HyperChromeUtils = require(ReplicatedStorage.HyperChrome.HyperChromeUtils)
local Paint = require(ReplicatedStorage.Game.Garage.Paint)
local PaintUtils = require(ReplicatedStorage.Game.Garage.PaintUtils)
return function(colorData, vehicleData)
	local Model = vehicleData.Model
	local Type = vehicleData.Type
	local Make = vehicleData.Make
	if Make == "MCL36FREE" then
		Make = "MCL36"
	end
	local colorName = colorData and colorData.Name
	local list = {}
	for i, part in ipairs(Model:GetDescendants()) do
		if part.Name == "SecondBody" then
			table.insert(list, part)
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
	for i, part in ipairs(list) do
		local defaultPart = PaintUtils.GetDefaultVehiclePart(part)
		local defaultProperties = {
			DefaultReflectance = defaultPart.Reflectance,
			DefaultMaterial = defaultPart.Material
		}
		if colorName then
			Paint.Part(part, colorName, defaultProperties)
		else
			part.Color = defaultPart.Color
			part.Material = defaultPart.Material
			part.Reflectance = defaultPart.Reflectance
		end
		if not CollectionService:HasTag(part, "VehicleColorPart") then
			CollectionService:AddTag(part, "VehicleColorPart")
		end
		if HyperChromeUtils.isHyperChromeName(colorName) then
			part:SetAttribute(HyperChromeConsts.HYPERCHROME_NAME_ATTRIBUTE_NAME, colorName)
		else
			part:SetAttribute(HyperChromeConsts.HYPERCHROME_NAME_ATTRIBUTE_NAME, nil)
		end
	end
end
