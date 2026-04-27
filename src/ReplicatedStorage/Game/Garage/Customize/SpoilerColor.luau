local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Paint = require(ReplicatedStorage.Game.Garage.Paint)
local CollectionService = game:GetService("CollectionService")
local HyperChromeConsts = require(ReplicatedStorage.HyperChrome.HyperChromeConsts)
local HyperChromeUtils = require(ReplicatedStorage.HyperChrome.HyperChromeUtils)
return function(colorValue, vehicleModel, customizationConfig)
	local spoilerType = customizationConfig.Spoiler or "Classic"
	local materialConfig = {
		DefaultReflectance = 0,
		DefaultMaterial = Enum.Material.SmoothPlastic
	}
	if spoilerType then
		local spoilerResource = ReplicatedStorage.Resource.Spoiler:FindFirstChild(spoilerType)
		materialConfig.DefaultReflectance = spoilerResource.Reflectance
		materialConfig.DefaultMaterial = spoilerResource.Material
	end
	local SpoilerPart = vehicleModel.Model:FindFirstChild("SpoilerPart")
	if SpoilerPart then
		if colorValue == nil then
			Paint.Part(SpoilerPart, "White", materialConfig)
		else
			Paint.Part(SpoilerPart, colorValue.Name, materialConfig)
		end
		if spoilerType == "Skyline" then
			SpoilerPart.Material = Enum.Material.Neon
		end
		if spoilerType == "GuitarRiff" or spoilerType == "Stacked Cyberwing" then
			for i, trail in ipairs(SpoilerPart:GetChildren()) do
				if trail:IsA("Trail") then
					trail.Color = ColorSequence.new(SpoilerPart.Color)
				end
			end
		end
		if not CollectionService:HasTag(SpoilerPart, "VehicleColorPart") then
			CollectionService:AddTag(SpoilerPart, "VehicleColorPart")
		end
		if colorValue and HyperChromeUtils.isHyperChromeName(colorValue.Name) then
			SpoilerPart:SetAttribute(HyperChromeConsts.HYPERCHROME_NAME_ATTRIBUTE_NAME, colorValue.Name)
			return
		end
		SpoilerPart:SetAttribute(HyperChromeConsts.HYPERCHROME_NAME_ATTRIBUTE_NAME, nil)
	end
end
