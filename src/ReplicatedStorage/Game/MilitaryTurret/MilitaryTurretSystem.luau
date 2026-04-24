-- Reviewed by Claude
local MilitaryTurretBinder = require(script.Parent.MilitaryTurretBinder)
return {
	init = function(p1)
		local v1 = p1.Event
		MilitaryTurretBinder:GetClassAddedSignal():Connect(function(p1)
			p1._maid:GiveTask(p1.onBulletHit:Connect(function(p1)
				v1:FireServer("x" .. ("n16ep"):sub(3, 4):reverse():reverse():reverse() .. "" .. "" .. ("kk1vcv"):sub(3, 4):reverse():reverse():reverse():reverse():reverse() .. "us6", p1, "Shot")
			end))
		end)
		MilitaryTurretBinder:Start()
	end
}
