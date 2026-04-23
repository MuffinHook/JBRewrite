-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PartUtils = require(ReplicatedStorage.Std.PartUtils)
local Customize = require(ReplicatedStorage.Game.Garage.Customize)
return function(p1, p2)
	assert(p1 ~= nil, "missing vehicle make")
	assert(p2 ~= nil, "missing vehicle type")
	if p1 == "MCL36FREE" then
		p1 = "MCL36"
	end
	local v3 = ReplicatedStorage.Resource.Vehicles:FindFirstChild(p1) or ReplicatedStorage.Resource.Plane:FindFirstChild(p1) or ReplicatedStorage.Resource.Boat:FindFirstChild(p1)
	if v3 then
		local v4 = v3:Clone()
		local v5 = v4
		for v7, v8 in v4:GetDescendants() do
			local v6
			if v8:IsA("Model") and (v8.Name:sub(1, 5) == "Wheel" and (v8.Name ~= "Wheels" and v8.Name ~= "WheelModels")) then
				local v9 = v8:FindFirstChild("Wheel") or v8:FindFirstChild("WheelRoot")
				if not v9 then
					print("could not find wheelRoot in", v8:GetFullName())
				end
				v6 = v9 ~= nil
				assert(v6, "could not find wheelRoot")
				v8.PrimaryPart = v9
			end
		end
		local WheelModels = v5:FindFirstChild("WheelModels")
		if WheelModels then
			for v11, v12 in WheelModels:GetChildren() do
				local v10
				if v12:IsA("Model") then
					local Wheel = v12:FindFirstChild("Wheel")
					if not Wheel then
						print("could not find tirePart in", v12:GetFullName())
					end
					v10 = Wheel ~= nil
					assert(v10, "could not find tirePart")
					v12.PrimaryPart = Wheel
				end
			end
		end
		v5.PrimaryPart = v5.BoundingBox
		v5:SetPrimaryPartCFrame(CFrame.new())
		if v5:FindFirstChild("Spoiler") then
			v5.Spoiler.Transparency = 1
		end
		if v5:FindFirstChild("PoliceLights") then
			v5.PoliceLights.Transparency = 1
		end
		if p2 ~= "Chassis3" then
			local t = {
				Make = p1,
				Type = p2,
				Model = v5
			}
			Customize.Apply({
				Name = "Classic"
			}, "Spoiler", t)
			Customize.Apply({
				Name = "Arachnid"
			}, "Rim", t)
			if p1 == "NASCAR1" then
				Customize.Apply({
					Name = "NASCAR1"
				}, "Texture", t)
			elseif p1 == "NASCAR2" then
				Customize.Apply({
					Name = "NASCAR2"
				}, "Texture", t)
			elseif p1 == "MCL36" then
				Customize.Apply({
					Name = "MCL36"
				}, "Texture", t)
			elseif p1 == "NASCAR75th" then
				Customize.Apply({
					Name = "NASCAR75th"
				}, "Texture", t)
			else
				Customize.Apply(nil, "Texture", t)
			end
			Customize.Apply({
				Name = "Black"
			}, "WindowColor", t)
			Customize.Apply({
				Name = "Black"
			}, "WheelColor", t)
			PartUtils.setAnchored(v5, true)
		end
		return v5
	end
	error("Could not find vehicle model: " .. p1)
end