local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
return function(p1) --[[ Line: 5 | Upvalues: Roact (copy), ReplicatedStorage (copy), RoactRodux (copy) ]]
	local v1 = Roact.Component:extend("App")
	local Info = require(script.Parent.Info)
	local persistentCrewStore = require(ReplicatedStorage.PersistentCrew.persistentCrewStore)
	function v1.init(p1) --[[ Line: 9 ]]
		p1.members = {
			{
				id = 2025110,
				userId = 2025110,
				displayName = "badcc",
				isAdmin = true,
				showKick = true,
				showAdmin = true,
				showUnAdmin = true,
				battlesPlayed = 1,
				battlesWon = 1
			}
		}
		function p1.attemptBattleClanId(p1) --[[ Line: 23 ]]
			print("player wants to clan", p1)
		end
		function p1.attemptViewUserIdClan(p1) --[[ Line: 26 ]]
			print("player wants to view clan of user", p1)
		end
		function p1.onClickAdmin(p1) --[[ Line: 29 ]]
			print("wants to admin", p1)
		end
		function p1.onClickUnAdmin(p1) --[[ Line: 32 ]]
			print("wants to UNadmin", p1)
		end
		function p1.onClickKick(p1) --[[ Line: 35 ]]
			print("wants to kick", p1)
		end
		function p1.onClickToggleRequests(p1) --[[ Line: 38 ]]
			print("toggle requests")
		end
		function p1.onClickRenameCrew(p1) --[[ Line: 41 ]]
			print("wants to rename", p1)
		end
		p1.isReadiedUp = false
		p1.joinRequests = {
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
	end
	function v1.render(p1) --[[ Line: 54 | Upvalues: Roact (ref), RoactRodux (ref), persistentCrewStore (copy), Info (copy) ]]
		return Roact.createElement(RoactRodux.StoreProvider, {
			store = persistentCrewStore
		}, { Roact.createElement(Info, {
				aspectRatio = 1.7777777777777777,
				verticalPaddingRatio = 128,
				attemptLeave = p1.props.attemptLeave,
				playersClanId = nil,
				isPlayersClan = false,
				isAdminOfViewingClan = true,
				isAdminOfCurrentClan = true,
				clanName = "Baboyz",
				clanDisplayRating = "1500",
				leaderboardRank = 10,
				battlesPlayed = 425,
				battlesWLRatio = 2.13,
				numMembersOnline = 10,
				members = p1.members,
				joinRequests = p1.joinRequests,
				isReadiedUp = p1.isReadiedUp,
				attemptBattleUserId = p1.attemptBattleUserId,
				attemptViewUserIdClan = p1.attemptViewUserIdClan,
				onClickAdmin = p1.onClickAdmin,
				onClickUnAdmin = p1.onClickUnAdmin,
				onClickKick = p1.onClickKick,
				onClickToggleRequests = p1.onClickToggleRequests,
				onClickRenameCrew = p1.onClickRenameCrew,
				playerDisplayRating = "1600"
			}) })
	end
	local v2 = Roact.mount(Roact.createElement(v1), p1)
	return function() --[[ Line: 89 | Upvalues: Roact (ref), v2 (copy) ]]
		Roact.unmount(v2)
	end
end