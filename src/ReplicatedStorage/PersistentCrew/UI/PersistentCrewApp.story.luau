-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
require(ReplicatedStorage.PersistentCrewBattle.PersistentCrewBattleConsts)
return function(self)
	local local1 = Roact.Component:extend("App")
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
	function local1.init(self)
		function self.attemptLeave()
			persistentCrewStore:dispatch({
				type = "setViewingClanInfo",
				value = nil
			})
		end
		function self.attemptCreate(self)
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
		function self.attemptJoinUserId(self)
			print("player wants to request to join", self)
		end
		function self.attemptBattleUserId(self)
			print("player wants to battle", self, "crew")
		end
		function self.attemptKick(self)
			print("player wants to kick", self)
		end
		function self.attemptAdmin(self)
			print("player wants to admin", self)
		end
		function self.attemptUnAdmin(self)
			print("player wants to UNadmin", self)
		end
	end
	function local1.render(self)
		return Roact.createElement(RoactRodux.StoreProvider, {
			store = persistentCrewStore
		}, { Roact.createElement(PersistentCrewApp, {
				attemptLeave = self.attemptLeave,
				attemptCreate = self.attemptCreate,
				attemptJoinUserId = self.attemptJoinUserId,
				attemptBattleUserId = self.attemptBattleUserId,
				attemptKick = self.attemptKick,
				attemptAdmin = self.attemptAdmin,
				attemptUnAdmin = self.attemptUnAdmin,
				numMembersOnline = 11,
				attemptReportCrew = function(self, arg2, arg3)
					print("player wants to report", self, arg2, arg3)
				end
			}) })
	end
	local local2 = Roact.mount(Roact.createElement(local1), self)
	return function()
		Roact.unmount(local2)
	end
end
