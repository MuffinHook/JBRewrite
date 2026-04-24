-- Reviewed by Claude
-- variables reassigned
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
function t.new(self, arg2)
	if not PersistentCrewBattleConsts.LEADERBOARD_DISPLAY_TYPE_ENUM:GetValueFromEnum(arg2) then
		error("Invalid displayType: " .. tostring(arg2))
	end
	local local1 = BaseObject.new(self)
	setmetatable(local1, t)
	RxInstanceUtils.yieldForProperty(self, "PrimaryPart")
	local function attemptViewClanId(self)
		ReplicatedStorage:FindFirstChild(PersistentCrewConsts.VIEW_CLAN_REMOTE_NAME):FireServer(self)
		persistentCrewStore:dispatch({
			type = "setGroupVisible",
			value = true
		})
	end
	local local3, local4 = Roact.createBinding(true)
	local1.maid:GiveTask(Interval.every(1):Connect(function()
		local Character = Players.LocalPlayer.Character
		local local1 = local3:getValue()
		local function setCurrEnabled(self)
			if self ~= local1 then
				local4(self)
			end
		end
		if Character then
			local PrimaryPart = Character.PrimaryPart
			if PrimaryPart then
				if (PrimaryPart.Position - self.PrimaryPart.Position).Magnitude >= PersistentCrewBattleConsts.UNRENDER_LEADERBOARD_DISPLAY_DISTANCE then
					if local1 ~= false then
						local4(false)
					end
				elseif local1 ~= true then
					local4(true)
				end
			elseif local1 ~= false then
				local4(false)
			end
		elseif local1 ~= false then
			local4(false)
		end
	end))
	local local10 = Roact.mount(Roact.createElement(RoactRodux.StoreProvider, {
		store = persistentCrewBattleStore
	}, { (createElement("SurfaceGui", {
			ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
			ResetOnSpawn = false,
			Adornee = local1.obj.PrimaryPart,
			Face = Enum.NormalId.Front,
			SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud,
			PixelsPerStud = if local1.obj.PrimaryPart.Size.Y < 30 then 80 else 20,
			Enabled = local3
		}, {
			Display = createElement(RoactRodux.connect(function(self, arg22)
				local local1 = nil
				if arg2 == PersistentCrewBattleConsts.LEADERBOARD_DISPLAY_TYPE_ENUM.CrewsInServer then
					local1 = self.crewsInServerDisplayInfo
				elseif arg2 == PersistentCrewBattleConsts.LEADERBOARD_DISPLAY_TYPE_ENUM.Leaderboard then
					local1 = self.leaderboardInfo
				else
					error("Invalid displayType: " .. tostring(arg2))
				end
				return {
					leaderboardInfo = local1
				}
			end)(CrewLeaderboard), {
				displayType = arg2,
				aspectRatio = local1.obj.PrimaryPart.Size.X / local1.obj.PrimaryPart.Size.Y,
				attemptViewClanId = attemptViewClanId
			})
		})) }), Players.LocalPlayer.PlayerGui, "CrewsInServerGui")
	local1.maid:GiveTask(function()
		Roact.unmount(local10)
	end)
	return local1
end
return t
