local TankBinder = require(script.Parent.TankBinder)
return {
	init = function() --[[ Name: init | Line: 4 | Upvalues: TankBinder (copy) ]]
		TankBinder:Start()
	end,
	vehicleEnter = function(p1) --[[ Name: vehicleEnter | Line: 8 ]] end,
	vehicleLeave = function(p1) --[[ Name: vehicleLeave | Line: 9 ]] end
}