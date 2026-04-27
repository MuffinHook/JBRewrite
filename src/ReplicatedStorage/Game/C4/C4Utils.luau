local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Std.Audio)
local C4Consts = require(script.Parent.C4Consts)
return {
	getDamageRatio = function(originPosition, targetPosition, blastRadius)
		blastRadius = blastRadius or C4Consts.BLAST_RADIUS
		return 1 - math.clamp((targetPosition - originPosition).Magnitude / blastRadius, 0, 1)
	end,
	explosionVisual = function(explosionPosition)
		local Part = Instance.new("Part")
		Part.Size = Vector3.new(0.1, 0.1, 0.1)
		Part.CanCollide = false
		Part.Anchored = true
		Part.Transparency = 1
		Part.Position = explosionPosition
		Part.Parent = workspace
		game:GetService("Debris"):AddItem(Part, 5)
		local explosionParticles = ReplicatedStorage.Resource.ItemSystem.Projectiles.Explosion:Clone()
		explosionParticles.Parent = Part
		task.delay(0.03333333333333333, function()
			explosionParticles:Emit(4)
		end)
		local debrisParticles = ReplicatedStorage.Resource.ItemSystem.Projectiles.Debris:Clone()
		debrisParticles.Parent = Part
		task.delay(0.03333333333333333, function()
			debrisParticles:Emit(50)
		end)
		local smokeParticles = ReplicatedStorage.Resource.ItemSystem.Projectiles.Smoke:Clone()
		smokeParticles.Parent = Part
		task.delay(0.03333333333333333, function()
			smokeParticles:Emit(3)
		end)
		local landingSmokeEffect = ReplicatedStorage.Resource.ItemSystem.Projectiles.LandingSmoke:Clone()
		landingSmokeEffect.Enabled = true
		landingSmokeEffect.Parent = Part
		task.delay(5 - landingSmokeEffect.Lifetime.Max, function()
			landingSmokeEffect.Enabled = false
		end)
		Audio.ObjectLocal(Part, 2205008239, {
			Volume = 1
		}).EmitterSize = 20
	end
}
