local BoxCar = require(script.Parent.BoxCar)
return {
	MakeCar = function(p1) --[[ Name: MakeCar | Line: 2 | Upvalues: BoxCar (copy) ]]
		return BoxCar.MakeCar(p1)
	end,
	MoveCar = function(p1, p2, p3, p4) --[[ Name: MoveCar | Line: 5 | Upvalues: BoxCar (copy) ]]
		return BoxCar.MoveCar(p1, p2, p3, p4)
	end,
	DestroyCar = function(p1) --[[ Name: DestroyCar | Line: 8 | Upvalues: BoxCar (copy) ]]
		return BoxCar.DestroyCar(p1)
	end
}