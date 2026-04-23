-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
return function(p1)
	local v1 = Roact.Component:extend("App")
	local Grid = require(script.Parent.Grid)
	function v1.init(p1)
		p1:setState({
			countInner = 3,
			countOuter = 4
		})
	end
	function v1.render(p1)
		return Roact.createElement(Grid, {
			position = UDim2.new(1, 0, 1, 0),
			anchorPoint = Vector2.new(1, 1),
			size = UDim2.new(0.2, 0, 0.5, 0),
			countInner = p1.state.countInner,
			countOuter = p1.state.countOuter
		})
	end
	function v1.willUnmount(p1)end
	local v2 = Roact.mount(Roact.createElement(v1), p1)
	return function()
		Roact.unmount(v2)
	end
end