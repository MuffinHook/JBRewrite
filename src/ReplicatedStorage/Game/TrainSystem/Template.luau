game:GetService("ReplicatedStorage")
local Default = require(script.Parent.Default)
return {
	MakeCar = function(p1) --[[ Name: MakeCar | Line: 4 | Upvalues: Default (copy) ]]
		return Default.MakeCar(p1)
	end,
	MoveCar = function(p1, p2, p3, p4) --[[ Name: MoveCar | Line: 8 | Upvalues: Default (copy) ]]
		local Speed = p2.Speed
		return Default.MoveCar(p1, p2, p3, p4)
	end,
	DestroyCar = function(p1) --[[ Name: DestroyCar | Line: 13 | Upvalues: Default (copy) ]]
		return Default.DestroyCar(p1)
	end
}