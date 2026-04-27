local TankBinder = require(script.Parent.TankBinder)
return {
	init = function()
		TankBinder:Start()
	end,
	vehicleEnter = function(player)  end,
	vehicleLeave = function(player)  end
}
