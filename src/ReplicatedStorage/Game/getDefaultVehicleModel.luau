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
	local var3 = ReplicatedStorage.Resource.Vehicles:FindFirstChild(p1) or ReplicatedStorage.Resource.Plane:FindFirstChild(p1) or ReplicatedStorage.Resource.Boat:FindFirstChild(p1)
	if var3 then
		local var4 = var3:Clone()
		local var5 = var4
		for v7, v8 in var4:GetDescendants() do
			local v6
			if v8:IsA("Model") and (v8.Name:sub(1, 5) == "Wheel" and (v8.Name ~= "Wheels" and v8.Name ~= "WheelModels")) then
				local var9 = v8:FindFirstChild("Wheel") or v8:FindFirstChild("WheelRoot")
				if not var9 then
					print("could not find wheelRoot in", v8:GetFullName())
				end
				v6 = var9 ~= nil
				assert(v6, "could not find wheelRoot")
				v8.PrimaryPart = var9
			end
		end
		local WheelModels = var5:FindFirstChild("WheelModels")
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
		var5.PrimaryPart = var5.BoundingBox
		var5:SetPrimaryPartCFrame(CFrame.new())
		if var5:FindFirstChild("Spoiler") then
			var5.Spoiler.Transparency = 1
		end
		if var5:FindFirstChild("PoliceLights") then
			var5.PoliceLights.Transparency = 1
		end
		if p2 ~= "Chassis3" then
			local t = {
				Make = p1,
				Type = p2,
				Model = var5
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
			PartUtils.setAnchored(var5, true)
		end
		return var5
	end
	error("Could not find vehicle model: " .. p1)
end