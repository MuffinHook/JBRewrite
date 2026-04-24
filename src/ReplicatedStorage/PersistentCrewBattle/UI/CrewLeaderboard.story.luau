-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ClanConsts = require(ReplicatedStorage.Clan.ClanConsts)
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
return function(self)
	local local1 = Roact.Component:extend("App")
	local CrewLeaderboard = require(script.Parent.CrewLeaderboard)
	local persistentCrewStore = require(ReplicatedStorage.PersistentCrew.persistentCrewStore)
	local PersistentCrewBattleConsts = require(ReplicatedStorage.PersistentCrewBattle.PersistentCrewBattleConsts)
	function local1.init(self)
		self.aspectRatio = 1.5
		self.leaderboardInfo = {
			{
				ownerUserId = 2837719,
				clanName = "Good Gang",
				clanRating = tostring(2200),
				ownerName = "Xikk",
				clanFlagColor = ClanConsts.CLAN_COLORS[math.random(1, #ClanConsts.CLAN_COLORS)].color
			},
			{
				ownerUserId = 2025110,
				clanName = "Faze",
				clanRating = tostring(2100),
				ownerName = "Badcc",
				clanFlagColor = ClanConsts.CLAN_COLORS[math.random(1, #ClanConsts.CLAN_COLORS)].color
			},
			{
				ownerUserId = 1,
				clanName = "Baboyz",
				clanRating = tostring(1600),
				ownerName = "CritStyx",
				clanFlagColor = ClanConsts.CLAN_COLORS[math.random(1, #ClanConsts.CLAN_COLORS)].color
			},
			{
				ownerUserId = 2,
				clanName = "CeilingFanCrew",
				clanRating = tostring(1500),
				ownerName = "CritStyx",
				clanFlagColor = ClanConsts.CLAN_COLORS[math.random(1, #ClanConsts.CLAN_COLORS)].color
			},
			{
				ownerUserId = 2837719,
				clanName = "Nice",
				clanRating = tostring(2200),
				ownerName = "Asimo",
				clanFlagColor = ClanConsts.CLAN_COLORS[math.random(1, #ClanConsts.CLAN_COLORS)].color
			},
			{
				ownerUserId = 2025110,
				clanName = "Faze",
				clanRating = tostring(2100),
				ownerName = "Badcc",
				clanFlagColor = ClanConsts.CLAN_COLORS[math.random(1, #ClanConsts.CLAN_COLORS)].color
			},
			{
				ownerUserId = 1,
				clanName = "Baboyz",
				clanRating = tostring(1600),
				ownerName = "CritStyx",
				clanFlagColor = ClanConsts.CLAN_COLORS[math.random(1, #ClanConsts.CLAN_COLORS)].color
			},
			{
				ownerUserId = 2,
				clanName = "CeilingFanCrew",
				clanRating = tostring(1500),
				ownerName = "CritStyx",
				clanFlagColor = ClanConsts.CLAN_COLORS[math.random(1, #ClanConsts.CLAN_COLORS)].color
			},
			{
				ownerUserId = 2837719,
				clanName = "Nice",
				clanRating = tostring(2200),
				ownerName = "Asimo",
				clanFlagColor = ClanConsts.CLAN_COLORS[math.random(1, #ClanConsts.CLAN_COLORS)].color
			},
			{
				ownerUserId = 2025110,
				clanName = "Faze",
				clanRating = tostring(2100),
				ownerName = "Badcc",
				clanFlagColor = ClanConsts.CLAN_COLORS[math.random(1, #ClanConsts.CLAN_COLORS)].color
			},
			{
				ownerUserId = 1,
				clanName = "Baboyz",
				clanRating = tostring(1600),
				ownerName = "CritStyx",
				clanFlagColor = ClanConsts.CLAN_COLORS[math.random(1, #ClanConsts.CLAN_COLORS)].color
			},
			{
				ownerUserId = 2,
				clanName = "CeilingFanCrew",
				clanRating = tostring(1500),
				ownerName = "CritStyx",
				clanFlagColor = ClanConsts.CLAN_COLORS[math.random(1, #ClanConsts.CLAN_COLORS)].color
			},
			{
				ownerUserId = 2837719,
				clanName = "Nice",
				clanRating = tostring(2200),
				ownerName = "Asimo",
				clanFlagColor = ClanConsts.CLAN_COLORS[math.random(1, #ClanConsts.CLAN_COLORS)].color
			},
			{
				ownerUserId = 2025110,
				clanName = "Faze",
				clanRating = tostring(2100),
				ownerName = "Badcc",
				clanFlagColor = ClanConsts.CLAN_COLORS[math.random(1, #ClanConsts.CLAN_COLORS)].color
			},
			{
				ownerUserId = 1,
				clanName = "Baboyz",
				clanRating = tostring(1600),
				ownerName = "CritStyx",
				clanFlagColor = ClanConsts.CLAN_COLORS[math.random(1, #ClanConsts.CLAN_COLORS)].color
			},
			{
				ownerUserId = 2,
				clanName = "CeilingFanCrew",
				clanRating = tostring(1500),
				ownerName = "CritStyx",
				clanFlagColor = ClanConsts.CLAN_COLORS[math.random(1, #ClanConsts.CLAN_COLORS)].color
			},
			{
				ownerUserId = 2837719,
				clanName = "Nice",
				clanRating = tostring(2200),
				ownerName = "Asimo",
				clanFlagColor = ClanConsts.CLAN_COLORS[math.random(1, #ClanConsts.CLAN_COLORS)].color
			},
			{
				ownerUserId = 2025110,
				clanName = "Faze",
				clanRating = tostring(2100),
				ownerName = "Badcc",
				clanFlagColor = ClanConsts.CLAN_COLORS[math.random(1, #ClanConsts.CLAN_COLORS)].color
			},
			{
				ownerUserId = 1,
				clanName = "Baboyz",
				clanRating = tostring(1600),
				ownerName = "CritStyx",
				clanFlagColor = ClanConsts.CLAN_COLORS[math.random(1, #ClanConsts.CLAN_COLORS)].color
			},
			{
				ownerUserId = 2,
				clanName = "CeilingFanCrew",
				clanRating = tostring(1500),
				ownerName = "CritStyx",
				clanFlagColor = ClanConsts.CLAN_COLORS[math.random(1, #ClanConsts.CLAN_COLORS)].color
			},
			{
				ownerUserId = 2837719,
				clanName = "Nice",
				clanRating = tostring(2200),
				ownerName = "Asimo",
				clanFlagColor = ClanConsts.CLAN_COLORS[math.random(1, #ClanConsts.CLAN_COLORS)].color
			},
			{
				ownerUserId = 2025110,
				clanName = "Faze",
				clanRating = tostring(2100),
				ownerName = "Badcc",
				clanFlagColor = ClanConsts.CLAN_COLORS[math.random(1, #ClanConsts.CLAN_COLORS)].color
			},
			{
				ownerUserId = 1,
				clanName = "Baboyz",
				clanRating = tostring(1600),
				ownerName = "CritStyx",
				clanFlagColor = ClanConsts.CLAN_COLORS[math.random(1, #ClanConsts.CLAN_COLORS)].color
			},
			{
				ownerUserId = 2,
				clanName = "CeilingFanCrew",
				clanRating = tostring(1500),
				ownerName = "CritStyx",
				clanFlagColor = ClanConsts.CLAN_COLORS[math.random(1, #ClanConsts.CLAN_COLORS)].color
			},
			{
				ownerUserId = 2837719,
				clanName = "Nice",
				clanRating = tostring(2200),
				ownerName = "Asimo",
				clanFlagColor = ClanConsts.CLAN_COLORS[math.random(1, #ClanConsts.CLAN_COLORS)].color
			},
			{
				ownerUserId = 2025110,
				clanName = "Faze",
				clanRating = tostring(2100),
				ownerName = "Badcc",
				clanFlagColor = ClanConsts.CLAN_COLORS[math.random(1, #ClanConsts.CLAN_COLORS)].color
			},
			{
				ownerUserId = 1,
				clanName = "Baboyz",
				clanRating = tostring(1600),
				ownerName = "CritStyx",
				clanFlagColor = ClanConsts.CLAN_COLORS[math.random(1, #ClanConsts.CLAN_COLORS)].color
			},
			{
				ownerUserId = 2,
				clanName = "CeilingFanCrew",
				clanRating = tostring(1500),
				ownerName = "CritStyx",
				clanFlagColor = ClanConsts.CLAN_COLORS[math.random(1, #ClanConsts.CLAN_COLORS)].color
			}
		}
	end
	function local1.render(self)
		return Roact.createElement(RoactRodux.StoreProvider, {
			store = persistentCrewStore
		}, { Roact.createElement("Frame", {
				Size = UDim2.fromScale(1, 1)
			}, {
				x = Roact.createElement(CrewLeaderboard, {
					leaderboardInfo = self.leaderboardInfo,
					aspectRatio = self.aspectRatio,
					displayType = PersistentCrewBattleConsts.LEADERBOARD_DISPLAY_TYPE_ENUM.CrewsInServer,
					attemptViewClanId = function()
						print("attempting join")
					end
				}),
				Aspect = Roact.createElement("UIAspectRatioConstraint", {
					AspectRatio = self.aspectRatio
				})
			}) })
	end
	local local2 = Roact.mount(Roact.createElement(local1), self)
	return function()
		Roact.unmount(local2)
	end
end
