local BoxCar = require(script.Parent.BoxCar)
return {
	MakeCar = function(player)
		return BoxCar.MakeCar(player)
	end,
	MoveCar = function(player, p2, p3, p4)
		return BoxCar.MoveCar(player, p2, p3, p4)
	end,
	DestroyCar = function(player)
		return BoxCar.DestroyCar(player)
	end
}
