-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
return function(arg1)
	local local1 = Roact.Component:extend("App")
	local BattleInvites = require(script.Parent.BattleInvites)
	local persistentCrewStore = require(ReplicatedStorage.PersistentCrew.persistentCrewStore)
	function local1.init(arg1)
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
	function local1.render(arg1)
		return Roact.createElement(RoactRodux.StoreProvider, {
			store = persistentCrewStore
		}, { Roact.createElement(BattleInvites, {
				onAccept = function(arg1)
					print("accept", arg1)
				end,
				onDecline = function(arg1)
					print("decline", arg1)
				end
			}) })
	end
	function local1.willUnmount(arg1)  end
	local local2 = Roact.mount(Roact.createElement(local1), arg1)
	return function()
		Roact.unmount(local2)
	end
end
