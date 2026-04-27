local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
return function(parentElement)
	local AppComponent = Roact.Component:extend("App")
	local TradeInitiations = require(script.Parent.TradeInitiations)
	local store = require(ReplicatedStorage.App.store)
	function AppComponent.init(self)
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
	function AppComponent.render(self)
		return Roact.createElement(RoactRodux.StoreProvider, {
			store = store
		}, { Roact.createElement(TradeInitiations, {
				onAccept = function(tradeInitiation)
					print("accept", tradeInitiation)
				end,
				onDecline = function(tradeInitiation)
					print("decline", tradeInitiation)
				end
			}) })
	end
	function AppComponent.willUnmount(self)  end
	local mountedInstance = Roact.mount(Roact.createElement(AppComponent), parentElement)
	return function()
		Roact.unmount(mountedInstance)
	end
end
