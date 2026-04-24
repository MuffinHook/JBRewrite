-- Reviewed by Claude
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
		local v2 = Confirmation.new("Are you sure you want to leave? If you joined for less than " .. ("%d days"):format(ClanConsts.CLAN_JOIN_COOLDOWN_DURATION / 86400) .. ", you\'ll have to wait to join another crew.")
		v2.Maid:GiveTask(v2.OnYes:Connect(function()
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
	local function attemptCreate(p1, p2)
		persistentCrewStore:dispatch({
			type = "setNetworkMutexLocked",
			value = true
		})
		ReplicatedStorage:FindFirstChild(ClanConsts.CREATE_CLAN_REMOTE_NAME):FireServer(p1, p2)
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617491114, {
				Volume = 0.2
			})
		end
	end
	local function attemptRequestJoinUserId(p1)
		persistentCrewStore:dispatch({
			type = "setNetworkMutexLocked",
			value = true
		})
		ReplicatedStorage:FindFirstChild(ClanConsts.REQUEST_JOIN_CLAN_REMOTE_NAME):FireServer(p1)
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617491114, {
				Volume = 0.2
			})
		end
	end
	local function attemptBattleClanId(p1, p2)
		persistentCrewStore:dispatch({
			type = "setNetworkMutexLocked",
			value = true
		})
		ReplicatedStorage:FindFirstChild(PersistentCrewBattleConsts.CUSTOM_BATTLE_INVITE_REMOTE_NAME):FireServer(p1, p2)
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617491114, {
				Volume = 0.2
			})
		end
	end
	local function attemptViewUserIdClan(p1)
		persistentCrewStore:dispatch({
			type = "setNetworkMutexLocked",
			value = true
		})
		ReplicatedStorage:FindFirstChild(PersistentCrewConsts.VIEW_CLAN_REMOTE_NAME):FireServer(p1)
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617491114, {
				Volume = 0.2
			})
		end
	end
	local function onAcceptBattleInvite(p1)
		ReplicatedStorage:FindFirstChild(PersistentCrewBattleConsts.RESPONSE_REMOTE_NAME):FireServer(p1.obj.Name, true)
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617491114, {
				Volume = 0.2
			})
		end
	end
	local function onDeclineBattleInvite(p1)
		ReplicatedStorage:FindFirstChild(PersistentCrewBattleConsts.RESPONSE_REMOTE_NAME):FireServer(p1.obj.Name, false)
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
	local function attemptKick(p1)
		local v1, v2 = PlayerUtils.promiseNameFromUserId(p1):await()
		if v1 then
			local v3 = Confirmation.new("Are you sure you want to kick " .. v2 .. "?")
			v3.Maid:GiveTask(v3.OnYes:Connect(function()
				persistentCrewStore:dispatch({
					type = "setNetworkMutexLocked",
					value = true
				})
				ReplicatedStorage:FindFirstChild(ClanConsts.REMOVE_PLAYER_FROM_CLAN_REMOTE_NAME):FireServer(p1)
			end))
			if Players.LocalPlayer.PlayerGui then
				Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617491114, {
					Volume = 0.2
				})
			end
		end
	end
	local function attemptAdmin(p1)
		persistentCrewStore:dispatch({
			type = "setNetworkMutexLocked",
			value = true
		})
		ReplicatedStorage:FindFirstChild(ClanConsts.ADD_PLAYER_AS_ADMIN_REMOTE_NAME):FireServer(p1)
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617491114, {
				Volume = 0.2
			})
		end
	end
	local function attemptRenameCrew(p1)
		local v2 = Confirmation.new("Are you sure you want to rename your crew? This will cost " .. "$" .. String.comma((tostring(ClanConsts.CLAN_RENAME_COST))))
		v2.Maid:GiveTask(v2.OnYes:Connect(function()
			persistentCrewStore:dispatch({
				type = "setNetworkMutexLocked",
				value = true
			})
			ReplicatedStorage:FindFirstChild(ClanConsts.RENAME_CLAN_REMOTE_NAME):FireServer(p1)
		end))
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617491114, {
				Volume = 0.2
			})
		end
	end
	local function attemptUnAdmin(p1)
		persistentCrewStore:dispatch({
			type = "setNetworkMutexLocked",
			value = true
		})
		ReplicatedStorage:FindFirstChild(ClanConsts.REMOVE_PLAYER_ADMIN_REMOTE_NAME):FireServer(p1)
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617491114, {
				Volume = 0.2
			})
		end
	end
	local function onClickJoinRequestAccept(p1)
		persistentCrewStore:dispatch({
			type = "setNetworkMutexLocked",
			value = true
		})
		ReplicatedStorage:FindFirstChild(ClanConsts.ACCEPT_JOIN_REQUEST_REMOTE_NAME):FireServer(p1)
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617491114, {
				Volume = 0.2
			})
		end
	end
	local function onClickJoinRequestDeny(p1)
		persistentCrewStore:dispatch({
			type = "setNetworkMutexLocked",
			value = true
		})
		ReplicatedStorage:FindFirstChild(ClanConsts.DENY_JOIN_REQUEST_REMOTE_NAME):FireServer(p1)
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
	local function attemptReportCrew(p1, p2)
		assert(typeof(p1) == "string", "invalid report option")
		ReplicatedStorage:FindFirstChild(PersistentCrewBattleConsts.REPORT_CLAN_REMOTE_NAME):FireServer(p1, p2)
	end
	local v1 = 0
	local function onCountdownFinished()
		if v1 < 1 and Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617487453, {
				Volume = 0.5
			})
		end
		v1 = v1 + 1
	end
	local v2 = Roact.mount(createElement("ScreenGui", {
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
		Roact.unmount(v2)
	end)
	RxInstanceUtils.observeAttribute(Players.LocalPlayer, ClanConsts.NETWORK_MUTEX_LOCKED_ATTR_NAME, function(p1)
		persistentCrewStore:dispatch({
			type = "setNetworkMutexLocked",
			value = p1
		})
	end)
	local v3 = nil
	persistentCrewStore.changed:connect(function(p1, p2)
		if p1.networkMutexLocked ~= p2.networkMutexLocked then
			if v3 then
				task.cancel(v3)
				v3 = nil
			end
			if p1.networkMutexLocked then
				v3 = task.delay(0.75, function()
					if not Players.LocalPlayer:GetAttribute(ClanConsts.NETWORK_MUTEX_LOCKED_ATTR_NAME) then
						persistentCrewStore:dispatch({
							type = "setNetworkMutexLocked",
							value = false
						})
					end
				end)
			end
		end
		if p1.groupVisible ~= p2.groupVisible then
			ReplicatedStorage:FindFirstChild(PersistentCrewConsts.INFORM_UI_IS_OPEN_REMOTE_NAME):FireServer(p1.groupVisible)
		end
	end)
	RxInstanceUtils.waitForChild(ReplicatedStorage, PersistentCrewConsts.UPDATE_PERSISTENT_CREW_REMOTE_NAME):andThen(function(p1)
		p1.OnClientEvent:Connect(function(p1)
			if p1 then
				persistentCrewStore:dispatch({
					type = "setViewingClanInfo",
					value = p1
				})
				if p1.IsPlayersClan then
					persistentCrewStore:dispatch({
						type = "setCurrentClanInfo",
						value = p1
					})
				end
				local AdminIdMap = p1.AdminIdMap
				local v1 = AdminIdMap[tostring(Players.LocalPlayer.UserId)] == true
				local v2 = p1.MemberBattleInfoMap or {}
				local t = {}
				local t2 = {}
				for v3, v4 in p1.Members do
					local v5 = v2[v3] or {}
					local v6 = v5.BattlesWon or 0
					local v7 = v5.BattlesPlayed or 0
					local v8 = tonumber(v3)
					table.insert(t, PlayerUtils.promiseNameFromUserId(v8):andThen(function(p1)
						local t = {
							id = v8,
							userId = v8,
							displayName = p1,
							isAdmin = AdminIdMap[v3],
							showKick = v1
						}
						local v2 = v1
						if v2 then
							v2 = not (AdminIdMap[v3] == true)
						end
						t.showAdmin = v2
						t.showUnAdmin = v1 and AdminIdMap[v3] == true
						t.battlesPlayed = v7
						t.battlesWon = v6
						table.insert(t2, t)
					end))
				end
				Promise.all(t):andThen(function()
					persistentCrewStore:dispatch({
						type = "setMembers",
						value = t2
					})
				end)
				local t3 = {}
				if v1 then
					local t4 = {}
					for v10 in p1.JoinRequests do
						local v11 = tonumber(v10)
						table.insert(t4, PlayerUtils.promiseNameFromUserId(v11):andThen(function(p1)
							table.insert(t3, {
								id = v11,
								userId = v11,
								displayName = p1,
								showRequestAccept = v1,
								showRequestDeny = v1
							})
						end):catch(function(p1)
							table.insert(t3, {
								id = v11,
								userId = v11,
								displayName = "[#" .. v11 .. "]",
								showRequestAccept = v1,
								showRequestDeny = v1
							})
						end))
					end
					Promise.allSettled(t4):andThen(function()
						persistentCrewStore:dispatch({
							type = "setJoinRequests",
							value = t3
						})
					end)
				else
					persistentCrewStore:dispatch({
						type = "setJoinRequests",
						value = t3
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
	local v4 = Maid.new()
	local function updateViewingInfo()
		v4:DoCleaning()
		persistentCrewStore:dispatch({
			type = "setMembersOnlineMap",
			value = nil
		})
		local v1 = PersistentCrewUtils.getPlayerViewingClanId(Players.LocalPlayer)
		if not v1 then
			persistentCrewStore:dispatch({
				type = "setViewingClanInfo",
				value = nil
			})
		end
		if v1 then
			v4:GivePromise(waitForChild(ReplicatedStorage, ClanConsts.MEMBERS_ONLINE_OBJECT_NAME, 5):andThen(function(p1)
				return waitForChild(p1, v1, 5)
			end):andThen(function()
				local function updateOnline()
					persistentCrewStore:dispatch({
						type = "setMembersOnlineMap",
						value = ClanUtils.getMembersOnline(v1)
					})
				end
				persistentCrewStore:dispatch({
					type = "setMembersOnlineMap",
					value = ClanUtils.getMembersOnline(v1)
				})
				v4:GiveTask(ClanUtils.getMembersOnlineChangedSignal(v1):Connect(updateOnline))
			end))
		end
	end
	PersistentCrewUtils.getPlayerViewingClanIdChangedSignal(Players.LocalPlayer):Connect(updateViewingInfo)
	updateViewingInfo()
	local v5 = Maid.new()
	local function updateCurrentInfo()
		local v1 = ClanUtils.getCurrentClanId(Players.LocalPlayer)
		if not v1 then
			persistentCrewStore:dispatch({
				type = "setCurrentClanInfo",
				value = nil
			})
		end
		local v2
		if v1 then
			local function dispatchReadyUpChanges()
				persistentCrewStore:dispatch({
					type = "setIsReadiedUp",
					value = ClanMatchmakingUtils.getIsClanReadiedUp(v1)
				})
			end
			local function callbackWrapper(p1, p2)
				persistentCrewStore:dispatch({
					type = "setIsReadiedUp",
					value = ClanMatchmakingUtils.getIsClanReadiedUp(v1)
				})
				p2:GiveTask(dispatchReadyUpChanges)
			end
			local v3 = ClanMatchmakingUtils.observeIsClanReadiedUp(v1, callbackWrapper)
			persistentCrewStore:dispatch({
				type = "setIsReadiedUp",
				value = ClanMatchmakingUtils.getIsClanReadiedUp(v1)
			})
			v2 = v3
		else
			v2 = nil
		end
		v5.observingClan = v2
	end
	ClanUtils.getCurrentClanIdChangedSignal(Players.LocalPlayer):Connect(updateCurrentInfo)
	updateCurrentInfo()
end
return t
