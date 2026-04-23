-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Joint = require(ReplicatedStorage.Std.Joint)
local WheelColor = require(script.Parent.WheelColor)
local v1 = CFrame.new
local Angles = CFrame.Angles
local v2 = v1()
local _ = Vector3.new
local function getRimAndCf(p1, p2, p3, p4)
	local PrimaryPart = p2.PrimaryPart
	if not PrimaryPart then
		print(p2:GetFullName())
		print(p2:GetChildren())
		error("Vehicle wheel model is missing `Wheel` part as PrimaryPart")
	end
	local v1 = PrimaryPart
	local v22
	repeat
		v1 = v1.Parent
		v22 = v1:FindFirstChild("Engine")
	until v22 ~= nil
	local v3
	if p4 == nil then
		if v22.CFrame:PointToObjectSpace(PrimaryPart.Position).X < -1 then
			v3 = v22
			p4 = true
		else
			v3 = v22
			p4 = false
		end
	else
		v3 = v22
	end
	local v4 = Vector3.new(1, 1, 1)
	local v5 = p2:FindFirstChild("InnerWheelPct") or p1:FindFirstChild("InnerWheelPct")
	if v5 then
		v4 = Vector3.new(1, v5.Value, v5.Value)
	end
	local v9 = p2:FindFirstChild("InnerWheelScale") or p1:FindFirstChild("InnerWheelScale")
	if v9 then
		v4 = v9.Value
	end
	local v11 = ReplicatedStorage.Resource.Rims:FindFirstChild(p3.Name)
	local Size = v11.Size
	if not v11 then
		error("No rim exists under requested name")
	end
	local Rim = v11:Clone()
	Rim.Name = "Rim"
	Rim.Massless = true
	Rim.CanCollide = false
	Rim.Size = PrimaryPart.Size
	if Rim:FindFirstChildOfClass("Sound") then
		Rim:FindFirstChildOfClass("Sound"):Play()
	end
	local v12 = Rim
	local X = PrimaryPart.Size.X
	local v15 = X * (p3.OffsetXPct or 0)
	local v16 = math.max(X + v15, 0.01)
	local _ = v12.Size.Y * 0.25 + v12.Size.Z * 0.25
	local v18 = (PrimaryPart.Size.Y * 0.25 + PrimaryPart.Size.Z * 0.25) * (1 + (p3.OffsetRadiusPct or 0))
	v12.Size = Vector3.new(v16, v18 * 2, v18 * 2) * v4
	if v4.X <= 0.02 or (v4.Y <= 0.02 or v4.Z <= 0.02) then
		v12.Transparency = 1
	end
	local v20 = v12.Size / Size
	for v21, v222 in v12:GetDescendants() do
		if v222:IsA("Attachment") then
			v222.Position = v222.Position * v20
		elseif v222:IsA("ParticleEmitter") then
			local t = {}
			for i, v in ipairs(v222.Size.Keypoints) do
				table.insert(t, (NumberSequenceKeypoint.new(v.Time, v.Value * v12.Size.Y / Size.Y)))
			end
			v222.Size = NumberSequence.new(t)
		end
	end
	local v24 = CFrame.new()
	if not p4 then
		v24 = v24 * CFrame.Angles(0, math.pi, 0)
	end
	local v25 = v24 * CFrame.new(v16 * 0.5 - X * 0.5 - v15 - 0.01, 0, 0) * CFrame.Angles(0, math.pi, 0)
	if p3.FlipY then
		v25 = v25 * CFrame.Angles(0, math.pi, 0)
	end
	local BoundingBox = p1:FindFirstChild("BoundingBox")
	if BoundingBox and BoundingBox.Anchored then
		v12.Anchored = true
		if p2.Name == "WheelExtra" then
			v12.CFrame = PrimaryPart.CFrame * v25
		else
			v12.CFrame = v3.CFrame * CFrame.new((v3.CFrame:PointToObjectSpace(PrimaryPart.Position))) * v25
		end
	else
		v12.Anchored = false
		Joint.CustomWeld(v12, PrimaryPart, v2, v25)
	end
	return v12
end
local t = {
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
t.Chassis.SetRims = SetRims
t.Motorcycle = {}
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
t.Motorcycle.SetRims = SetRims_2
t.DuneBuggy = {}
local t2 = {
	BackLeft = true,
	BackRight = true,
	FrontLeft = true,
	FrontRight = true
}
local function SetRims_3(p1, p2)
	for v1, v2 in p1.Model.WheelModels:GetChildren() do
		if t2[v2.Name] and v2 then
			local Rim = v2:FindFirstChild("Rim")
			if Rim then
				Rim:Destroy()
			end
			getRimAndCf(p1.Model, v2, p2).Parent = v2
		end
	end
end
t.DuneBuggy.SetRims = SetRims_3
local function SetRimsRaw(p1, p2, p3, p4)
	if t[p1] then
		t[p1].SetRims({
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