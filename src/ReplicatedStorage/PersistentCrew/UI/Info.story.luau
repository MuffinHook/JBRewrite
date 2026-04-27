local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
return function(self)
	local AppComponent = Roact.Component:extend("App")
	local Info = require(script.Parent.Info)
	local persistentCrewStore = require(ReplicatedStorage.PersistentCrew.persistentCrewStore)
	function AppComponent.init(self)
		self.members = {
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
		function self.attemptBattleClanId(self)
			print("player wants to clan", self)
		end
		function self.attemptViewUserIdClan(self)
			print("player wants to view clan of user", self)
		end
		function self.onClickAdmin(self)
			print("wants to admin", self)
		end
		function self.onClickUnAdmin(self)
			print("wants to UNadmin", self)
		end
		function self.onClickKick(self)
			print("wants to kick", self)
		end
		function self.onClickToggleRequests(self)
			print("toggle requests")
		end
		function self.onClickRenameCrew(self)
			print("wants to rename", self)
		end
		self.isReadiedUp = false
		self.joinRequests = {
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
	function AppComponent.render(self)
		return Roact.createElement(RoactRodux.StoreProvider, {
			store = persistentCrewStore
		}, { Roact.createElement(Info, {
				aspectRatio = 16/9,
				verticalPaddingRatio = 128,
				attemptLeave = self.props.attemptLeave,
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
				members = self.members,
				joinRequests = self.joinRequests,
				isReadiedUp = self.isReadiedUp,
				attemptBattleUserId = self.attemptBattleUserId,
				attemptViewUserIdClan = self.attemptViewUserIdClan,
				onClickAdmin = self.onClickAdmin,
				onClickUnAdmin = self.onClickUnAdmin,
				onClickKick = self.onClickKick,
				onClickToggleRequests = self.onClickToggleRequests,
				onClickRenameCrew = self.onClickRenameCrew,
				playerDisplayRating = "1600"
			}) })
	end
	local mountedInstance = Roact.mount(Roact.createElement(AppComponent), self)
	return function()
		Roact.unmount(mountedInstance)
	end
end
