-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
return function(p1, p2, p3, p4)
	if not p1 then
		warn("Drift Item not found, using default")
		p1 = {
			Name = "Classic"
		}
	end
	local driftParticlesList = ReplicatedStorage.Resource:FindFirstChild("DriftParticles"):FindFirstChild(p1.Name):GetChildren()
	local driftPresets = {}
	for presetIndex, presetChild in p2.Model:FindFirstChild("Preset"):GetChildren() do
		if presetChild.Name == "Drift" then
			table.insert(driftPresets, presetChild)
		end
	end
	for presetIdx, presetObj in driftPresets do
		for childIdx, childObj in presetObj:GetChildren() do
			if childObj:IsA("ParticleEmitter") then
				childObj:Destroy()
			end
		end
		for particleIdx, particleObj in driftParticlesList do
			if particleObj:IsA("ParticleEmitter") then
				local ParticleEmitter = particleObj:Clone()
				ParticleEmitter.Name = "ParticleEmitter"
				ParticleEmitter.Enabled = false
				ParticleEmitter.EmissionDirection = Enum.NormalId.Back
				if p4 and p4.IsEditing then
					ParticleEmitter.Rate = 36
					ParticleEmitter.Speed = NumberRange.new(15)
					ParticleEmitter.Enabled = true
				end
				ParticleEmitter.Parent = presetObj
			end
		end
	end
end
