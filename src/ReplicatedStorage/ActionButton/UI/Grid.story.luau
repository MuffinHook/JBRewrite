local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
return function(target)
	local AppComponent = Roact.Component:extend("App")
	local Grid = require(script.Parent.Grid)
	function AppComponent.init(self)
		self:setState({
			countInner = 3,
			countOuter = 4
		})
	end
	function AppComponent.render(self)
		return Roact.createElement(Grid, {
			position = UDim2.new(1, 0, 1, 0),
			anchorPoint = Vector2.new(1, 1),
			size = UDim2.new(0.2, 0, 0.5, 0),
			countInner = self.state.countInner,
			countOuter = self.state.countOuter
		})
	end
	function AppComponent.willUnmount(self)end
	local mountId = Roact.mount(Roact.createElement(AppComponent), target)
	return function()
		Roact.unmount(mountId)
	end
end