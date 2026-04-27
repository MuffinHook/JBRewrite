local ReplicatedStorage = game:GetService("ReplicatedStorage")
return function(driftItem, vehicleModel, p3, options)
	if not driftItem then
		warn("Drift Item not found, using default")
		driftItem = {
			Name = "Classic"
		}
	end
	local driftParticlesList = ReplicatedStorage.Resource:FindFirstChild("DriftParticles"):FindFirstChild(driftItem.Name):GetChildren()
	local driftPresets = {}
	for presetIndex, presetChild in vehicleModel.Model:FindFirstChild("Preset"):GetChildren() do
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
				if options and options.IsEditing then
					ParticleEmitter.Rate = 36
					ParticleEmitter.Speed = NumberRange.new(15)
					ParticleEmitter.Enabled = true
				end
				ParticleEmitter.Parent = presetObj
			end
		end
	end
end
