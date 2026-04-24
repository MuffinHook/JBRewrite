-- Reviewed by Claude
-- variables reassigned
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
local function playHover()
	if Players.LocalPlayer.PlayerGui then
		Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617498616, {
			Volume = 0.5
		})
	end
end
local function playLost()
	if Players.LocalPlayer.PlayerGui then
		Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617493597, {
			Volume = 0.7
		})
	end
end
local function playWon()
	if Players.LocalPlayer.PlayerGui then
		Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617488605, {
			Volume = 1
		})
	end
end
local function playDrums()
	if Players.LocalPlayer.PlayerGui then
		Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617487453, {
			Volume = 0.5
		})
	end
end
local t = {}
function t.init()
	local counter = false
	PrivateServerUtils.promiseGetIsBattleServer():timeout(10):andThen(function(self)
		if self then
			counter = true
			t.initBattleServer()
		end
	end)
end
local counter = 0
function t.initBattleServer()
	LevelUISystem.hideTopbar()
	Roact.mount(createElement("ScreenGui", {
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		ResetOnSpawn = false,
		IgnoreGuiInset = true,
		DisplayOrder = 0
	}, { Roact.createElement(RoactRodux.StoreProvider, {
			store = persistentCrewStore
		}, { createElement(GameModeCrewApp, {
				onCountdownFinished = function()
					if counter < 1 and Players.LocalPlayer.PlayerGui then
						Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617487453, {
							Volume = 0.5
						})
					end
					counter = counter + 1
				end
			}) }) }), Players.LocalPlayer.PlayerGui, "PersistentCrewUI")
	persistentCrewStore:dispatch({
		type = "setIsBattleServer",
		value = true
	})
	waitForChild(ReplicatedStorage, PersistentCrewBattleConsts.ALL_CREW_BATTLE_DATA_OBJ_NAME):andThen(function(self)
		RxInstanceUtils.observeChildren(self, function(self, self)
			local function handleChange()
				local counter = PersistentCrewBattleUtils.getCrewStartTime(self)
				local local2 = PersistentCrewBattleUtils.getCrewPenaltyDuration(self)
				if counter and local2 then
					persistentCrewStore:dispatch({
						type = "setStartedAt",
						clanId = self.Name,
						value = counter - local2
					})
				end
				local local3 = PersistentCrewBattleUtils.getCrewTimeTook(self)
				if local3 then
					persistentCrewStore:dispatch({
						type = "setTimeTook",
						clanId = self.Name,
						value = local3
					})
				end
			end
			handleChange()
			self:GiveTask(self:GetAttributeChangedSignal(PersistentCrewBattleConsts.ROUND_START_ATTR_NAME):Connect(handleChange))
			self:GiveTask(self:GetAttributeChangedSignal(PersistentCrewBattleConsts.ROUND_PENALTY_DURATION_ATTR_NAME):Connect(handleChange))
			self:GiveTask(self:GetAttributeChangedSignal(PersistentCrewBattleConsts.ROUND_TIME_TOOK_ATTR_NAME):Connect(handleChange))
			local function handleClanName()
				persistentCrewStore:dispatch({
					type = "setClanName",
					clanId = self.Name,
					value = self:GetAttribute(PersistentCrewBattleConsts.CLAN_NAME_ATTR_NAME)
				})
			end
			persistentCrewStore:dispatch({
				type = "setClanName",
				clanId = self.Name,
				value = self:GetAttribute(PersistentCrewBattleConsts.CLAN_NAME_ATTR_NAME)
			})
			self:GiveTask(self:GetAttributeChangedSignal(PersistentCrewBattleConsts.CLAN_NAME_ATTR_NAME):Connect(handleClanName))
		end)
		local function updateAttackingClanId()
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
	waitForChild(ReplicatedStorage, PersistentCrewBattleConsts.ROBBERIES_COMPLETED_REMOTE_NAME):andThen(function(self)
		local function receiveRobberiesCompleted(self)
			persistentCrewStore:dispatch({
				type = "setRobberiesCompleted",
				value = self
			})
		end
		self.OnClientEvent:Connect(receiveRobberiesCompleted)
	end)
	waitForChild(ReplicatedStorage, PersistentCrewBattleConsts.ANNOUNCE_PENALTY_REMOTE_NAME):andThen(function(self)
		self.OnClientEvent:Connect(function(self, self)
			persistentCrewStore:dispatch({
				type = "setPenaltyText",
				value = ("%s +%ss"):format(self, self)
			})
		end)
	end)
	waitForChild(ReplicatedStorage, PersistentCrewBattleConsts.ANNOUNCE_WIN_REMOTE_NAME):andThen(function(self)
		self.OnClientEvent:Connect(function(self)
			if self then
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
	local local12 = nil
	persistentCrewStore.changed:connect(function(self, self)
		if self.penalty ~= self.penalty then
			if local12 then
				task.cancel(local12)
				local12 = nil
			end
			if self.penalty then
				local12 = task.delay(5, function()
					persistentCrewStore:dispatch({
						type = "setPenaltyText",
						value = nil
					})
				end)
			end
		end
	end)
end
function t.initNonBattleServer()
	persistentCrewStore:dispatch({
		type = "setIsBattleServer",
		value = false
	})
	waitForChild(Players.LocalPlayer, PersistentCrewBattleConsts.INVITES_FOLDER_NAME):andThen(function(self)
		local function updateInitiations()
			local t = {}
			for counter, local2 in self:GetChildren() do
				table.insert(t, {
					clanName = local2:GetAttribute(PersistentCrewBattleConsts.INVITE_OPPOSING_CLAN_NAME_ATTR_NAME),
					battleNumPlayersPerTeam = local2:GetAttribute(PersistentCrewBattleConsts.INVITE_NUM_PLAYERS_PER_TEAM_ATTR_NAME),
					clanRating = local2:GetAttribute(PersistentCrewBattleConsts.INVITE_CLAN_DISPLAY_RATING_ATTR_NAME),
					ranked = local2:GetAttribute(PersistentCrewBattleConsts.INVITE_RANKED_ATTR_NAME),
					opposingClanOwnerName = local2:GetAttribute(PersistentCrewBattleConsts.INVITE_OPPOSING_CLAN_OWNER_NAME_ATTR_NAME),
					obj = local2
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
		self.ChildAdded:Connect(updateInitiations)
		self.ChildRemoved:Connect(updateInitiations)
	end)
	waitForChild(ReplicatedStorage, PersistentCrewBattleConsts.LEADERBOARD_INFO_REMOTE_NAME):andThen(function(self)
		self.OnClientEvent:Connect(function(self)
			persistentCrewBattleStore:dispatch({
				type = "setCrewLeaderboard",
				value = self
			})
		end)
	end)
	waitForChild(ReplicatedStorage, PersistentCrewBattleConsts.CREWS_IN_SERVER_DISPLAY_INFO_REMOTE_NAME):andThen(function(self)
		self.OnClientEvent:Connect(function(self)
			persistentCrewBattleStore:dispatch({
				type = "setCrewsInServerDisplayInfo",
				value = self
			})
		end)
	end)
	waitForChild(ReplicatedStorage, PersistentCrewBattleConsts.UPDATE_BATTLE_RESPONSES_REMOTE_NAME):andThen(function(self)
		local counter = 0
		self.OnClientEvent:Connect(function(self, self)
			local battleResponseData = persistentCrewStore:getState().battleResponseData
			if self ~= nil or (battleResponseData == nil or self == battleResponseData.BattleUniqueId) then
				if self then
					local local3 = if self.OurClanAccepted then #self.OurClanAccepted else 0 + if self.TheirClanAccepted then #self.TheirClanAccepted else 0
					if counter < local3 and Players.LocalPlayer.PlayerGui then
						Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617498616, {
							Volume = 0.5
						})
					end
					counter = local3
				end
				persistentCrewStore:dispatch({
					type = "setBattleResponseData",
					value = self
				})
			end
		end)
	end)
end
return t
