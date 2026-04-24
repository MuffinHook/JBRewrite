-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ClanConsts = require(ReplicatedStorage.Clan.ClanConsts)
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
return function(p1)
	local v1 = Roact.Component:extend("App")
	local CrewLeaderboard = require(script.Parent.CrewLeaderboard)
	local persistentCrewStore = require(ReplicatedStorage.PersistentCrew.persistentCrewStore)
	local PersistentCrewBattleConsts = require(ReplicatedStorage.PersistentCrewBattle.PersistentCrewBattleConsts)
	function v1.init(p1)
		p1.aspectRatio = 1.5
		p1.leaderboardInfo = {
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
	function v1.render(p1)
		return Roact.createElement(RoactRodux.StoreProvider, {
			store = persistentCrewStore
		}, { Roact.createElement("Frame", {
				Size = UDim2.fromScale(1, 1)
			}, {
				x = Roact.createElement(CrewLeaderboard, {
					leaderboardInfo = p1.leaderboardInfo,
					aspectRatio = p1.aspectRatio,
					displayType = PersistentCrewBattleConsts.LEADERBOARD_DISPLAY_TYPE_ENUM.CrewsInServer,
					attemptViewClanId = function()
						print("attempting join")
					end
				}),
				Aspect = Roact.createElement("UIAspectRatioConstraint", {
					AspectRatio = p1.aspectRatio
				})
			}) })
	end
	local v2 = Roact.mount(Roact.createElement(v1), p1)
	return function()
		Roact.unmount(v2)
	end
end
