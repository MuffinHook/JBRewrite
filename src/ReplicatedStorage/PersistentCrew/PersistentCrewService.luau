-- Reviewed by Claude
-- variables reassigned
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Audio = require(ReplicatedStorage.Std.Audio)
local RxInstanceUtils = require(ReplicatedStorage.Std.RxInstanceUtils)
local Roact = require(ReplicatedStorage.Roact)
local PlayerUtils = require(ReplicatedStorage.Std.PlayerUtils)
local Promise = require(ReplicatedStorage.Std.Promise)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
local createElement = Roact.createElement
local ClanConsts = require(ReplicatedStorage.Clan.ClanConsts)
local ClanMatchmakingUtils = require(ReplicatedStorage.ClanMatchmaking.ClanMatchmakingUtils)
local PersistentCrewApp = require(ReplicatedStorage.PersistentCrew.UI.PersistentCrewApp)
local PersistentCrewBattleConsts = require(ReplicatedStorage.PersistentCrewBattle.PersistentCrewBattleConsts)
local persistentCrewStore = require(ReplicatedStorage.PersistentCrew.persistentCrewStore)
local ClanUtils = require(ReplicatedStorage.Clan.ClanUtils)
local PersistentCrewConsts = require(ReplicatedStorage.PersistentCrew.PersistentCrewConsts)
local ClanMatchmakingConsts = require(ReplicatedStorage.ClanMatchmaking.ClanMatchmakingConsts)
local PersistentCrewUtils = require(ReplicatedStorage.PersistentCrew.PersistentCrewUtils)
local waitForChild = require(ReplicatedStorage.Std.waitForChild)
local Confirmation = require(ReplicatedStorage.Module.Confirmation)
require(ReplicatedStorage.Std.Debug.table2Lua)
local String = require(ReplicatedStorage.Std.String)
local function playDrums()
	if Players.LocalPlayer.PlayerGui then
		Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617487453, {
			Volume = 0.5
		})
	end
end
local function playClick()
	if Players.LocalPlayer.PlayerGui then
		Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617491114, {
			Volume = 0.2
		})
	end
end
local t = {
	maid = Maid.new()
}
function t.init()
	local function optimisticallyLockNetworkMutex()
		persistentCrewStore:dispatch({
			type = "setNetworkMutexLocked",
			value = true
		})
	end
	local function attemptLeave()
		local leaveConfirmation = Confirmation.new("Are you sure you want to leave? If you joined for less than " .. ("%d days"):format(ClanConsts.CLAN_JOIN_COOLDOWN_DURATION / 86400) .. ", you\'ll have to wait to join another crew.")
		leaveConfirmation.Maid:GiveTask(leaveConfirmation.OnYes:Connect(function()
			persistentCrewStore:dispatch({
				type = "setNetworkMutexLocked",
				value = true
			})
			ReplicatedStorage:FindFirstChild(ClanConsts.LEAVE_CLAN_REMOTE_NAME):FireServer()
		end))
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617491114, {
				Volume = 0.2
			})
		end
	end
	local function attemptCreate(crewName, crewMotd)
		persistentCrewStore:dispatch({
			type = "setNetworkMutexLocked",
			value = true
		})
		ReplicatedStorage:FindFirstChild(ClanConsts.CREATE_CLAN_REMOTE_NAME):FireServer(crewName, crewMotd)
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617491114, {
				Volume = 0.2
			})
		end
	end
	local function attemptRequestJoinUserId(targetClanId)
		persistentCrewStore:dispatch({
			type = "setNetworkMutexLocked",
			value = true
		})
		ReplicatedStorage:FindFirstChild(ClanConsts.REQUEST_JOIN_CLAN_REMOTE_NAME):FireServer(targetClanId)
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617491114, {
				Volume = 0.2
			})
		end
	end
	local function attemptBattleClanId(targetClanId, numPlayersPerTeam)
		persistentCrewStore:dispatch({
			type = "setNetworkMutexLocked",
			value = true
		})
		ReplicatedStorage:FindFirstChild(PersistentCrewBattleConsts.CUSTOM_BATTLE_INVITE_REMOTE_NAME):FireServer(targetClanId, numPlayersPerTeam)
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617491114, {
				Volume = 0.2
			})
		end
	end
	local function attemptViewUserIdClan(userIdToView)
		persistentCrewStore:dispatch({
			type = "setNetworkMutexLocked",
			value = true
		})
		ReplicatedStorage:FindFirstChild(PersistentCrewConsts.VIEW_CLAN_REMOTE_NAME):FireServer(userIdToView)
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617491114, {
				Volume = 0.2
			})
		end
	end
	local function onAcceptBattleInvite(inviteData)
		ReplicatedStorage:FindFirstChild(PersistentCrewBattleConsts.RESPONSE_REMOTE_NAME):FireServer(inviteData.obj.Name, true)
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617491114, {
				Volume = 0.2
			})
		end
	end
	local function onDeclineBattleInvite(inviteData)
		ReplicatedStorage:FindFirstChild(PersistentCrewBattleConsts.RESPONSE_REMOTE_NAME):FireServer(inviteData.obj.Name, false)
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617491114, {
				Volume = 0.2
			})
		end
	end
	local function onUnAcceptBattleInvite()
		ReplicatedStorage:FindFirstChild(PersistentCrewBattleConsts.UNACCEPT_BATTLE_INVITE_REMOTE_NAME):FireServer()
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617491114, {
				Volume = 0.2
			})
		end
	end
	local function attemptKick(userIdToKick)
		local wasSuccessful, playerDisplayName = PlayerUtils.promiseNameFromUserId(userIdToKick):await()
		if wasSuccessful then
			local kickConfirmation = Confirmation.new("Are you sure you want to kick " .. playerDisplayName .. "?")
			kickConfirmation.Maid:GiveTask(kickConfirmation.OnYes:Connect(function()
				persistentCrewStore:dispatch({
					type = "setNetworkMutexLocked",
					value = true
				})
				ReplicatedStorage:FindFirstChild(ClanConsts.REMOVE_PLAYER_FROM_CLAN_REMOTE_NAME):FireServer(userIdToKick)
			end))
			if Players.LocalPlayer.PlayerGui then
				Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617491114, {
					Volume = 0.2
				})
			end
		end
	end
	local function attemptAdmin(userIdToPromote)
		persistentCrewStore:dispatch({
			type = "setNetworkMutexLocked",
			value = true
		})
		ReplicatedStorage:FindFirstChild(ClanConsts.ADD_PLAYER_AS_ADMIN_REMOTE_NAME):FireServer(userIdToPromote)
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617491114, {
				Volume = 0.2
			})
		end
	end
	local function attemptRenameCrew(newCrewName)
		local renameConfirmation = Confirmation.new("Are you sure you want to rename your crew? This will cost " .. "$" .. String.comma((tostring(ClanConsts.CLAN_RENAME_COST))))
		renameConfirmation.Maid:GiveTask(renameConfirmation.OnYes:Connect(function()
			persistentCrewStore:dispatch({
				type = "setNetworkMutexLocked",
				value = true
			})
			ReplicatedStorage:FindFirstChild(ClanConsts.RENAME_CLAN_REMOTE_NAME):FireServer(newCrewName)
		end))
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617491114, {
				Volume = 0.2
			})
		end
	end
	local function attemptUnAdmin(userIdToDemote)
		persistentCrewStore:dispatch({
			type = "setNetworkMutexLocked",
			value = true
		})
		ReplicatedStorage:FindFirstChild(ClanConsts.REMOVE_PLAYER_ADMIN_REMOTE_NAME):FireServer(userIdToDemote)
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617491114, {
				Volume = 0.2
			})
		end
	end
	local function onClickJoinRequestAccept(requestingUserId)
		persistentCrewStore:dispatch({
			type = "setNetworkMutexLocked",
			value = true
		})
		ReplicatedStorage:FindFirstChild(ClanConsts.ACCEPT_JOIN_REQUEST_REMOTE_NAME):FireServer(requestingUserId)
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617491114, {
				Volume = 0.2
			})
		end
	end
	local function onClickJoinRequestDeny(requestingUserId)
		persistentCrewStore:dispatch({
			type = "setNetworkMutexLocked",
			value = true
		})
		ReplicatedStorage:FindFirstChild(ClanConsts.DENY_JOIN_REQUEST_REMOTE_NAME):FireServer(requestingUserId)
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617491114, {
				Volume = 0.2
			})
		end
	end
	local function onClickReadyUp()
		persistentCrewStore:dispatch({
			type = "setNetworkMutexLocked",
			value = true
		})
		ReplicatedStorage:FindFirstChild(ClanMatchmakingConsts.READY_UP_REMOTE_NAME):FireServer()
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617491114, {
				Volume = 0.2
			})
		end
	end
	local function onClickUnreadyUp()
		persistentCrewStore:dispatch({
			type = "setNetworkMutexLocked",
			value = true
		})
		ReplicatedStorage:FindFirstChild(ClanMatchmakingConsts.UNREADY_UP_REMOTE_NAME):FireServer()
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617491114, {
				Volume = 0.2
			})
		end
	end
	local function attemptReportCrew(targetClanId, reportOption)
		assert(typeof(reportOption) == "string", "invalid report option")
		ReplicatedStorage:FindFirstChild(PersistentCrewBattleConsts.REPORT_CLAN_REMOTE_NAME):FireServer(targetClanId, reportOption)
	end
	local countdownTimesPlayed = 0
	local function onCountdownFinished()
		if countdownTimesPlayed < 1 and Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617487453, {
				Volume = 0.5
			})
		end
		countdownTimesPlayed = countdownTimesPlayed + 1
	end
	local guiElement = Roact.mount(createElement("ScreenGui", {
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		ResetOnSpawn = false,
		IgnoreGuiInset = true,
		DisplayOrder = 0
	}, { Roact.createElement(RoactRodux.StoreProvider, {
			store = persistentCrewStore
		}, { createElement(PersistentCrewApp, {
				attemptLeave = attemptLeave,
				attemptCreate = attemptCreate,
				attemptRequestJoinUserId = attemptRequestJoinUserId,
				attemptBattleClanId = attemptBattleClanId,
				attemptViewUserIdClan = attemptViewUserIdClan,
				onAcceptBattleInvite = onAcceptBattleInvite,
				onDeclineBattleInvite = onDeclineBattleInvite,
				onCountdownFinished = onCountdownFinished,
				attemptKick = attemptKick,
				attemptAdmin = attemptAdmin,
				attemptUnAdmin = attemptUnAdmin,
				attemptRenameCrew = attemptRenameCrew,
				onClickJoinRequestAccept = onClickJoinRequestAccept,
				onClickJoinRequestDeny = onClickJoinRequestDeny,
				onClickReadyUp = onClickReadyUp,
				onClickUnreadyUp = onClickUnreadyUp,
				onUnAcceptBattleInvite = onUnAcceptBattleInvite,
				optimisticallyLockNetworkMutex = optimisticallyLockNetworkMutex,
				attemptReportCrew = attemptReportCrew
			}) }) }), Players.LocalPlayer.PlayerGui, "PersistentCrewUI")
	t.maid:GiveTask(function()
		Roact.unmount(guiElement)
	end)
	RxInstanceUtils.observeAttribute(Players.LocalPlayer, ClanConsts.NETWORK_MUTEX_LOCKED_ATTR_NAME, function(lockValue)
		persistentCrewStore:dispatch({
			type = "setNetworkMutexLocked",
			value = lockValue
		})
	end)
	local networkMutexTimeoutTask = nil
	persistentCrewStore.changed:connect(function(newState, oldState)
		if newState.networkMutexLocked ~= oldState.networkMutexLocked then
			if networkMutexTimeoutTask then
				task.cancel(networkMutexTimeoutTask)
				networkMutexTimeoutTask = nil
			end
			if newState.networkMutexLocked then
				networkMutexTimeoutTask = task.delay(0.75, function()
					if not Players.LocalPlayer:GetAttribute(ClanConsts.NETWORK_MUTEX_LOCKED_ATTR_NAME) then
						persistentCrewStore:dispatch({
							type = "setNetworkMutexLocked",
							value = false
						})
					end
				end)
			end
		end
		if newState.groupVisible ~= oldState.groupVisible then
			ReplicatedStorage:FindFirstChild(PersistentCrewConsts.INFORM_UI_IS_OPEN_REMOTE_NAME):FireServer(newState.groupVisible)
		end
	end)
	RxInstanceUtils.waitForChild(ReplicatedStorage, PersistentCrewConsts.UPDATE_PERSISTENT_CREW_REMOTE_NAME):andThen(function(updateCrewRemote)
		updateCrewRemote.OnClientEvent:Connect(function(crewInfo)
			if crewInfo then
				persistentCrewStore:dispatch({
					type = "setViewingClanInfo",
					value = crewInfo
				})
				if crewInfo.IsPlayersClan then
					persistentCrewStore:dispatch({
						type = "setCurrentClanInfo",
						value = crewInfo
					})
				end
				local AdminIdMap = crewInfo.AdminIdMap
				local isPlayerAdmin = AdminIdMap[tostring(Players.LocalPlayer.UserId)] == true
				local memberBattleInfoMap = crewInfo.MemberBattleInfoMap or {}
				local promisesArray = {}
				local membersList = {}
				for memberIdStr, memberData in crewInfo.Members do
					local battleInfo = memberBattleInfoMap[memberIdStr] or {}
					local battlesWon = battleInfo.BattlesWon or 0
					local battlesPlayed = battleInfo.BattlesPlayed or 0
					local memberId = tonumber(memberIdStr)
					table.insert(promisesArray, PlayerUtils.promiseNameFromUserId(memberId):andThen(function(displayName)
						local memberDisplayInfo = {
							id = memberId,
							userId = memberId,
							displayName = displayName,
							isAdmin = AdminIdMap[memberIdStr],
							showKick = isPlayerAdmin
						}
						local canShowAdminButton = isPlayerAdmin
						if canShowAdminButton then
							canShowAdminButton = not (AdminIdMap[memberIdStr] == true)
						end
						memberDisplayInfo.showAdmin = canShowAdminButton
						memberDisplayInfo.showUnAdmin = isPlayerAdmin and AdminIdMap[memberIdStr] == true
						memberDisplayInfo.battlesPlayed = battlesPlayed
						memberDisplayInfo.battlesWon = battlesWon
						table.insert(membersList, memberDisplayInfo)
					end))
				end
				Promise.all(promisesArray):andThen(function()
					persistentCrewStore:dispatch({
						type = "setMembers",
						value = membersList
					})
				end)
				local joinRequestsList = {}
				if isPlayerAdmin then
					local joinRequestPromises = {}
					for requestIdStr in crewInfo.JoinRequests do
						local requestUserId = tonumber(requestIdStr)
						table.insert(joinRequestPromises, PlayerUtils.promiseNameFromUserId(requestUserId):andThen(function(displayName)
							table.insert(joinRequestsList, {
								id = requestUserId,
								userId = requestUserId,
								displayName = displayName,
								showRequestAccept = isPlayerAdmin,
								showRequestDeny = isPlayerAdmin
							})
						end):catch(function()
							table.insert(joinRequestsList, {
								id = requestUserId,
								userId = requestUserId,
								displayName = "[#" .. requestUserId .. "]",
								showRequestAccept = isPlayerAdmin,
								showRequestDeny = isPlayerAdmin
							})
						end))
					end
					Promise.allSettled(joinRequestPromises):andThen(function()
						persistentCrewStore:dispatch({
							type = "setJoinRequests",
							value = joinRequestsList
						})
					end)
				else
					persistentCrewStore:dispatch({
						type = "setJoinRequests",
						value = joinRequestsList
					})
				end
			end
		end)
	end)
	local function invalidateOnline()
		persistentCrewStore:dispatch({
			type = "setMembersOnlineMap",
			value = nil
		})
	end
	local viewingClanMaid = Maid.new()
	local function updateViewingInfo()
		viewingClanMaid:DoCleaning()
		persistentCrewStore:dispatch({
			type = "setMembersOnlineMap",
			value = nil
		})
		local viewingClanId = PersistentCrewUtils.getPlayerViewingClanId(Players.LocalPlayer)
		if not viewingClanId then
			persistentCrewStore:dispatch({
				type = "setViewingClanInfo",
				value = nil
			})
		end
		if viewingClanId then
			viewingClanMaid:GivePromise(waitForChild(ReplicatedStorage, ClanConsts.MEMBERS_ONLINE_OBJECT_NAME, 5):andThen(function(membersOnlineFolder)
				return waitForChild(membersOnlineFolder, viewingClanId, 5)
			end):andThen(function()
				local function updateOnline()
					persistentCrewStore:dispatch({
						type = "setMembersOnlineMap",
						value = ClanUtils.getMembersOnline(viewingClanId)
					})
				end
				persistentCrewStore:dispatch({
					type = "setMembersOnlineMap",
					value = ClanUtils.getMembersOnline(viewingClanId)
				})
				viewingClanMaid:GiveTask(ClanUtils.getMembersOnlineChangedSignal(viewingClanId):Connect(updateOnline))
			end))
		end
	end
	PersistentCrewUtils.getPlayerViewingClanIdChangedSignal(Players.LocalPlayer):Connect(updateViewingInfo)
	updateViewingInfo()
	local currentClanMaid = Maid.new()
	local function updateCurrentInfo()
		local currentClanId = ClanUtils.getCurrentClanId(Players.LocalPlayer)
		if not currentClanId then
			persistentCrewStore:dispatch({
				type = "setCurrentClanInfo",
				value = nil
			})
		end
		local readyUpObservable
		if currentClanId then
			local function dispatchReadyUpChanges()
				persistentCrewStore:dispatch({
					type = "setIsReadiedUp",
					value = ClanMatchmakingUtils.getIsClanReadiedUp(currentClanId)
				})
			end
			local function observableCallback(maid)
				persistentCrewStore:dispatch({
					type = "setIsReadiedUp",
					value = ClanMatchmakingUtils.getIsClanReadiedUp(currentClanId)
				})
				maid:GiveTask(dispatchReadyUpChanges)
			end
			readyUpObservable = ClanMatchmakingUtils.observeIsClanReadiedUp(currentClanId, observableCallback)
			persistentCrewStore:dispatch({
				type = "setIsReadiedUp",
				value = ClanMatchmakingUtils.getIsClanReadiedUp(currentClanId)
			})
			readyUpObservable = readyUpObservable
		else
			readyUpObservable = nil
		end
		currentClanMaid.observingClan = readyUpObservable
	end
	ClanUtils.getCurrentClanIdChangedSignal(Players.LocalPlayer):Connect(updateCurrentInfo)
	updateCurrentInfo()
end
return t
