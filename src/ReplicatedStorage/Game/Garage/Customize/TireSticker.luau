local ReplicatedStorage = game:GetService("ReplicatedStorage")
return function(stickerConfig, vehicleData)
	local Type = vehicleData.Type
	local Model = vehicleData.Model
	local function UpdateWheel(wheelModel)
		assert(wheelModel ~= nil, "WheelModel is nil")
		if wheelModel:FindFirstChild("Wheel") then
			warn("Missing TireMesh, still using old Wheel format: " .. vehicleData.Make)
			return
		end
		local TireMesh = wheelModel:FindFirstChild("TireMesh")
		if stickerConfig and stickerConfig.TextureId then
			local decals = TireMesh:QueryDescendants("Decal")
			if #decals > 0 then
				for decalIndex, decal in decals do
					decal.Texture = ("rbxassetid://%d"):format(stickerConfig.TextureId)
					decal.Color3 = stickerConfig.DecalColor or Color3.new(255/255, 255/255, 255/255)
				end
			else
				local Decal = Instance.new("Decal")
				Decal.Color3 = stickerConfig.DecalColor or Color3.new(255/255, 255/255, 255/255)
				Decal.Face = Enum.NormalId.Left
				Decal.Texture = ("rbxassetid://%d"):format(stickerConfig.TextureId)
				Decal.Parent = TireMesh:FindFirstChild("Dual1") or TireMesh
				local decalClone = Decal:Clone()
				decalClone.Face = Enum.NormalId.Right
				decalClone.Parent = TireMesh:FindFirstChild("Dual2") or TireMesh
			end
		else
			for decalIndex, decal in TireMesh:QueryDescendants("Decal") do
				decal:Destroy()
			end
		end
		if stickerConfig and stickerConfig.ParticleEmitterName then
			local ParticleEmitterName = stickerConfig.ParticleEmitterName
			if TireMesh:FindFirstChild(ParticleEmitterName) then
				return
			end
			local particleEmitter = ReplicatedStorage.Resource.TireStickerParticles:FindFirstChild(ParticleEmitterName)
			if particleEmitter then
				particleEmitter:Clone().Parent = TireMesh
			end
		else
			for childIndex, child in TireMesh:GetChildren() do
				if child:IsA("ParticleEmitter") then
					child:Destroy()
				end
			end
		end
	end
	if Type == "Chassis" then
		for descendantIndex, descendant in Model:GetDescendants() do
			if descendant:IsA("Model") and (descendant.Name:sub(1, 5) == "Wheel" and descendant.Name ~= "Wheels") then
				UpdateWheel(descendant)
			end
		end
	elseif Type == "DuneBuggy" then
		for wheelIndex, wheelName in next, { "FrontLeft", "FrontRight", "BackLeft", "BackRight" } do
			UpdateWheel((Model.WheelModels:FindFirstChild(wheelName)))
		end
	elseif Type == "Motorcycle" then
		for wheelIndex, wheelName in next, { "Back", "Front" } do
			UpdateWheel((Model.WheelModels:FindFirstChild(wheelName)))
		end
	end
end
