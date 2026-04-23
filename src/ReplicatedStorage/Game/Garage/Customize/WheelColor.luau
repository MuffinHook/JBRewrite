local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Paint = require(ReplicatedStorage.Game.Garage.Paint)
local HyperChromeConsts = require(ReplicatedStorage.HyperChrome.HyperChromeConsts)
local HyperChromeUtils = require(ReplicatedStorage.HyperChrome.HyperChromeUtils)
return function(p1, p2, p3) --[[ Line: 7 | Upvalues: ReplicatedStorage (copy), Paint (copy), CollectionService (copy), HyperChromeUtils (copy), HyperChromeConsts (copy) ]]
	local Type = p2.Type
	local Make = p2.Make
	local Model = p2.Model
	local v1 = if p1 then p1.Name else "Grey"
	local v2 = p3 and p3.Rim or "Blade"
	local v3 = ReplicatedStorage.Resource.Rims:FindFirstChild(v2)
	local t = {
		DefaultReflectance = v3.Reflectance,
		DefaultMaterial = v3.Material
	}
	local function UpdateRim(p1) --[[ Line: 24 | Upvalues: Paint (ref), v1 (ref), t (copy), v2 (copy), Make (copy), CollectionService (ref), HyperChromeUtils (ref), HyperChromeConsts (ref) ]]
		Paint.Part(p1, v1, t)
		if v2 == "Storm" or (v2 == "HatchVoids" or v2 == "INF1N1TY") then
			for v12, v22 in p1:GetDescendants() do
				if v22:IsA("ParticleEmitter") then
					v22.Color = ColorSequence.new(p1.Color)
				end
			end
		end
		if (Make == "Katana" or Make == "JBX0031") and p1.Parent.Name:find("Back") then
			p1.Color = Color3.fromRGB(0, 0, 0)
		end
		if not CollectionService:HasTag(p1, "VehicleColorPart") then
			CollectionService:AddTag(p1, "VehicleColorPart")
		end
		if HyperChromeUtils.isHyperChromeName(v1) then
			p1:SetAttribute(HyperChromeConsts.HYPERCHROME_NAME_ATTRIBUTE_NAME, v1)
		else
			p1:SetAttribute(HyperChromeConsts.HYPERCHROME_NAME_ATTRIBUTE_NAME, nil)
		end
	end
	if Type == "Chassis" then
		for v4, v5 in Model:GetDescendants() do
			if v5:IsA("Model") and v5.Name:sub(1, 5) == "Wheel" then
				local Rim = v5:FindFirstChild("Rim")
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
		for v6, v7 in next, { "FrontLeft", "FrontRight", "BackLeft", "BackRight" } do
			local v8 = Model.WheelModels:FindFirstChild(v7)
			local v9 = next
			local v10, v11 = v8:GetChildren()
			for v12, v13 in v9, v10, v11 do
				if v13.Name == "Rim" then
					UpdateRim(v13)
				end
			end
		end
	elseif Type == "Motorcycle" then
		for v14, v15 in next, { "Back", "Front" } do
			local v16 = Model.WheelModels:FindFirstChild(v15)
			local v17 = next
			local v18, v19 = v16:GetChildren()
			for v20, v21 in v17, v18, v19 do
				if v21.Name == "RimLeft" or v21.Name == "RimRight" then
					UpdateRim(v21)
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