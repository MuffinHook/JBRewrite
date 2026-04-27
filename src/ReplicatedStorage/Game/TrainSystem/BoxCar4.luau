local BoxCar = require(script.Parent.BoxCar)
return {
	MakeCar = function(car)
		return BoxCar.MakeCar(car)
	end,
	MoveCar = function(car, position, rotation, speed)
		return BoxCar.MoveCar(car, position, rotation, speed)
	end,
	DestroyCar = function(car)
		return BoxCar.DestroyCar(car)
	end
}
