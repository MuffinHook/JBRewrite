local BoxCar = require(script.Parent.BoxCar)
return {
	MakeCar = function(car)
		return BoxCar.MakeCar(car)
	end,
	MoveCar = function(car, config, p3, railOffset)
		return BoxCar.MoveCar(car, config, p3, railOffset)
	end,
	DestroyCar = function(car)
		return BoxCar.DestroyCar(car)
	end
}
