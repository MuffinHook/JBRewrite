local ReplicatedStorage = game:GetService("ReplicatedStorage")
return function(p1, p2, p3, p4) --[[ Line: 3 | Upvalues: ReplicatedStorage (copy) ]]
	if not p1 then
		warn("Drift Item not found, using default")
		p1 = {
			Name = "Classic"
		}
	end
	local v1 = ReplicatedStorage.Resource:FindFirstChild("DriftParticles"):FindFirstChild(p1.Name):GetChildren()
	local t = {}
	for v2, v3 in p2.Model:FindFirstChild("Preset"):GetChildren() do
		if v3.Name == "Drift" then
			table.insert(t, v3)
		end
	end
	for v4, v5 in t do
		for v6, v7 in v5:GetChildren() do
			if v7:IsA("ParticleEmitter") then
				v7:Destroy()
			end
		end
		for v8, v9 in v1 do
			if v9:IsA("ParticleEmitter") then
				local ParticleEmitter = v9:Clone()
				ParticleEmitter.Name = "ParticleEmitter"
				ParticleEmitter.Enabled = false
				ParticleEmitter.EmissionDirection = Enum.NormalId.Back
				if p4 and p4.IsEditing then
					ParticleEmitter.Rate = 36
					ParticleEmitter.Speed = NumberRange.new(15)
					ParticleEmitter.Enabled = true
				end
				ParticleEmitter.Parent = v5
			end
		end
	end
end