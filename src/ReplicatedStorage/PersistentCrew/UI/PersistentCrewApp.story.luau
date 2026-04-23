local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
require(ReplicatedStorage.PersistentCrewBattle.PersistentCrewBattleConsts)
return function(p1) --[[ Line: 7 | Upvalues: Roact (copy), ReplicatedStorage (copy), RoactRodux (copy) ]]
	local v1 = Roact.Component:extend("App")
	local PersistentCrewApp = require(script.Parent.PersistentCrewApp)
	local persistentCrewStore = require(ReplicatedStorage.PersistentCrew.persistentCrewStore)
	persistentCrewStore:dispatch({
		type = "setGroupVisible",
		value = true
	})
	persistentCrewStore:dispatch({
		type = "setRobberiesCompleted",
		value = {
			{
				robberyType = 1,
				robberyCompleted = false
			},
			{
				robberyType = 2,
				robberyCompleted = true
			},
			{
				robberyType = 3,
				robberyCompleted = true
			},
			{
				robberyType = 8,
				robberyCompleted = false
			}
		}
	})
	persistentCrewStore:dispatch({
		type = "setClanName",
		clanId = "aaa",
		value = "Baboyz"
	})
	persistentCrewStore:dispatch({
		type = "setClanName",
		clanId = "bbb",
		value = "Goonz"
	})
	persistentCrewStore:dispatch({
		type = "setViewingClanInfo",
		value = {
			ClanId = "aaa",
			ClanName = "Baboyz",
			DisplayRating = 1500,
			BattlesPlayed = 100,
			BattlesWon = 50,
			AdminIdMap = {}
		}
	})
	persistentCrewStore:dispatch({
		type = "setAttackingClanId",
		value = "bbb"
	})
	persistentCrewStore:dispatch({
		type = "setBattleResponseData",
		value = {
			BattleUniqueId = "123",
			NumPlayersPerTeam = 4,
			OurClanInfo = {
				ClanId = "aaa",
				ClanName = "Baboyz",
				FlagColorStr = "#00FF00",
				OwnerUserId = 1,
				RatingData = {
					LastBattle = 0,
					Rating = 1500,
					RatingDeviation = 10,
					Sigma = 1
				}
			},
			TheirClanInfo = {
				ClanId = "bbb",
				ClanName = "GoodGoonz",
				FlagColorStr = "#FF0000",
				OwnerUserId = 1,
				RatingData = {
					LastBattle = 0,
					Rating = 1500,
					RatingDeviation = 10,
					Sigma = 1
				}
			},
			OurClanAccepted = {
				{
					UserId = 2025110,
					IsAdmin = true
				},
				{
					UserId = 2837719,
					IsAdmin = false
				},
				{
					UserId = 2829005475,
					IsAdmin = false
				},
				{
					UserId = 820499,
					IsAdmin = true
				}
			},
			TheirClanAccepted = {
				{
					UserId = 147296825,
					IsAdmin = true
				},
				{
					UserId = 1721673063,
					IsAdmin = true
				}
			}
		}
	})
	function v1.init(p1) --[[ Line: 157 | Upvalues: persistentCrewStore (copy) ]]
		function p1.attemptLeave() --[[ Line: 162 | Upvalues: persistentCrewStore (ref) ]]
			persistentCrewStore:dispatch({
				type = "setViewingClanInfo",
				value = nil
			})
		end
		function p1.attemptCreate(p1) --[[ Line: 169 | Upvalues: persistentCrewStore (ref) ]]
			persistentCrewStore:dispatch({
				type = "setViewingClanInfo",
				value = {
					ClanName = "Baboyz",
					DisplayRating = 1500,
					BattlesPlayed = 100,
					BattlesWon = 50
				}
			})
			persistentCrewStore:dispatch({
				type = "setMembers",
				value = {
					{
						displayName = "badcc",
						isAdmin = true,
						userId = 2025110
					},
					{
						displayName = "CritStyx",
						userId = 12345,
						showAdmin = true
					},
					{
						displayName = "asimo3089",
						showUnAdmin = true,
						isAdmin = true,
						userId = 5678
					},
					{
						displayName = "asimo3089",
						showKick = true,
						userId = 692671
					},
					{
						displayName = "asimo3089"
					},
					{
						displayName = "asimo3089"
					},
					{
						displayName = "asimo3089"
					},
					{
						displayName = "badcc"
					},
					{
						displayName = "CritStyx"
					},
					{
						displayName = "asimo3089"
					}
				}
			})
			persistentCrewStore:dispatch({
				type = "setJoinRequests",
				value = {
					{
						displayName = "badcc",
						showRequestAccept = true,
						showRequestDeny = true
					},
					{
						displayName = "CritStyx",
						showRequestAccept = true,
						showRequestDeny = true
					},
					{
						displayName = "asimo3089",
						showRequestAccept = true,
						showRequestDeny = true
					}
				}
			})
		end
		function p1.attemptJoinUserId(p1) --[[ Line: 208 ]]
			print("player wants to request to join", p1)
		end
		function p1.attemptBattleUserId(p1) --[[ Line: 211 ]]
			print("player wants to battle", p1, "crew")
		end
		function p1.attemptKick(p1) --[[ Line: 214 ]]
			print("player wants to kick", p1)
		end
		function p1.attemptAdmin(p1) --[[ Line: 217 ]]
			print("player wants to admin", p1)
		end
		function p1.attemptUnAdmin(p1) --[[ Line: 220 ]]
			print("player wants to UNadmin", p1)
		end
	end
	function v1.render(p1) --[[ Line: 225 | Upvalues: Roact (ref), RoactRodux (ref), persistentCrewStore (copy), PersistentCrewApp (copy) ]]
		return Roact.createElement(RoactRodux.StoreProvider, {
			store = persistentCrewStore
		}, { Roact.createElement(PersistentCrewApp, {
				attemptLeave = p1.attemptLeave,
				attemptCreate = p1.attemptCreate,
				attemptJoinUserId = p1.attemptJoinUserId,
				attemptBattleUserId = p1.attemptBattleUserId,
				attemptKick = p1.attemptKick,
				attemptAdmin = p1.attemptAdmin,
				attemptUnAdmin = p1.attemptUnAdmin,
				numMembersOnline = 11,
				attemptReportCrew = function(p1, p2, p3) --[[ Name: attemptReportCrew | Line: 242 ]]
					print("player wants to report", p1, p2, p3)
				end
			}) })
	end
	local v2 = Roact.mount(Roact.createElement(v1), p1)
	return function() --[[ Line: 250 | Upvalues: Roact (ref), v2 (copy) ]]
		Roact.unmount(v2)
	end
end