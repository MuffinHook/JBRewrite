local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
return function(targetComponent)
	local AppComponent = Roact.Component:extend("App")
	local Tooltip = require(script.Parent.Tooltip)
	function AppComponent.init(targetComponent)
		targetComponent:setState({
			visible = true
		})
	end
	function AppComponent.render(targetComponent)
		return createElement(Tooltip, {
			text = "noice"
		})
	end
	function AppComponent.willUnmount(targetComponent)  end
	local mountedInstance = Roact.mount(Roact.createElement(AppComponent), targetComponent)
	return function()
		Roact.unmount(mountedInstance)
	end
end
