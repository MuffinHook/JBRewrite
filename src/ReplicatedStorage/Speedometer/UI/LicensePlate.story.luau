local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
return function(p1) --[[ Line: 4 | Upvalues: Roact (copy) ]]
	local LicensePlate = require(script.Parent.LicensePlate)
	local v1 = Roact.mount(Roact.createElement(LicensePlate, {
		size = UDim2.new(0.5, 0, 0.5, 0),
		position = UDim2.new(0.25, 0, 0.25, 0)
	}), p1)
	return function() --[[ Line: 13 | Upvalues: Roact (ref), v1 (copy) ]]
		Roact.unmount(v1)
	end
end