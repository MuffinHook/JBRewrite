local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PartUtils = require(ReplicatedStorage.Std.PartUtils)
local Customize = require(ReplicatedStorage.Game.Garage.Customize)
return function(vehicleMake, vehicleType)
	assert(vehicleMake ~= nil, "missing vehicle make")
	assert(vehicleType ~= nil, "missing vehicle type")
	if vehicleMake == "MCL36FREE" then
		vehicleMake = "MCL36"
	end
	local vehicleModel = ReplicatedStorage.Resource.Vehicles:FindFirstChild(vehicleMake) or ReplicatedStorage.Resource.Plane:FindFirstChild(vehicleMake) or ReplicatedStorage.Resource.Boat:FindFirstChild(vehicleMake)
	if vehicleModel then
		local clonedModel = vehicleModel:Clone()
		local resultModel = clonedModel
		for descendantIndex, descendant in clonedModel:GetDescendants() do
			local wheelRootFound
			if descendant:IsA("Model") and (descendant.Name:sub(1, 5) == "Wheel" and (descendant.Name ~= "Wheels" and descendant.Name ~= "WheelModels")) then
				local wheelRoot = descendant:FindFirstChild("Wheel") or descendant:FindFirstChild("WheelRoot")
				if not wheelRoot then
					print("could not find wheelRoot in", descendant:GetFullName())
				end
				wheelRootFound = wheelRoot ~= nil
				assert(wheelRootFound, "could not find wheelRoot")
				descendant.PrimaryPart = wheelRoot
			end
		end
		local WheelModels = resultModel:FindFirstChild("WheelModels")
		if WheelModels then
			for wheelModelIndex, wheelModel in WheelModels:GetChildren() do
				local wheelFound
				if wheelModel:IsA("Model") then
					local Wheel = wheelModel:FindFirstChild("Wheel")
					if not Wheel then
						print("could not find tirePart in", wheelModel:GetFullName())
					end
					wheelFound = Wheel ~= nil
					assert(wheelFound, "could not find tirePart")
					wheelModel.PrimaryPart = Wheel
				end
			end
		end
		resultModel.PrimaryPart = resultModel.BoundingBox
		resultModel:SetPrimaryPartCFrame(CFrame.new())
		if resultModel:FindFirstChild("Spoiler") then
			resultModel.Spoiler.Transparency = 1
		end
		if resultModel:FindFirstChild("PoliceLights") then
			resultModel.PoliceLights.Transparency = 1
		end
		if vehicleType ~= "Chassis3" then
			local customizeConfig = {
				Make = vehicleMake,
				Type = vehicleType,
				Model = resultModel
			}
			Customize.Apply({
				Name = "Classic"
			}, "Spoiler", customizeConfig)
			Customize.Apply({
				Name = "Arachnid"
			}, "Rim", customizeConfig)
			if vehicleMake == "NASCAR1" then
				Customize.Apply({
					Name = "NASCAR1"
				}, "Texture", customizeConfig)
			elseif vehicleMake == "NASCAR2" then
				Customize.Apply({
					Name = "NASCAR2"
				}, "Texture", customizeConfig)
			elseif vehicleMake == "MCL36" then
				Customize.Apply({
					Name = "MCL36"
				}, "Texture", customizeConfig)
			elseif vehicleMake == "NASCAR75th" then
				Customize.Apply({
					Name = "NASCAR75th"
				}, "Texture", customizeConfig)
			else
				Customize.Apply(nil, "Texture", customizeConfig)
			end
			Customize.Apply({
				Name = "Black"
			}, "WindowColor", customizeConfig)
			Customize.Apply({
				Name = "Black"
			}, "WheelColor", customizeConfig)
			PartUtils.setAnchored(resultModel, true)
		end
		return resultModel
	end
	error("Could not find vehicle model: " .. vehicleMake)
end
