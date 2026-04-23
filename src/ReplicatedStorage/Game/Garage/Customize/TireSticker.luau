local ReplicatedStorage = game:GetService("ReplicatedStorage")
return function(p1, p2) --[[ Line: 3 | Upvalues: ReplicatedStorage (copy) ]]
	local Type = p2.Type
	local Model = p2.Model
	local function UpdateWheel(p12) --[[ Line: 7 | Upvalues: p2 (copy), p1 (copy), ReplicatedStorage (ref) ]]
		assert(p12 ~= nil, "WheelModel is nil")
		if p12:FindFirstChild("Wheel") then
			warn("Missing TireMesh, still using old Wheel format: " .. p2.Make)
			return
		end
		local TireMesh = p12:FindFirstChild("TireMesh")
		if p1 and p1.TextureId then
			local v2 = TireMesh:QueryDescendants("Decal")
			if #v2 > 0 then
				for v3, v4 in v2 do
					v4.Texture = ("rbxassetid://%d"):format(p1.TextureId)
					v4.Color3 = p1.DecalColor or Color3.new(255/255, 255/255, 255/255)
				end
			else
				local Decal = Instance.new("Decal")
				Decal.Color3 = p1.DecalColor or Color3.new(255/255, 255/255, 255/255)
				Decal.Face = Enum.NormalId.Left
				Decal.Texture = ("rbxassetid://%d"):format(p1.TextureId)
				Decal.Parent = TireMesh:FindFirstChild("Dual1") or TireMesh
				local v7 = Decal:Clone()
				v7.Face = Enum.NormalId.Right
				v7.Parent = TireMesh:FindFirstChild("Dual2") or TireMesh
			end
		else
			for v8, v9 in TireMesh:QueryDescendants("Decal") do
				v9:Destroy()
			end
		end
		if p1 and p1.ParticleEmitterName then
			local ParticleEmitterName = p1.ParticleEmitterName
			if TireMesh:FindFirstChild(ParticleEmitterName) then
				return
			end
			local v10 = ReplicatedStorage.Resource.TireStickerParticles:FindFirstChild(ParticleEmitterName)
			if v10 then
				v10:Clone().Parent = TireMesh
			end
		else
			for v11, v12 in TireMesh:GetChildren() do
				if v12:IsA("ParticleEmitter") then
					v12:Destroy()
				end
			end
		end
	end
	if Type == "Chassis" then
		for v1, v2 in Model:GetDescendants() do
			if v2:IsA("Model") and (v2.Name:sub(1, 5) == "Wheel" and v2.Name ~= "Wheels") then
				UpdateWheel(v2)
			end
		end
	elseif Type == "DuneBuggy" then
		for v3, v4 in next, { "FrontLeft", "FrontRight", "BackLeft", "BackRight" } do
			UpdateWheel((Model.WheelModels:FindFirstChild(v4)))
		end
	elseif Type == "Motorcycle" then
		for v5, v6 in next, { "Back", "Front" } do
			UpdateWheel((Model.WheelModels:FindFirstChild(v6)))
		end
	end
end