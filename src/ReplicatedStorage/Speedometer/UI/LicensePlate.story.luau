local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
return function(parentContainer)
	local LicensePlate = require(script.Parent.LicensePlate)
	local componentHandle = Roact.mount(Roact.createElement(LicensePlate, {
		size = UDim2.new(0.5, 0, 0.5, 0),
		position = UDim2.new(0.25, 0, 0.25, 0)
	}), parentContainer)
	return function()
		Roact.unmount(componentHandle)
	end
end
