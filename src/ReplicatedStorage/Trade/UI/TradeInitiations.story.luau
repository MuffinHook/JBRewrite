local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
return function(p1) --[[ Line: 5 | Upvalues: Roact (copy), ReplicatedStorage (copy), RoactRodux (copy) ]]
	local v1 = Roact.Component:extend("App")
	local TradeInitiations = require(script.Parent.TradeInitiations)
	local store = require(ReplicatedStorage.App.store)
	function v1.init(p1) --[[ Line: 9 | Upvalues: store (copy) ]]
		store:dispatch({
			type = "tradeInitiationsSet",
			list = {
				{
					name = "badcc",
					userId = 1
				},
				{
					name = "asimo3089",
					userId = 2
				},
				{
					name = "TWENTYMOREMINUTES",
					userId = 3
				}
			}
		})
	end
	function v1.render(p1) --[[ Line: 28 | Upvalues: Roact (ref), RoactRodux (ref), store (copy), TradeInitiations (copy) ]]
		return Roact.createElement(RoactRodux.StoreProvider, {
			store = store
		}, { Roact.createElement(TradeInitiations, {
				onAccept = function(p1) --[[ Name: onAccept | Line: 33 ]]
					print("accept", p1)
				end,
				onDecline = function(p1) --[[ Name: onDecline | Line: 36 ]]
					print("decline", p1)
				end
			}) })
	end
	function v1.willUnmount(p1) --[[ Line: 42 ]] end
	local v2 = Roact.mount(Roact.createElement(v1), p1)
	return function() --[[ Line: 45 | Upvalues: Roact (ref), v2 (copy) ]]
		Roact.unmount(v2)
	end
end