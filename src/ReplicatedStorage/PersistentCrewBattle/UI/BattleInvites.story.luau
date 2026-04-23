local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
return function(p1) --[[ Line: 5 | Upvalues: Roact (copy), ReplicatedStorage (copy), RoactRodux (copy) ]]
	local v1 = Roact.Component:extend("App")
	local BattleInvites = require(script.Parent.BattleInvites)
	local persistentCrewStore = require(ReplicatedStorage.PersistentCrew.persistentCrewStore)
	function v1.init(p1) --[[ Line: 9 | Upvalues: persistentCrewStore (copy) ]]
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
	function v1.render(p1) --[[ Line: 30 | Upvalues: Roact (ref), RoactRodux (ref), persistentCrewStore (copy), BattleInvites (copy) ]]
		return Roact.createElement(RoactRodux.StoreProvider, {
			store = persistentCrewStore
		}, { Roact.createElement(BattleInvites, {
				onAccept = function(p1) --[[ Name: onAccept | Line: 35 ]]
					print("accept", p1)
				end,
				onDecline = function(p1) --[[ Name: onDecline | Line: 38 ]]
					print("decline", p1)
				end
			}) })
	end
	function v1.willUnmount(p1) --[[ Line: 44 ]] end
	local v2 = Roact.mount(Roact.createElement(v1), p1)
	return function() --[[ Line: 47 | Upvalues: Roact (ref), v2 (copy) ]]
		Roact.unmount(v2)
	end
end