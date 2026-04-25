-- Reviewed by Claude
-- variables reassigned
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Paint = require(ReplicatedStorage.Game.Garage.Paint)
local HyperChromeConsts = require(ReplicatedStorage.HyperChrome.HyperChromeConsts)
local HyperChromeUtils = require(ReplicatedStorage.HyperChrome.HyperChromeUtils)
return function(p1, p2, p3)
	local Type = p2.Type
	local Make = p2.Make
	local Model = p2.Model
	local colorName = if p1 then p1.Name else "Grey"
	local rimName = p3 and p3.Rim or "Blade"
	local rimPart = ReplicatedStorage.Resource.Rims:FindFirstChild(rimName)
	local rimDefaults = {
		DefaultReflectance = rimPart.Reflectance,
		DefaultMaterial = rimPart.Material
	}
	local function UpdateRim(p1)
		Paint.Part(p1, colorName, rimDefaults)
		if rimName == "Storm" or (rimName == "HatchVoids" or rimName == "INF1N1TY") then
			for index, descendant in p1:GetDescendants() do
				if descendant:IsA("ParticleEmitter") then
					descendant.Color = ColorSequence.new(p1.Color)
				end
			end
		end
		if (Make == "Katana" or Make == "JBX0031") and p1.Parent.Name:find("Back") then
			p1.Color = Color3.fromRGB(0, 0, 0)
		end
		if not CollectionService:HasTag(p1, "VehicleColorPart") then
			CollectionService:AddTag(p1, "VehicleColorPart")
		end
		if HyperChromeUtils.isHyperChromeName(colorName) then
			p1:SetAttribute(HyperChromeConsts.HYPERCHROME_NAME_ATTRIBUTE_NAME, colorName)
		else
			p1:SetAttribute(HyperChromeConsts.HYPERCHROME_NAME_ATTRIBUTE_NAME, nil)
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
		for i, v in ipairs(Model:GetChildren()) do
			if v.Name == "WheelVisual" then
				UpdateRim(v)
			end
		end
	end
end