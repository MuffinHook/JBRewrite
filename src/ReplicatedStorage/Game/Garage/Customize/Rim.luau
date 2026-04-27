local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Joint = require(ReplicatedStorage.Std.Joint)
local WheelColor = require(script.Parent.WheelColor)
local cfNew = CFrame.new
local Angles = CFrame.Angles
local defaultCFrame = cfNew()
local _ = Vector3.new
local function getRimAndCf(vehicleModel, wheelPart, rimConfig, isLeftWheel)
	local PrimaryPart = wheelPart.PrimaryPart
	if not PrimaryPart then
		print(wheelPart:GetFullName())
		print(wheelPart:GetChildren())
		error("Vehicle wheel model is missing `Wheel` part as PrimaryPart")
	end
	local currentPart = PrimaryPart
	local enginePart
	repeat
		currentPart = currentPart.Parent
		enginePart = currentPart:FindFirstChild("Engine")
	until enginePart ~= nil
	local enginePartRef
	if isLeftWheel == nil then
		if enginePart.CFrame:PointToObjectSpace(PrimaryPart.Position).X < -1 then
			enginePartRef = enginePart
			isLeftWheel = true
		else
			enginePartRef = enginePart
			isLeftWheel = false
		end
	else
		enginePartRef = enginePart
	end
	local scaleVector = Vector3.new(1, 1, 1)
	local innerWheelPct = wheelPart:FindFirstChild("InnerWheelPct") or vehicleModel:FindFirstChild("InnerWheelPct")
	if innerWheelPct then
		scaleVector = Vector3.new(1, innerWheelPct.Value, innerWheelPct.Value)
	end
	local innerWheelScale = wheelPart:FindFirstChild("InnerWheelScale") or vehicleModel:FindFirstChild("InnerWheelScale")
	if innerWheelScale then
		scaleVector = innerWheelScale.Value
	end
	local rimResource = ReplicatedStorage.Resource.Rims:FindFirstChild(rimConfig.Name)
	local Size = rimResource.Size
	if not rimResource then
		error("No rim exists under requested name")
	end
	local Rim = rimResource:Clone()
	Rim.Name = "Rim"
	Rim.Massless = true
	Rim.CanCollide = false
	Rim.Size = PrimaryPart.Size
	if Rim:FindFirstChildOfClass("Sound") then
		Rim:FindFirstChildOfClass("Sound"):Play()
	end
	local clonedRim = Rim
	local X = PrimaryPart.Size.X
	local offsetX = X * (rimConfig.OffsetXPct or 0)
	local adjustedWheelWidth = math.max(X + offsetX, 0.01)
	local _ = clonedRim.Size.Y * 0.25 + clonedRim.Size.Z * 0.25
	local adjustedRadius = (PrimaryPart.Size.Y * 0.25 + PrimaryPart.Size.Z * 0.25) * (1 + (rimConfig.OffsetRadiusPct or 0))
	clonedRim.Size = Vector3.new(adjustedWheelWidth, adjustedRadius * 2, adjustedRadius * 2) * scaleVector
	if scaleVector.X <= 0.02 or (scaleVector.Y <= 0.02 or scaleVector.Z <= 0.02) then
		clonedRim.Transparency = 1
	end
	local sizeRatio = clonedRim.Size / Size
	for index, descendant in clonedRim:GetDescendants() do
		if descendant:IsA("Attachment") then
			descendant.Position = descendant.Position * sizeRatio
		elseif descendant:IsA("ParticleEmitter") then
			local keypointList = {}
			for i, keypoint in ipairs(descendant.Size.Keypoints) do
				table.insert(keypointList, (NumberSequenceKeypoint.new(keypoint.Time, keypoint.Value * clonedRim.Size.Y / Size.Y)))
			end
			descendant.Size = NumberSequence.new(keypointList)
		end
	end
	local baseCFrame = CFrame.new()
	if not isLeftWheel then
		baseCFrame = baseCFrame * CFrame.Angles(0, math.pi, 0)
	end
	local rimCFrame = baseCFrame * CFrame.new(adjustedWheelWidth * 0.5 - X * 0.5 - offsetX - 0.01, 0, 0) * CFrame.Angles(0, math.pi, 0)
	if rimConfig.FlipY then
		rimCFrame = rimCFrame * CFrame.Angles(0, math.pi, 0)
	end
	local BoundingBox = vehicleModel:FindFirstChild("BoundingBox")
	if BoundingBox and BoundingBox.Anchored then
		clonedRim.Anchored = true
		if wheelPart.Name == "WheelExtra" then
			clonedRim.CFrame = PrimaryPart.CFrame * rimCFrame
		else
			clonedRim.CFrame = enginePartRef.CFrame * CFrame.new((enginePartRef.CFrame:PointToObjectSpace(PrimaryPart.Position))) * rimCFrame
		end
	else
		clonedRim.Anchored = false
		Joint.CustomWeld(clonedRim, PrimaryPart, defaultCFrame, rimCFrame)
	end
	return clonedRim
end
local rimModule = {
	Chassis = {}
}
local function setChassisRim(wheelModel, vehicleData, rimConfig)
	if wheelModel then
		local Rim = wheelModel:FindFirstChild("Rim")
		if Rim then
			Rim:Destroy()
		end
		getRimAndCf(vehicleData.Model, wheelModel, rimConfig).Parent = wheelModel
	end
end
local function SetRims(vehicleData, rimConfig)
	for wheelIndex, wheelPart in vehicleData.Model:GetDescendants() do
		if wheelPart:IsA("Model") and (wheelPart.Name:sub(1, 5) == "Wheel" and wheelPart.Name ~= "Wheels") and wheelPart then
			local Rim = wheelPart:FindFirstChild("Rim")
			if Rim then
				Rim:Destroy()
			end
			getRimAndCf(vehicleData.Model, wheelPart, rimConfig).Parent = wheelPart
		end
	end
end
rimModule.Chassis.SetRims = SetRims
rimModule.Motorcycle = {}
local function setMotorcycleRim(wheelModel, vehicleData, rimConfig)
	local RimLeft = wheelModel:FindFirstChild("RimLeft")
	if RimLeft then
		RimLeft:Destroy()
	end
	local RimRight = wheelModel:FindFirstChild("RimRight")
	if RimRight then
		RimRight:Destroy()
	end
	local leftRim = getRimAndCf(vehicleData.Model, wheelModel, rimConfig, true)
	leftRim.Name = "RimLeft"
	leftRim.Parent = wheelModel
	local rightRim = getRimAndCf(vehicleData.Model, wheelModel, rimConfig, false)
	rightRim.Name = "RimRight"
	rightRim.Parent = wheelModel
end
local function setMotorcycleRims(vehicleData, rimConfig)
	local _ = rimConfig.Name
	for wheelIndex, wheelModel in vehicleData.Model.WheelModels:GetChildren() do
		if wheelModel:IsA("Model") then
			setMotorcycleRim(wheelModel, vehicleData, rimConfig)
		end
	end
end
rimModule.Motorcycle.SetRims = setMotorcycleRims
rimModule.DuneBuggy = {}
local wheelNameSet = {
	BackLeft = true,
	BackRight = true,
	FrontLeft = true,
	FrontRight = true
}
local function setDuneBuggyRims(vehicleData, rimConfig)
	for wheelIndex, wheelModel in vehicleData.Model.WheelModels:GetChildren() do
		if wheelNameSet[wheelModel.Name] and wheelModel then
			local Rim = wheelModel:FindFirstChild("Rim")
			if Rim then
				Rim:Destroy()
			end
			getRimAndCf(vehicleData.Model, wheelModel, rimConfig).Parent = wheelModel
		end
	end
end
rimModule.DuneBuggy.SetRims = setDuneBuggyRims
local function SetRimsRaw(vehicleType, vehicleMake, vehicleModel, rimConfig)
	if rimModule[vehicleType] then
		rimModule[vehicleType].SetRims({
			Type = vehicleType,
			Make = vehicleMake,
			Model = vehicleModel
		}, rimConfig)
	end
end
return function(rimConfig, vehicleData, colorData)
	local vehicleType = vehicleData.Type
	local vehicleMake = vehicleData.Make
	local vehicleModel = vehicleData.Model
	if rimConfig then
		SetRimsRaw(vehicleType, vehicleMake, vehicleModel, rimConfig)
	else
		SetRimsRaw(vehicleType, vehicleMake, vehicleModel, {
			Name = "Blade"
		})
	end
	if colorData then
		WheelColor(colorData.WheelColor and {
			Name = colorData.WheelColor
		} or nil, vehicleData, colorData)
	end
end
