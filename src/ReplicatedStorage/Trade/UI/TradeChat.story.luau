local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
return function(parentElement)
	local AppComponent = Roact.Component:extend("App")
	local TradeChat = require(script.Parent.TradeChat)
	function AppComponent.init(parentElement)  end
	function AppComponent.render(parentElement)
		return Roact.createElement(TradeChat, {
			size = UDim2.new(1, 0, 1, 0)
		})
	end
	function AppComponent.willUnmount(parentElement)  end
	local mountedInstance = Roact.mount(Roact.createElement(AppComponent), parentElement)
	return function()
		Roact.unmount(mountedInstance)
	end
end
