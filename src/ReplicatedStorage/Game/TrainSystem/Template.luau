-- Reviewed by Claude
game:GetService("ReplicatedStorage")
local Default = require(script.Parent.Default)
return {
	MakeCar = function(p1)
		return Default.MakeCar(p1)
	end,
	MoveCar = function(p1, p2, p3, p4)
		local Speed = p2.Speed
		return Default.MoveCar(p1, p2, p3, p4)
	end,
	DestroyCar = function(p1)
		return Default.DestroyCar(p1)
	end
}
