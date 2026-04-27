local MilitaryTurretBinder = require(script.Parent.MilitaryTurretBinder)
return {
	init = function(gameServices)
		local event = gameServices.Event
		MilitaryTurretBinder:GetClassAddedSignal():Connect(function(turretInstance)
			turretInstance._maid:GiveTask(turretInstance.onBulletHit:Connect(function(bulletData)
				event:FireServer("xe6v1us6", bulletData, "Shot")
			end))
		end)
		MilitaryTurretBinder:Start()
	end
}
