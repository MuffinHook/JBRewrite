local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
return function(targetContainer)
	local AppComponent = Roact.Component:extend("App")
	local Bounty = require(script.Parent.Bounty)
	function AppComponent.init(self)end
	function AppComponent.render(self)
		return Roact.createElement(Bounty, {
			amount = 1000
		})
	end
	function AppComponent.willUnmount(self)end
	local mountedHandle = Roact.mount(Roact.createElement(AppComponent), targetContainer)
	return function()
		Roact.unmount(mountedHandle)
	end
end
