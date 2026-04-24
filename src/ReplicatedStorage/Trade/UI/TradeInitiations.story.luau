-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
return function(p1)
	local v1 = Roact.Component:extend("App")
	local TradeInitiations = require(script.Parent.TradeInitiations)
	local store = require(ReplicatedStorage.App.store)
	function v1.init(p1)
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
	function v1.render(p1)
		return Roact.createElement(RoactRodux.StoreProvider, {
			store = store
		}, { Roact.createElement(TradeInitiations, {
				onAccept = function(p1)
					print("accept", p1)
				end,
				onDecline = function(p1)
					print("decline", p1)
				end
			}) })
	end
	function v1.willUnmount(p1)  end
	local v2 = Roact.mount(Roact.createElement(v1), p1)
	return function()
		Roact.unmount(v2)
	end
end
