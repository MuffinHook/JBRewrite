-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
return function(p1)
	local v1 = Roact.Component:extend("App")
	local BattleInvites = require(script.Parent.BattleInvites)
	local persistentCrewStore = require(ReplicatedStorage.PersistentCrew.persistentCrewStore)
	function v1.init(p1)
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
	function v1.render(p1)
		return Roact.createElement(RoactRodux.StoreProvider, {
			store = persistentCrewStore
		}, { Roact.createElement(BattleInvites, {
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
