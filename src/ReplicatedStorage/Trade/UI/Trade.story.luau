local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
return function(target)
	local AppComponent = Roact.Component:extend("App")
	local store = require(ReplicatedStorage.App.store)
	local Trade = require(script.Parent.Trade)
	function AppComponent.init(target)
		store:dispatch({
			type = "updateTraderMe",
			userId = 2025110,
			displayName = "badcc",
			ready = true
		})
		store:dispatch({
			type = "updateTraderThem",
			userId = 2837719,
			displayName = "asimo3089",
			ready = false
		})
		store:dispatch({
			type = "setTradeActive",
			value = true
		})
	end
	function AppComponent.render(target)
		return Roact.createElement(RoactRodux.StoreProvider, {
			store = store
		}, { Roact.createElement(Trade, {}) })
	end
	function AppComponent.willUnmount(target)  end
	local mountedInstance = Roact.mount(Roact.createElement(AppComponent), target)
	return function()
		Roact.unmount(mountedInstance)
	end
end
