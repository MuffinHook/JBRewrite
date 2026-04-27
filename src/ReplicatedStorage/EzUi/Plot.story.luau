local Roact = require(script:FindFirstAncestor("EzUi").Parent.Roact)
return function(parentInstance)
	local _, _2 = Roact.createBinding(0)
	local Plot = require(script.Parent.Plot)
	local componentInstance = Roact.mount(Roact.createElement(Plot, {
		size = UDim2.new(0.5, 0, 0.5, 0),
		position = UDim2.new(0.25, 0, 0.25, 0),
		window = { 0, 0, 100, 100 }
	}), parentInstance)
	return function()
		Roact.unmount(componentInstance)
	end
end
