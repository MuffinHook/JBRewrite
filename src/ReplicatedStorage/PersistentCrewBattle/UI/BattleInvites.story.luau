local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
return function(storybook)
	local AppComponent = Roact.Component:extend("App")
	local BattleInvites = require(script.Parent.BattleInvites)
	local persistentCrewStore = require(ReplicatedStorage.PersistentCrew.persistentCrewStore)
	function AppComponent.init(self)
		persistentCrewStore:dispatch({
			type = "battleInvitesSet",
			list = {
				{
					clanName = "CeilingFanCrew",
					battleNumPlayersPerTeam = 5,
					clanRating = 1500,
					opposingClanOwnerName = "badcc",
					ranked = false
				},
				{
					clanName = "BadBoyz",
					battleNumPlayersPerTeam = 4,
					clanRating = 2000,
					opposingClanOwnerName = "badcc",
					ranked = true
				}
			}
		})
	end
	function AppComponent.render(self)
		return Roact.createElement(RoactRodux.StoreProvider, {
			store = persistentCrewStore
		}, { Roact.createElement(BattleInvites, {
				onAccept = function(battleInvite)
					print("accept", battleInvite)
				end,
				onDecline = function(battleInvite)
					print("decline", battleInvite)
				end
			}) })
	end
	function AppComponent.willUnmount(self)  end
	local roactHandle = Roact.mount(Roact.createElement(AppComponent), storybook)
	return function()
		Roact.unmount(roactHandle)
	end
end
