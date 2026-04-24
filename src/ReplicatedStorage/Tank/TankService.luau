-- Reviewed by Claude
local TankBinder = require(script.Parent.TankBinder)
return {
	init = function()
		TankBinder:Start()
	end,
	vehicleEnter = function(p1)  end,
	vehicleLeave = function(p1)  end
}
