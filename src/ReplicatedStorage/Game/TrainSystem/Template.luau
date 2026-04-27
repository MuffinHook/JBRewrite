game:GetService("ReplicatedStorage")
local Default = require(script.Parent.Default)
return {
	MakeCar = function(car)
		return Default.MakeCar(car)
	end,
	MoveCar = function(car, settings, destination, options)
		local Speed = settings.Speed
		return Default.MoveCar(car, settings, destination, options)
	end,
	DestroyCar = function(car)
		return Default.DestroyCar(car)
	end
}
