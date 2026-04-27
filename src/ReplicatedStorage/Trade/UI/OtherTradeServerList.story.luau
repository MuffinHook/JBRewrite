local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Clan.ClanConsts)
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
return function(storybook)
	local App = Roact.Component:extend("App")
	local OtherTradeServerList = require(script.Parent.OtherTradeServerList)
	local persistentCrewStore = require(ReplicatedStorage.PersistentCrew.persistentCrewStore)
	local OtherTradeServerUIData = require(ReplicatedStorage.Trade.Test.OtherTradeServerUIData)
	function App.init(state)
		state.aspectRatio = 1.5
		state.otherTradeServerInfo = OtherTradeServerUIData.otherTradeServerInfo
	end
	function App.render(state)
		return Roact.createElement(RoactRodux.StoreProvider, {
			store = persistentCrewStore
		}, { Roact.createElement("Frame", {
				Size = UDim2.fromScale(1, 1)
			}, {
				x = Roact.createElement(OtherTradeServerList, {
					otherTradeServerInfo = state.otherTradeServerInfo,
					onJoinOtherTradeServer = function(serverId)
						print("CLICK.. join server id", serverId)
					end,
					aspectRatio = state.aspectRatio,
					visible = true,
					size = UDim2.fromScale(1, 1),
					position = UDim2.fromScale(0.5, 0.5)
				}),
				Aspect = Roact.createElement("UIAspectRatioConstraint", {
					AspectRatio = state.aspectRatio
				})
			}) })
	end
	local mountedComponent = Roact.mount(Roact.createElement(App), storybook)
	return function()
		Roact.unmount(mountedComponent)
	end
end
