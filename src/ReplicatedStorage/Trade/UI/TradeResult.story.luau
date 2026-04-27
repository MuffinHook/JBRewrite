local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
return function(containerElement)
	local AppComponent = Roact.Component:extend("App")
	local store = require(ReplicatedStorage.App.store)
	local TradeResult = require(script.Parent.TradeResult)
	function AppComponent.init(self)
		store:dispatch({
			type = "setTradeResult",
			value = {
				success = true,
				title = "Hello",
				body = "World"
			}
		})
	end
	function AppComponent.render(self)
		return Roact.createElement(RoactRodux.StoreProvider, {
			store = store
		}, { Roact.createElement(TradeResult, {}) })
	end
	function AppComponent.willUnmount(self)  end
	local mountedComponentHandle = Roact.mount(Roact.createElement(AppComponent), containerElement)
	return function()
		Roact.unmount(mountedComponentHandle)
	end
end
