-- Reviewed by Claude
-- variables reassigned
local Roact = require(script:FindFirstAncestor("EzUi").Parent.Roact)
return function(story)
	local AppComponent = Roact.Component:extend("App")
	local Checkbox = require(script.Parent.Checkbox)
	function AppComponent.init(self)
		self:setState({
			checked = false
		})
	end
	function AppComponent.render(self)
		return Roact.createElement(Checkbox, {
			size = UDim2.new(0, 30, 0, 30),
			position = UDim2.new(0.25, 0, 0.5, 0),
			value = self.state.checked,
			onChecked = function(isChecked)
				self:setState({
					checked = isChecked
				})
			end
		})
	end
	local mountedInstance = Roact.mount(Roact.createElement(AppComponent), story)
	return function()
		Roact.unmount(mountedInstance)
	end
end
