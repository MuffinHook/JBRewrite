-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ProgressBar = require(script.Parent.ProgressBar)
local Roact = require(ReplicatedStorage.Roact)
return function(target)
	local AppComponent = Roact.Component:extend("App")
	function AppComponent.init(props)  end
	function AppComponent.render(props)
		return Roact.createElement(ProgressBar, {})
	end
	function AppComponent.willUnmount(props)  end
	local mountedInstance = Roact.mount(Roact.createElement(AppComponent), target)
	return function()
		Roact.unmount(mountedInstance)
	end
end
