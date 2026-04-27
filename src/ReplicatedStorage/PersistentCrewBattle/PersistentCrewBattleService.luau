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
	local isBattleServer = false
	PrivateServerUtils.promiseGetIsBattleServer():timeout(10):andThen(function(battleServerResult)
		if battleServerResult then
			isBattleServer = true
			t.initBattleServer()
		end
	end)
end
local countdownTimesPlayed = 0
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
					if countdownTimesPlayed < 1 and Players.LocalPlayer.PlayerGui then
						Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617487453, {
							Volume = 0.5
						})
					end
					countdownTimesPlayed = countdownTimesPlayed + 1
				end
			}) }) }), Players.LocalPlayer.PlayerGui, "PersistentCrewUI")
	persistentCrewStore:dispatch({
		type = "setIsBattleServer",
		value = true
	})
	waitForChild(ReplicatedStorage, PersistentCrewBattleConsts.ALL_CREW_BATTLE_DATA_OBJ_NAME):andThen(function(allCrewBattleData)
		RxInstanceUtils.observeChildren(allCrewBattleData, function(maid, crewBattleObj)
			local function handleChange()
				local crewStartTime = PersistentCrewBattleUtils.getCrewStartTime(crewBattleObj)
				local penaltyDuration = PersistentCrewBattleUtils.getCrewPenaltyDuration(crewBattleObj)
				if crewStartTime and penaltyDuration then
					persistentCrewStore:dispatch({
						type = "setStartedAt",
						clanId = crewBattleObj.Name,
						value = crewStartTime - penaltyDuration
					})
				end
				local timeTook = PersistentCrewBattleUtils.getCrewTimeTook(crewBattleObj)
				if timeTook then
					persistentCrewStore:dispatch({
						type = "setTimeTook",
						clanId = crewBattleObj.Name,
						value = timeTook
					})
				end
			end
			handleChange()
			maid:GiveTask(maid:GetAttributeChangedSignal(PersistentCrewBattleConsts.ROUND_START_ATTR_NAME):Connect(handleChange))
			maid:GiveTask(maid:GetAttributeChangedSignal(PersistentCrewBattleConsts.ROUND_PENALTY_DURATION_ATTR_NAME):Connect(handleChange))
			maid:GiveTask(maid:GetAttributeChangedSignal(PersistentCrewBattleConsts.ROUND_TIME_TOOK_ATTR_NAME):Connect(handleChange))
			local function handleClanName()
				persistentCrewStore:dispatch({
					type = "setClanName",
					clanId = crewBattleObj.Name,
					value = crewBattleObj:GetAttribute(PersistentCrewBattleConsts.CLAN_NAME_ATTR_NAME)
				})
			end
			persistentCrewStore:dispatch({
				type = "setClanName",
				clanId = crewBattleObj.Name,
				value = crewBattleObj:GetAttribute(PersistentCrewBattleConsts.CLAN_NAME_ATTR_NAME)
			})
			maid:GiveTask(maid:GetAttributeChangedSignal(PersistentCrewBattleConsts.CLAN_NAME_ATTR_NAME):Connect(handleClanName))
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
	waitForChild(ReplicatedStorage, PersistentCrewBattleConsts.ROBBERIES_COMPLETED_REMOTE_NAME):andThen(function(robberiesCompletedRemote)
		local function receiveRobberiesCompleted(robberiesData)
			persistentCrewStore:dispatch({
				type = "setRobberiesCompleted",
				value = robberiesData
			})
		end
		robberiesCompletedRemote.OnClientEvent:Connect(receiveRobberiesCompleted)
	end)
	waitForChild(ReplicatedStorage, PersistentCrewBattleConsts.ANNOUNCE_PENALTY_REMOTE_NAME):andThen(function(announcePenaltyRemote)
		announcePenaltyRemote.OnClientEvent:Connect(function(penaltyType, penaltyDurationSecs)
			persistentCrewStore:dispatch({
				type = "setPenaltyText",
				value = ("%s +%ss"):format(penaltyType, penaltyDurationSecs)
			})
		end)
	end)
	waitForChild(ReplicatedStorage, PersistentCrewBattleConsts.ANNOUNCE_WIN_REMOTE_NAME):andThen(function(announceWinRemote)
		announceWinRemote.OnClientEvent:Connect(function(didWin)
			if didWin then
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
	local penaltyTimeoutTask = nil
	persistentCrewStore.changed:connect(function(newState, oldState)
		if newState.penalty ~= oldState.penalty then
			if penaltyTimeoutTask then
				task.cancel(penaltyTimeoutTask)
				penaltyTimeoutTask = nil
			end
			if newState.penalty then
				penaltyTimeoutTask = task.delay(5, function()
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
	waitForChild(Players.LocalPlayer, PersistentCrewBattleConsts.INVITES_FOLDER_NAME):andThen(function(invitesFolder)
		local function updateInitiations()
			local invitesList = {}
			for _, inviteObj in invitesFolder:GetChildren() do
				table.insert(invitesList, {
					clanName = inviteObj:GetAttribute(PersistentCrewBattleConsts.INVITE_OPPOSING_CLAN_NAME_ATTR_NAME),
					battleNumPlayersPerTeam = inviteObj:GetAttribute(PersistentCrewBattleConsts.INVITE_NUM_PLAYERS_PER_TEAM_ATTR_NAME),
					clanRating = inviteObj:GetAttribute(PersistentCrewBattleConsts.INVITE_CLAN_DISPLAY_RATING_ATTR_NAME),
					ranked = inviteObj:GetAttribute(PersistentCrewBattleConsts.INVITE_RANKED_ATTR_NAME),
					opposingClanOwnerName = inviteObj:GetAttribute(PersistentCrewBattleConsts.INVITE_OPPOSING_CLAN_OWNER_NAME_ATTR_NAME),
					obj = inviteObj
				})
				Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 9781039157, {
					Volume = 0.2
				})
			end
			persistentCrewStore:dispatch({
				type = "battleInvitesSet",
				list = invitesList
			})
		end
		updateInitiations()
		invitesFolder.ChildAdded:Connect(updateInitiations)
		invitesFolder.ChildRemoved:Connect(updateInitiations)
	end)
	waitForChild(ReplicatedStorage, PersistentCrewBattleConsts.LEADERBOARD_INFO_REMOTE_NAME):andThen(function(leaderboardInfoRemote)
		leaderboardInfoRemote.OnClientEvent:Connect(function(leaderboardData)
			persistentCrewBattleStore:dispatch({
				type = "setCrewLeaderboard",
				value = leaderboardData
			})
		end)
	end)
	waitForChild(ReplicatedStorage, PersistentCrewBattleConsts.CREWS_IN_SERVER_DISPLAY_INFO_REMOTE_NAME):andThen(function(crewsInServerRemote)
		crewsInServerRemote.OnClientEvent:Connect(function(crewsDisplayData)
			persistentCrewBattleStore:dispatch({
				type = "setCrewsInServerDisplayInfo",
				value = crewsDisplayData
			})
		end)
	end)
	waitForChild(ReplicatedStorage, PersistentCrewBattleConsts.UPDATE_BATTLE_RESPONSES_REMOTE_NAME):andThen(function(battleResponsesRemote)
		local acceptedCountPrevious = 0
		battleResponsesRemote.OnClientEvent:Connect(function(battleResponseData, otherData)
			local currentBattleResponseData = persistentCrewStore:getState().battleResponseData
			if battleResponseData ~= nil or (currentBattleResponseData == nil or battleResponseData == currentBattleResponseData.BattleUniqueId) then
				if battleResponseData then
					local acceptedCountCurrent = if battleResponseData.OurClanAccepted then #battleResponseData.OurClanAccepted else 0 + if battleResponseData.TheirClanAccepted then #battleResponseData.TheirClanAccepted else 0
					if acceptedCountPrevious < acceptedCountCurrent and Players.LocalPlayer.PlayerGui then
						Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617498616, {
							Volume = 0.5
						})
					end
					acceptedCountPrevious = acceptedCountCurrent
				end
				persistentCrewStore:dispatch({
					type = "setBattleResponseData",
					value = battleResponseData
				})
			end
		end)
	end)
end
return t
