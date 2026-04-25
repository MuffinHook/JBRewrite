-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return function(p1, p2)
	local Type = p2.Type
	local Model = p2.Model
	local function UpdateWheel(p12)
		assert(p12 ~= nil, "WheelModel is nil")
		if p12:FindFirstChild("Wheel") then
			warn("Missing TireMesh, still using old Wheel format: " .. p2.Make)
			return
		end
		local TireMesh = p12:FindFirstChild("TireMesh")
		if p1 and p1.TextureId then
			local decals = TireMesh:QueryDescendants("Decal")
			if #decals > 0 then
				for v3, decal in decals do
					decal.Texture = ("rbxassetid://%d"):format(p1.TextureId)
					decal.Color3 = p1.DecalColor or Color3.new(255/255, 255/255, 255/255)
				end
			else
				local Decal = Instance.new("Decal")
				Decal.Color3 = p1.DecalColor or Color3.new(255/255, 255/255, 255/255)
				Decal.Face = Enum.NormalId.Left
				Decal.Texture = ("rbxassetid://%d"):format(p1.TextureId)
				Decal.Parent = TireMesh:FindFirstChild("Dual1") or TireMesh
				local decalClone = Decal:Clone()
				decalClone.Face = Enum.NormalId.Right
				decalClone.Parent = TireMesh:FindFirstChild("Dual2") or TireMesh
			end
		else
			for v8, decal in TireMesh:QueryDescendants("Decal") do
				decal:Destroy()
			end
		end
		if p1 and p1.ParticleEmitterName then
			local ParticleEmitterName = p1.ParticleEmitterName
			if TireMesh:FindFirstChild(ParticleEmitterName) then
				return
			end
			local particleEmitter = ReplicatedStorage.Resource.TireStickerParticles:FindFirstChild(ParticleEmitterName)
			if particleEmitter then
				particleEmitter:Clone().Parent = TireMesh
			end
		else
			for v11, child in TireMesh:GetChildren() do
				if child:IsA("ParticleEmitter") then
					child:Destroy()
				end
			end
		end
	end
	if Type == "Chassis" then
		for v1, descendant in Model:GetDescendants() do
			if descendant:IsA("Model") and (descendant.Name:sub(1, 5) == "Wheel" and descendant.Name ~= "Wheels") then
				UpdateWheel(descendant)
			end
		end
	elseif Type == "DuneBuggy" then
		for v3, wheelName in next, { "FrontLeft", "FrontRight", "BackLeft", "BackRight" } do
			UpdateWheel((Model.WheelModels:FindFirstChild(wheelName)))
		end
	elseif Type == "Motorcycle" then
		for v5, wheelName in next, { "Back", "Front" } do
			UpdateWheel((Model.WheelModels:FindFirstChild(wheelName)))
		end
	end
end
