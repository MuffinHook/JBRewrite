local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Std.Audio)
local waitForChild = require(ReplicatedStorage.Std.waitForChild)
local PrivateServerUtils = require(ReplicatedStorage.PrivateServer.PrivateServerUtils)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local LevelUISystem = require(ReplicatedStorage.Game.Level2.LevelUISystem)
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
local createElement = Roact.createElement
local GameModeCrewApp = require(ReplicatedStorage.PersistentCrew.UI.GameModeCrewApp)
local PersistentCrewBattleConsts = require(ReplicatedStorage.PersistentCrewBattle.PersistentCrewBattleConsts)
local PersistentCrewBattleUtils = require(ReplicatedStorage.PersistentCrewBattle.PersistentCrewBattleUtils)
local persistentCrewStore = require(ReplicatedStorage.PersistentCrew.persistentCrewStore)
local persistentCrewBattleStore = require(ReplicatedStorage.PersistentCrewBattle.persistentCrewBattleStore)
require(ReplicatedStorage.Std.Debug.table2Lua)
local function playHover() --[[ Line: 20 | Upvalues: Players (copy), Audio (copy) ]]
	if Players.LocalPlayer.PlayerGui then
		Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617498616, {
			Volume = 0.5
		})
	end
end
local function playLost() --[[ Line: 26 | Upvalues: Players (copy), Audio (copy) ]]
	if Players.LocalPlayer.PlayerGui then
		Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617493597, {
			Volume = 0.7
		})
	end
end
local function playWon() --[[ Line: 31 | Upvalues: Players (copy), Audio (copy) ]]
	if Players.LocalPlayer.PlayerGui then
		Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617488605, {
			Volume = 1
		})
	end
end
local function playDrums() --[[ Line: 36 | Upvalues: Players (copy), Audio (copy) ]]
	if Players.LocalPlayer.PlayerGui then
		Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617487453, {
			Volume = 0.5
		})
	end
end
local t = {}
function t.init() --[[ Line: 43 | Upvalues: PrivateServerUtils (copy), t (copy) ]]
	local v1 = false
	PrivateServerUtils.promiseGetIsBattleServer():timeout(10):andThen(function(p1) --[[ Line: 45 | Upvalues: v1 (ref), t (ref) ]]
		if p1 then
			v1 = true
			t.initBattleServer()
		end
	end)
end
local v1 = 0
function t.initBattleServer() --[[ Line: 54 | Upvalues: LevelUISystem (copy), Roact (copy), createElement (copy), RoactRodux (copy), persistentCrewStore (copy), GameModeCrewApp (copy), v1 (ref), Players (copy), Audio (copy), waitForChild (copy), ReplicatedStorage (copy), PersistentCrewBattleConsts (copy), RxInstanceUtils (copy), PersistentCrewBattleUtils (copy) ]]
	LevelUISystem.hideTopbar()
	Roact.mount(createElement("ScreenGui", {
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		ResetOnSpawn = false,
		IgnoreGuiInset = true,
		DisplayOrder = 0
	}, { Roact.createElement(RoactRodux.StoreProvider, {
			store = persistentCrewStore
		}, { createElement(GameModeCrewApp, {
				onCountdownFinished = function() --[[ Name: onCountdownFinished | Line: 70 | Upvalues: v1 (ref), Players (ref), Audio (ref) ]]
					if v1 < 1 and Players.LocalPlayer.PlayerGui then
						Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617487453, {
							Volume = 0.5
						})
					end
					v1 = v1 + 1
				end
			}) }) }), Players.LocalPlayer.PlayerGui, "PersistentCrewUI")
	persistentCrewStore:dispatch({
		type = "setIsBattleServer",
		value = true
	})
	waitForChild(ReplicatedStorage, PersistentCrewBattleConsts.ALL_CREW_BATTLE_DATA_OBJ_NAME):andThen(function(p1) --[[ Line: 88 | Upvalues: RxInstanceUtils (ref), PersistentCrewBattleUtils (ref), persistentCrewStore (ref), PersistentCrewBattleConsts (ref) ]]
		RxInstanceUtils.observeChildren(p1, function(p1, p2) --[[ Line: 89 | Upvalues: PersistentCrewBattleUtils (ref), persistentCrewStore (ref), PersistentCrewBattleConsts (ref) ]]
			local function handleChange() --[[ Line: 90 | Upvalues: PersistentCrewBattleUtils (ref), p1 (copy), persistentCrewStore (ref) ]]
				local v1 = PersistentCrewBattleUtils.getCrewStartTime(p1)
				local v2 = PersistentCrewBattleUtils.getCrewPenaltyDuration(p1)
				if v1 and v2 then
					persistentCrewStore:dispatch({
						type = "setStartedAt",
						clanId = p1.Name,
						value = v1 - v2
					})
				end
				local v3 = PersistentCrewBattleUtils.getCrewTimeTook(p1)
				if v3 then
					persistentCrewStore:dispatch({
						type = "setTimeTook",
						clanId = p1.Name,
						value = v3
					})
				end
			end
			handleChange()
			p2:GiveTask(p1:GetAttributeChangedSignal(PersistentCrewBattleConsts.ROUND_START_ATTR_NAME):Connect(handleChange))
			p2:GiveTask(p1:GetAttributeChangedSignal(PersistentCrewBattleConsts.ROUND_PENALTY_DURATION_ATTR_NAME):Connect(handleChange))
			p2:GiveTask(p1:GetAttributeChangedSignal(PersistentCrewBattleConsts.ROUND_TIME_TOOK_ATTR_NAME):Connect(handleChange))
			local function handleClanName() --[[ Line: 126 | Upvalues: p1 (copy), PersistentCrewBattleConsts (ref), persistentCrewStore (ref) ]]
				persistentCrewStore:dispatch({
					type = "setClanName",
					clanId = p1.Name,
					value = p1:GetAttribute(PersistentCrewBattleConsts.CLAN_NAME_ATTR_NAME)
				})
			end
			persistentCrewStore:dispatch({
				type = "setClanName",
				clanId = p1.Name,
				value = p1:GetAttribute(PersistentCrewBattleConsts.CLAN_NAME_ATTR_NAME)
			})
			p2:GiveTask(p1:GetAttributeChangedSignal(PersistentCrewBattleConsts.CLAN_NAME_ATTR_NAME):Connect(handleClanName))
		end)
		local function updateAttackingClanId() --[[ Line: 143 | Upvalues: PersistentCrewBattleUtils (ref), persistentCrewStore (ref) ]]
			persistentCrewStore:dispatch({
				type = "setAttackingClanId",
				value = PersistentCrewBattleUtils.getAttackingClanId()
			})
		end
		persistentCrewStore:dispatch({
			type = "setAttackingClanId",
			value = PersistentCrewBattleUtils.getAttackingClanId()
		})
		PersistentCrewBattleUtils.getAttackingClanIdChangedSignal():Connect(updateAttackingClanId)
	end)
	waitForChild(ReplicatedStorage, PersistentCrewBattleConsts.ROBBERIES_COMPLETED_REMOTE_NAME):andThen(function(p1) --[[ Line: 157 | Upvalues: persistentCrewStore (ref) ]]
		local function receiveRobberiesCompleted(p1) --[[ Line: 158 | Upvalues: persistentCrewStore (ref) ]]
			persistentCrewStore:dispatch({
				type = "setRobberiesCompleted",
				value = p1
			})
		end
		p1.OnClientEvent:Connect(receiveRobberiesCompleted)
	end)
	waitForChild(ReplicatedStorage, PersistentCrewBattleConsts.ANNOUNCE_PENALTY_REMOTE_NAME):andThen(function(p1) --[[ Line: 169 | Upvalues: persistentCrewStore (ref) ]]
		p1.OnClientEvent:Connect(function(p1, p2) --[[ Line: 170 | Upvalues: persistentCrewStore (ref) ]]
			persistentCrewStore:dispatch({
				type = "setPenaltyText",
				value = ("%s +%ss"):format(p2, p1)
			})
		end)
	end)
	waitForChild(ReplicatedStorage, PersistentCrewBattleConsts.ANNOUNCE_WIN_REMOTE_NAME):andThen(function(p1) --[[ Line: 180 | Upvalues: Players (ref), Audio (ref) ]]
		p1.OnClientEvent:Connect(function(p1) --[[ Line: 181 | Upvalues: Players (ref), Audio (ref) ]]
			if p1 then
				if Players.LocalPlayer.PlayerGui then
					Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617488605, {
						Volume = 1
					})
				end
			elseif Players.LocalPlayer.PlayerGui then
				Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617493597, {
					Volume = 0.7
				})
			end
		end)
	end)
	local v12 = nil
	persistentCrewStore.changed:connect(function(p1, p2) --[[ Line: 192 | Upvalues: v12 (ref), persistentCrewStore (ref) ]]
		if p1.penalty ~= p2.penalty then
			if v12 then
				task.cancel(v12)
				v12 = nil
			end
			if p1.penalty then
				v12 = task.delay(5, function() --[[ Line: 200 | Upvalues: persistentCrewStore (ref) ]]
					persistentCrewStore:dispatch({
						type = "setPenaltyText",
						value = nil
					})
				end)
			end
		end
	end)
end
function t.initNonBattleServer() --[[ Line: 210 | Upvalues: persistentCrewStore (copy), waitForChild (copy), Players (copy), PersistentCrewBattleConsts (copy), Audio (copy), ReplicatedStorage (copy), persistentCrewBattleStore (copy) ]]
	persistentCrewStore:dispatch({
		type = "setIsBattleServer",
		value = false
	})
	waitForChild(Players.LocalPlayer, PersistentCrewBattleConsts.INVITES_FOLDER_NAME):andThen(function(p1) --[[ Line: 215 | Upvalues: PersistentCrewBattleConsts (ref), Audio (ref), Players (ref), persistentCrewStore (ref) ]]
		local function updateInitiations() --[[ Line: 216 | Upvalues: p1 (copy), PersistentCrewBattleConsts (ref), Audio (ref), Players (ref), persistentCrewStore (ref) ]]
			local t = {}
			for v1, v2 in p1:GetChildren() do
				table.insert(t, {
					clanName = v2:GetAttribute(PersistentCrewBattleConsts.INVITE_OPPOSING_CLAN_NAME_ATTR_NAME),
					battleNumPlayersPerTeam = v2:GetAttribute(PersistentCrewBattleConsts.INVITE_NUM_PLAYERS_PER_TEAM_ATTR_NAME),
					clanRating = v2:GetAttribute(PersistentCrewBattleConsts.INVITE_CLAN_DISPLAY_RATING_ATTR_NAME),
					ranked = v2:GetAttribute(PersistentCrewBattleConsts.INVITE_RANKED_ATTR_NAME),
					opposingClanOwnerName = v2:GetAttribute(PersistentCrewBattleConsts.INVITE_OPPOSING_CLAN_OWNER_NAME_ATTR_NAME),
					obj = v2
				})
				Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 9781039157, {
					Volume = 0.2
				})
			end
			persistentCrewStore:dispatch({
				type = "battleInvitesSet",
				list = t
			})
		end
		updateInitiations()
		p1.ChildAdded:Connect(updateInitiations)
		p1.ChildRemoved:Connect(updateInitiations)
	end)
	waitForChild(ReplicatedStorage, PersistentCrewBattleConsts.LEADERBOARD_INFO_REMOTE_NAME):andThen(function(p1) --[[ Line: 246 | Upvalues: persistentCrewBattleStore (ref) ]]
		p1.OnClientEvent:Connect(function(p1) --[[ Line: 247 | Upvalues: persistentCrewBattleStore (ref) ]]
			persistentCrewBattleStore:dispatch({
				type = "setCrewLeaderboard",
				value = p1
			})
		end)
	end)
	waitForChild(ReplicatedStorage, PersistentCrewBattleConsts.CREWS_IN_SERVER_DISPLAY_INFO_REMOTE_NAME):andThen(function(p1) --[[ Line: 256 | Upvalues: persistentCrewBattleStore (ref) ]]
		p1.OnClientEvent:Connect(function(p1) --[[ Line: 257 | Upvalues: persistentCrewBattleStore (ref) ]]
			persistentCrewBattleStore:dispatch({
				type = "setCrewsInServerDisplayInfo",
				value = p1
			})
		end)
	end)
	waitForChild(ReplicatedStorage, PersistentCrewBattleConsts.UPDATE_BATTLE_RESPONSES_REMOTE_NAME):andThen(function(p1) --[[ Line: 267 | Upvalues: persistentCrewStore (ref), Players (ref), Audio (ref) ]]
		local v1 = 0
		p1.OnClientEvent:Connect(function(p1, p2) --[[ Line: 270 | Upvalues: persistentCrewStore (ref), v1 (ref), Players (ref), Audio (ref) ]]
			local battleResponseData = persistentCrewStore:getState().battleResponseData
			if p2 ~= nil or (battleResponseData == nil or p1 == battleResponseData.BattleUniqueId) then
				if p2 then
					local v3 = if p2.OurClanAccepted then #p2.OurClanAccepted else 0 + if p2.TheirClanAccepted then #p2.TheirClanAccepted else 0
					if v1 < v3 and Players.LocalPlayer.PlayerGui then
						Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617498616, {
							Volume = 0.5
						})
					end
					v1 = v3
				end
				persistentCrewStore:dispatch({
					type = "setBattleResponseData",
					value = p2
				})
			end
		end)
	end)
end
return t