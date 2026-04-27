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
function t.new(crewObject, displayType)
	if not PersistentCrewBattleConsts.LEADERBOARD_DISPLAY_TYPE_ENUM:GetValueFromEnum(displayType) then
		error("Invalid displayType: " .. tostring(displayType))
	end
	local displayInstance = BaseObject.new(crewObject)
	setmetatable(displayInstance, t)
	RxInstanceUtils.yieldForProperty(crewObject, "PrimaryPart")
	local function attemptViewClanId(clanId)
		ReplicatedStorage:FindFirstChild(PersistentCrewConsts.VIEW_CLAN_REMOTE_NAME):FireServer(clanId)
		persistentCrewStore:dispatch({
			type = "setGroupVisible",
			value = true
		})
	end
	local enabledBinding, setEnabledBinding = Roact.createBinding(true)
	displayInstance.maid:GiveTask(Interval.every(1):Connect(function()
		local Character = Players.LocalPlayer.Character
		local isCurrentlyEnabled = enabledBinding:getValue()
		local function setCurrEnabled(newEnabledState)
			if newEnabledState ~= isCurrentlyEnabled then
				setEnabledBinding(newEnabledState)
			end
		end
		if Character then
			local PrimaryPart = Character.PrimaryPart
			if PrimaryPart then
				if (PrimaryPart.Position - crewObject.PrimaryPart.Position).Magnitude >= PersistentCrewBattleConsts.UNRENDER_LEADERBOARD_DISPLAY_DISTANCE then
					if isCurrentlyEnabled ~= false then
						setEnabledBinding(false)
					end
				elseif isCurrentlyEnabled ~= true then
					setEnabledBinding(true)
				end
			elseif isCurrentlyEnabled ~= false then
				setEnabledBinding(false)
			end
		elseif isCurrentlyEnabled ~= false then
			setEnabledBinding(false)
		end
	end))
	local mountedGui = Roact.mount(Roact.createElement(RoactRodux.StoreProvider, {
		store = persistentCrewBattleStore
	}, { (createElement("SurfaceGui", {
			ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
			ResetOnSpawn = false,
			Adornee = displayInstance.obj.PrimaryPart,
			Face = Enum.NormalId.Front,
			SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud,
			PixelsPerStud = if displayInstance.obj.PrimaryPart.Size.Y < 30 then 80 else 20,
			Enabled = enabledBinding
		}, {
			Display = createElement(RoactRodux.connect(function(storeState, storeProps)
				local selectedDisplayInfo = nil
				if displayType == PersistentCrewBattleConsts.LEADERBOARD_DISPLAY_TYPE_ENUM.CrewsInServer then
					selectedDisplayInfo = storeState.crewsInServerDisplayInfo
				elseif displayType == PersistentCrewBattleConsts.LEADERBOARD_DISPLAY_TYPE_ENUM.Leaderboard then
					selectedDisplayInfo = storeState.leaderboardInfo
				else
					error("Invalid displayType: " .. tostring(displayType))
				end
				return {
					leaderboardInfo = selectedDisplayInfo
				}
			end)(CrewLeaderboard), {
				displayType = displayType,
				aspectRatio = displayInstance.obj.PrimaryPart.Size.X / displayInstance.obj.PrimaryPart.Size.Y,
				attemptViewClanId = attemptViewClanId
			})
		})) }), Players.LocalPlayer.PlayerGui, "CrewsInServerGui")
	displayInstance.maid:GiveTask(function()
		Roact.unmount(mountedGui)
	end)
	return displayInstance
end
return t
