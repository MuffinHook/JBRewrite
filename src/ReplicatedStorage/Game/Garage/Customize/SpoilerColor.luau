-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Paint = require(ReplicatedStorage.Game.Garage.Paint)
local CollectionService = game:GetService("CollectionService")
local HyperChromeConsts = require(ReplicatedStorage.HyperChrome.HyperChromeConsts)
local HyperChromeUtils = require(ReplicatedStorage.HyperChrome.HyperChromeUtils)
return function(p1, p2, p3)
	local spoilerType = p3.Spoiler or "Classic"
	local materialConfig = {
		DefaultReflectance = 0,
		DefaultMaterial = Enum.Material.SmoothPlastic
	}
	if spoilerType then
		local spoilerResource = ReplicatedStorage.Resource.Spoiler:FindFirstChild(spoilerType)
		materialConfig.DefaultReflectance = spoilerResource.Reflectance
		materialConfig.DefaultMaterial = spoilerResource.Material
	end
	local SpoilerPart = p2.Model:FindFirstChild("SpoilerPart")
	if SpoilerPart then
		if p1 == nil then
			Paint.Part(SpoilerPart, "White", materialConfig)
		else
			Paint.Part(SpoilerPart, p1.Name, materialConfig)
		end
		if spoilerType == "Skyline" then
			SpoilerPart.Material = Enum.Material.Neon
		end
		if spoilerType == "GuitarRiff" or spoilerType == "Stacked Cyberwing" then
			for i, v in ipairs(SpoilerPart:GetChildren()) do
				if v:IsA("Trail") then
					v.Color = ColorSequence.new(SpoilerPart.Color)
				end
			end
		end
		if not CollectionService:HasTag(SpoilerPart, "VehicleColorPart") then
			CollectionService:AddTag(SpoilerPart, "VehicleColorPart")
		end
		if p1 and HyperChromeUtils.isHyperChromeName(p1.Name) then
			SpoilerPart:SetAttribute(HyperChromeConsts.HYPERCHROME_NAME_ATTRIBUTE_NAME, p1.Name)
			return
		end
		SpoilerPart:SetAttribute(HyperChromeConsts.HYPERCHROME_NAME_ATTRIBUTE_NAME, nil)
	end
end
