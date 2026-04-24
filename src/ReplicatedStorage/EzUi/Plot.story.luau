-- Reviewed by Claude
local Roact = require(script:FindFirstAncestor("EzUi").Parent.Roact)
return function(p1)
	local _, _2 = Roact.createBinding(0)
	local Plot = require(script.Parent.Plot)
	local v1 = Roact.mount(Roact.createElement(Plot, {
		size = UDim2.new(0.5, 0, 0.5, 0),
		position = UDim2.new(0.25, 0, 0.25, 0),
		window = { 0, 0, 100, 100 }
	}), p1)
	return function()
		Roact.unmount(v1)
	end
end
