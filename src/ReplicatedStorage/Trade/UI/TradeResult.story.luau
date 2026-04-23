local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
return function(p1) --[[ Line: 5 | Upvalues: Roact (copy), ReplicatedStorage (copy), RoactRodux (copy) ]]
	local v1 = Roact.Component:extend("App")
	local store = require(ReplicatedStorage.App.store)
	local TradeResult = require(script.Parent.TradeResult)
	function v1.init(p1) --[[ Line: 9 | Upvalues: store (copy) ]]
		store:dispatch({
			type = "setTradeResult",
			value = {
				success = true,
				title = "Hello",
				body = "World"
			}
		})
	end
	function v1.render(p1) --[[ Line: 19 | Upvalues: Roact (ref), RoactRodux (ref), store (copy), TradeResult (copy) ]]
		return Roact.createElement(RoactRodux.StoreProvider, {
			store = store
		}, { Roact.createElement(TradeResult, {}) })
	end
	function v1.willUnmount(p1) --[[ Line: 26 ]] end
	local v2 = Roact.mount(Roact.createElement(v1), p1)
	return function() --[[ Line: 29 | Upvalues: Roact (ref), v2 (copy) ]]
		Roact.unmount(v2)
	end
end