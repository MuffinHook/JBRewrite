local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
return function(parent)
	local AppComponent = Roact.Component:extend("App")
	local BigButton = require(script.Parent.BigButton)
	function AppComponent.init(self)end
	function AppComponent.render(self)
		return Roact.createElement(BigButton, {
			count = 3,
			imageId = 4912231216
		})
	end
	function AppComponent.willUnmount(self)end
	local mountedComponent = Roact.mount(Roact.createElement(AppComponent), parent)
	return function()
		Roact.unmount(mountedComponent)
	end
end
