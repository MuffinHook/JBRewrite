local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Paint = require(ReplicatedStorage.Game.Garage.Paint)
local HyperChromeConsts = require(ReplicatedStorage.HyperChrome.HyperChromeConsts)
local HyperChromeUtils = require(ReplicatedStorage.HyperChrome.HyperChromeUtils)
return function(wheelColorInstance, vehicleData, customizationOptions)
	local Type = vehicleData.Type
	local Make = vehicleData.Make
	local Model = vehicleData.Model
	local colorName = if wheelColorInstance then wheelColorInstance.Name else "Grey"
	local rimName = customizationOptions and customizationOptions.Rim or "Blade"
	local rimPart = ReplicatedStorage.Resource.Rims:FindFirstChild(rimName)
	local rimDefaults = {
		DefaultReflectance = rimPart.Reflectance,
		DefaultMaterial = rimPart.Material
	}
	local function UpdateRim(rimPart)
		Paint.Part(rimPart, colorName, rimDefaults)
		if rimName == "Storm" or (rimName == "HatchVoids" or rimName == "INF1N1TY") then
			for index, descendant in rimPart:GetDescendants() do
				if descendant:IsA("ParticleEmitter") then
					descendant.Color = ColorSequence.new(rimPart.Color)
				end
			end
		end
		if (Make == "Katana" or Make == "JBX0031") and rimPart.Parent.Name:find("Back") then
			rimPart.Color = Color3.fromRGB(0, 0, 0)
		end
		if not CollectionService:HasTag(rimPart, "VehicleColorPart") then
			CollectionService:AddTag(rimPart, "VehicleColorPart")
		end
		if HyperChromeUtils.isHyperChromeName(colorName) then
			rimPart:SetAttribute(HyperChromeConsts.HYPERCHROME_NAME_ATTRIBUTE_NAME, colorName)
		else
			rimPart:SetAttribute(HyperChromeConsts.HYPERCHROME_NAME_ATTRIBUTE_NAME, nil)
		end
	end
	if Type == "Chassis" then
		for index, descendant in Model:GetDescendants() do
			if descendant:IsA("Model") and descendant.Name:sub(1, 5) == "Wheel" then
				local Rim = descendant:FindFirstChild("Rim")
				if Rim then
					UpdateRim(Rim)
				end
			end
		end
		local WheelExtra = Model.Model:FindFirstChild("WheelExtra")
		if WheelExtra then
			local Rim = WheelExtra:FindFirstChild("Rim")
			if Rim then
				UpdateRim(Rim)
			end
		end
	elseif Type == "DuneBuggy" then
		for index, wheelPosition in next, { "FrontLeft", "FrontRight", "BackLeft", "BackRight" } do
			local wheelModel = Model.WheelModels:FindFirstChild(wheelPosition)
			local nextFunc = next
			local children, nilValue = wheelModel:GetChildren()
			for index, child in nextFunc, children, nilValue do
				if child.Name == "Rim" then
					UpdateRim(child)
				end
			end
		end
	elseif Type == "Motorcycle" then
		for index, wheelSide in next, { "Back", "Front" } do
			local wheelModel = Model.WheelModels:FindFirstChild(wheelSide)
			local nextFunc = next
			local children, nilValue = wheelModel:GetChildren()
			for index, child in nextFunc, children, nilValue do
				if child.Name == "RimLeft" or child.Name == "RimRight" then
					UpdateRim(child)
				end
			end
		end
	elseif Make == "Tank" then
		for wheelIndex, childPart in ipairs(Model:GetChildren()) do
			if childPart.Name == "WheelVisual" then
				UpdateRim(childPart)
			end
		end
	end
end
