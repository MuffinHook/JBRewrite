local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
return function(p1) --[[ Line: 5 | Upvalues: Roact (copy), ReplicatedStorage (copy), RoactRodux (copy) ]]
	local v1 = Roact.Component:extend("App")
	local store = require(ReplicatedStorage.App.store)
	local Trade = require(script.Parent.Trade)
	function v1.init(p1) --[[ Line: 9 | Upvalues: store (copy) ]]
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
	function v1.render(p1) --[[ Line: 27 | Upvalues: Roact (ref), RoactRodux (ref), store (copy), Trade (copy) ]]
		return Roact.createElement(RoactRodux.StoreProvider, {
			store = store
		}, { Roact.createElement(Trade, {}) })
	end
	function v1.willUnmount(p1) --[[ Line: 34 ]] end
	local v2 = Roact.mount(Roact.createElement(v1), p1)
	return function() --[[ Line: 37 | Upvalues: Roact (ref), v2 (copy) ]]
		Roact.unmount(v2)
	end
end