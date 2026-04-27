local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
return function(parentContainer)
	local AppComponent = Roact.Component:extend("App")
	local Elapsed = require(script.Parent.Elapsed)
	function AppComponent.init(self)  end
	function AppComponent.render(self)
		return Roact.createElement(Elapsed, {
			createdAt = workspace:GetServerTimeNow() + 20,
			alwaysShowMinutes = false,
			countDown = true
		})
	end
	function AppComponent.willUnmount(self)  end
	local mountedComponent = Roact.mount(Roact.createElement(AppComponent), parentContainer)
	return function()
		Roact.unmount(mountedComponent)
	end
end
