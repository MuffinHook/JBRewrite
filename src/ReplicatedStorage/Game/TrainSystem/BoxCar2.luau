-- Reviewed by Claude
local BoxCar = require(script.Parent.BoxCar)
return {
	MakeCar = function(p1)
		return BoxCar.MakeCar(p1)
	end,
	MoveCar = function(p1, p2, p3, p4)
		return BoxCar.MoveCar(p1, p2, p3, p4)
	end,
	DestroyCar = function(p1)
		return BoxCar.DestroyCar(p1)
	end
}
