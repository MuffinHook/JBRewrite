local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Std.Audio)
local C4Consts = require(script.Parent.C4Consts)
return {
	getDamageRatio = function(p1, p2, p3) --[[ Name: getDamageRatio | Line: 6 | Upvalues: C4Consts (copy) ]]
		p3 = p3 or C4Consts.BLAST_RADIUS
		return 1 - math.clamp((p2 - p1).Magnitude / p3, 0, 1)
	end,
	explosionVisual = function(p1) --[[ Name: explosionVisual | Line: 14 | Upvalues: ReplicatedStorage (copy), Audio (copy) ]]
		local Part = Instance.new("Part")
		Part.Size = Vector3.new(0.1, 0.1, 0.1)
		Part.CanCollide = false
		Part.Anchored = true
		Part.Transparency = 1
		Part.Position = p1
		Part.Parent = workspace
		game:GetService("Debris"):AddItem(Part, 5)
		local v1 = ReplicatedStorage.Resource.ItemSystem.Projectiles.Explosion:Clone()
		v1.Parent = Part
		task.delay(0.03333333333333333, function() --[[ Line: 31 | Upvalues: v1 (copy) ]]
			v1:Emit(4)
		end)
		local v2 = ReplicatedStorage.Resource.ItemSystem.Projectiles.Debris:Clone()
		v2.Parent = Part
		task.delay(0.03333333333333333, function() --[[ Line: 37 | Upvalues: v2 (copy) ]]
			v2:Emit(50)
		end)
		local v3 = ReplicatedStorage.Resource.ItemSystem.Projectiles.Smoke:Clone()
		v3.Parent = Part
		task.delay(0.03333333333333333, function() --[[ Line: 43 | Upvalues: v3 (copy) ]]
			v3:Emit(3)
		end)
		local v4 = ReplicatedStorage.Resource.ItemSystem.Projectiles.LandingSmoke:Clone()
		v4.Enabled = true
		v4.Parent = Part
		task.delay(5 - v4.Lifetime.Max, function() --[[ Line: 51 | Upvalues: v4 (copy) ]]
			v4.Enabled = false
		end)
		Audio.ObjectLocal(Part, 2205008239, {
			Volume = 1
		}).EmitterSize = 20
	end
}