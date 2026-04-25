-- Reviewed by Claude
-- variables reassigned
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
	local v15 = X * (rimConfig.OffsetXPct or 0)
	local v16 = math.max(X + v15, 0.01)
	local _ = clonedRim.Size.Y * 0.25 + clonedRim.Size.Z * 0.25
	local v18 = (PrimaryPart.Size.Y * 0.25 + PrimaryPart.Size.Z * 0.25) * (1 + (rimConfig.OffsetRadiusPct or 0))
	clonedRim.Size = Vector3.new(v16, v18 * 2, v18 * 2) * scaleVector
	if scaleVector.X <= 0.02 or (scaleVector.Y <= 0.02 or scaleVector.Z <= 0.02) then
		clonedRim.Transparency = 1
	end
	local sizeRatio = clonedRim.Size / Size
	for v21, v222 in clonedRim:GetDescendants() do
		if v222:IsA("Attachment") then
			v222.Position = v222.Position * sizeRatio
		elseif v222:IsA("ParticleEmitter") then
			local keypointList = {}
			for i, v in ipairs(v222.Size.Keypoints) do
				table.insert(keypointList, (NumberSequenceKeypoint.new(v.Time, v.Value * clonedRim.Size.Y / Size.Y)))
			end
			v222.Size = NumberSequence.new(keypointList)
		end
	end
	local baseCFrame = CFrame.new()
	if not isLeftWheel then
		baseCFrame = baseCFrame * CFrame.Angles(0, math.pi, 0)
	end
	local rimCFrame = baseCFrame * CFrame.new(v16 * 0.5 - X * 0.5 - v15 - 0.01, 0, 0) * CFrame.Angles(0, math.pi, 0)
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
local function setChassisRim(p1, p2, p3)
	if p1 then
		local Rim = p1:FindFirstChild("Rim")
		if Rim then
			Rim:Destroy()
		end
		getRimAndCf(p2.Model, p1, p3).Parent = p1
	end
end
local function SetRims(p1, p2)
	for v1, v2 in p1.Model:GetDescendants() do
		if v2:IsA("Model") and (v2.Name:sub(1, 5) == "Wheel" and v2.Name ~= "Wheels") and v2 then
			local Rim = v2:FindFirstChild("Rim")
			if Rim then
				Rim:Destroy()
			end
			getRimAndCf(p1.Model, v2, p2).Parent = v2
		end
	end
end
rimModule.Chassis.SetRims = SetRims
rimModule.Motorcycle = {}
local function setMotorcycleRim(p1, p2, p3)
	local RimLeft = p1:FindFirstChild("RimLeft")
	if RimLeft then
		RimLeft:Destroy()
	end
	local RimRight = p1:FindFirstChild("RimRight")
	if RimRight then
		RimRight:Destroy()
	end
	local RimLeft_2 = getRimAndCf(p2.Model, p1, p3, true)
	RimLeft_2.Name = "RimLeft"
	RimLeft_2.Parent = p1
	local RimRight_2 = getRimAndCf(p2.Model, p1, p3, false)
	RimRight_2.Name = "RimRight"
	RimRight_2.Parent = p1
end
local function SetRims_2(p1, p2)
	local _ = p2.Name
	for v1, v2 in p1.Model.WheelModels:GetChildren() do
		if v2:IsA("Model") then
			setMotorcycleRim(v2, p1, p2)
		end
	end
end
rimModule.Motorcycle.SetRims = SetRims_2
rimModule.DuneBuggy = {}
local wheelNameSet = {
	BackLeft = true,
	BackRight = true,
	FrontLeft = true,
	FrontRight = true
}
local function SetRims_3(p1, p2)
	for v1, v2 in p1.Model.WheelModels:GetChildren() do
		if wheelNameSet[v2.Name] and v2 then
			local Rim = v2:FindFirstChild("Rim")
			if Rim then
				Rim:Destroy()
			end
			getRimAndCf(p1.Model, v2, p2).Parent = v2
		end
	end
end
rimModule.DuneBuggy.SetRims = SetRims_3
local function SetRimsRaw(p1, p2, p3, p4)
	if rimModule[p1] then
		rimModule[p1].SetRims({
			Type = p1,
			Make = p2,
			Model = p3
		}, p4)
	end
end
return function(p1, p2, p3)
	local Type = p2.Type
	local Make = p2.Make
	local Model = p2.Model
	if p1 then
		SetRimsRaw(Type, Make, Model, p1)
	else
		SetRimsRaw(Type, Make, Model, {
			Name = "Blade"
		})
	end
	if p3 then
		WheelColor(p3.WheelColor and {
			Name = p3.WheelColor
		} or nil, p2, p3)
	end
end
