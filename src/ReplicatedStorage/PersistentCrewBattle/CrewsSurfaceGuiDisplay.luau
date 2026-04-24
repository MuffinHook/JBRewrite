-- Reviewed by Claude
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PersistentCrewBattleConsts = require(script.Parent.PersistentCrewBattleConsts)
local persistentCrewBattleStore = require(script.Parent.persistentCrewBattleStore)
local PersistentCrewConsts = require(ReplicatedStorage.PersistentCrew.PersistentCrewConsts)
local persistentCrewStore = require(ReplicatedStorage.PersistentCrew.persistentCrewStore)
local CrewLeaderboard = require(ReplicatedStorage.PersistentCrewBattle.UI.CrewLeaderboard)
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
local BaseObject = require(ReplicatedStorage.Std.BaseObject)
local Interval = require(ReplicatedStorage.Std.Interval)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local createElement = Roact.createElement
local t = {
	ClassName = "CrewsSurfaceGuiDisplay"
}
t.__index = t
function t.new(p1, p2)
	if not PersistentCrewBattleConsts.LEADERBOARD_DISPLAY_TYPE_ENUM:GetValueFromEnum(p2) then
		error("Invalid displayType: " .. tostring(p2))
	end
	local v1 = BaseObject.new(p1)
	setmetatable(v1, t)
	RxInstanceUtils.yieldForProperty(p1, "PrimaryPart")
	local function attemptViewClanId(p1)
		ReplicatedStorage:FindFirstChild(PersistentCrewConsts.VIEW_CLAN_REMOTE_NAME):FireServer(p1)
		persistentCrewStore:dispatch({
			type = "setGroupVisible",
			value = true
		})
	end
	local v3, v4 = Roact.createBinding(true)
	v1.maid:GiveTask(Interval.every(1):Connect(function()
		local Character = Players.LocalPlayer.Character
		local v1 = v3:getValue()
		local function setCurrEnabled(p1)
			if p1 ~= v1 then
				v4(p1)
			end
		end
		if Character then
			local PrimaryPart = Character.PrimaryPart
			if PrimaryPart then
				if (PrimaryPart.Position - p1.PrimaryPart.Position).Magnitude >= PersistentCrewBattleConsts.UNRENDER_LEADERBOARD_DISPLAY_DISTANCE then
					if v1 ~= false then
						v4(false)
					end
				elseif v1 ~= true then
					v4(true)
				end
			elseif v1 ~= false then
				v4(false)
			end
		elseif v1 ~= false then
			v4(false)
		end
	end))
	local v10 = Roact.mount(Roact.createElement(RoactRodux.StoreProvider, {
		store = persistentCrewBattleStore
	}, { (createElement("SurfaceGui", {
			ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
			ResetOnSpawn = false,
			Adornee = v1.obj.PrimaryPart,
			Face = Enum.NormalId.Front,
			SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud,
			PixelsPerStud = if v1.obj.PrimaryPart.Size.Y < 30 then 80 else 20,
			Enabled = v3
		}, {
			Display = createElement(RoactRodux.connect(function(p1, p22)
				local v1 = nil
				if p2 == PersistentCrewBattleConsts.LEADERBOARD_DISPLAY_TYPE_ENUM.CrewsInServer then
					v1 = p1.crewsInServerDisplayInfo
				elseif p2 == PersistentCrewBattleConsts.LEADERBOARD_DISPLAY_TYPE_ENUM.Leaderboard then
					v1 = p1.leaderboardInfo
				else
					error("Invalid displayType: " .. tostring(p2))
				end
				return {
					leaderboardInfo = v1
				}
			end)(CrewLeaderboard), {
				displayType = p2,
				aspectRatio = v1.obj.PrimaryPart.Size.X / v1.obj.PrimaryPart.Size.Y,
				attemptViewClanId = attemptViewClanId
			})
		})) }), Players.LocalPlayer.PlayerGui, "CrewsInServerGui")
	v1.maid:GiveTask(function()
		Roact.unmount(v10)
	end)
	return v1
end
return t
