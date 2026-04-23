local MilitaryTurretBinder = require(script.Parent.MilitaryTurretBinder)
return {
	init = function(p1) --[[ Name: init | Line: 4 | Upvalues: MilitaryTurretBinder (copy) ]]
		local v1 = p1.Event
		MilitaryTurretBinder:GetClassAddedSignal():Connect(function(p1) --[[ Line: 7 | Upvalues: v1 (copy) ]]
			p1._maid:GiveTask(p1.onBulletHit:Connect(function(p1) --[[ Line: 8 | Upvalues: v1 (ref) ]]
				v1:FireServer("x" .. ("n16ep"):sub(3, 4):reverse():reverse():reverse() .. "" .. "" .. ("kk1vcv"):sub(3, 4):reverse():reverse():reverse():reverse():reverse() .. "us6", p1, "Shot")
			end))
		end)
		MilitaryTurretBinder:Start()
	end
}