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
local function playDrums() --[[ Line: 26 | Upvalues: Players (copy), Audio (copy) ]]
	if Players.LocalPlayer.PlayerGui then
		Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617487453, {
			Volume = 0.5
		})
	end
end
local function playClick() --[[ Line: 31 | Upvalues: Players (copy), Audio (copy) ]]
	if Players.LocalPlayer.PlayerGui then
		Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617491114, {
			Volume = 0.2
		})
	end
end
local t = {
	maid = Maid.new()
}
function t.init() --[[ Line: 39 | Upvalues: persistentCrewStore (copy), ClanConsts (copy), Confirmation (copy), ReplicatedStorage (copy), Players (copy), Audio (copy), PersistentCrewBattleConsts (copy), PersistentCrewConsts (copy), PlayerUtils (copy), String (copy), ClanMatchmakingConsts (copy), Roact (copy), createElement (copy), RoactRodux (copy), PersistentCrewApp (copy), t (copy), RxInstanceUtils (copy), Promise (copy), Maid (copy), PersistentCrewUtils (copy), waitForChild (copy), ClanUtils (copy), ClanMatchmakingUtils (copy) ]]
	local function optimisticallyLockNetworkMutex() --[[ Line: 40 | Upvalues: persistentCrewStore (ref) ]]
		persistentCrewStore:dispatch({
			type = "setNetworkMutexLocked",
			value = true
		})
	end
	local function attemptLeave() --[[ Line: 46 | Upvalues: ClanConsts (ref), Confirmation (ref), persistentCrewStore (ref), ReplicatedStorage (ref), Players (ref), Audio (ref) ]]
		local v2 = Confirmation.new("Are you sure you want to leave? If you joined for less than " .. ("%d days"):format(ClanConsts.CLAN_JOIN_COOLDOWN_DURATION / 86400) .. ", you\'ll have to wait to join another crew.")
		v2.Maid:GiveTask(v2.OnYes:Connect(function() --[[ Line: 54 | Upvalues: persistentCrewStore (ref), ReplicatedStorage (ref), ClanConsts (ref) ]]
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
	local function attemptCreate(p1, p2) --[[ Line: 60 | Upvalues: persistentCrewStore (ref), ReplicatedStorage (ref), ClanConsts (ref), Players (ref), Audio (ref) ]]
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
	local function attemptRequestJoinUserId(p1) --[[ Line: 65 | Upvalues: persistentCrewStore (ref), ReplicatedStorage (ref), ClanConsts (ref), Players (ref), Audio (ref) ]]
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
	local function attemptBattleClanId(p1, p2) --[[ Line: 70 | Upvalues: persistentCrewStore (ref), ReplicatedStorage (ref), PersistentCrewBattleConsts (ref), Players (ref), Audio (ref) ]]
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
	local function attemptViewUserIdClan(p1) --[[ Line: 76 | Upvalues: persistentCrewStore (ref), ReplicatedStorage (ref), PersistentCrewConsts (ref), Players (ref), Audio (ref) ]]
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
	local function onAcceptBattleInvite(p1) --[[ Line: 81 | Upvalues: ReplicatedStorage (ref), PersistentCrewBattleConsts (ref), Players (ref), Audio (ref) ]]
		ReplicatedStorage:FindFirstChild(PersistentCrewBattleConsts.RESPONSE_REMOTE_NAME):FireServer(p1.obj.Name, true)
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617491114, {
				Volume = 0.2
			})
		end
	end
	local function onDeclineBattleInvite(p1) --[[ Line: 86 | Upvalues: ReplicatedStorage (ref), PersistentCrewBattleConsts (ref), Players (ref), Audio (ref) ]]
		ReplicatedStorage:FindFirstChild(PersistentCrewBattleConsts.RESPONSE_REMOTE_NAME):FireServer(p1.obj.Name, false)
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617491114, {
				Volume = 0.2
			})
		end
	end
	local function onUnAcceptBattleInvite() --[[ Line: 92 | Upvalues: ReplicatedStorage (ref), PersistentCrewBattleConsts (ref), Players (ref), Audio (ref) ]]
		ReplicatedStorage:FindFirstChild(PersistentCrewBattleConsts.UNACCEPT_BATTLE_INVITE_REMOTE_NAME):FireServer()
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617491114, {
				Volume = 0.2
			})
		end
	end
	local function attemptKick(p1) --[[ Line: 97 | Upvalues: PlayerUtils (ref), Confirmation (ref), persistentCrewStore (ref), ReplicatedStorage (ref), ClanConsts (ref), Players (ref), Audio (ref) ]]
		local v1, v2 = PlayerUtils.promiseNameFromUserId(p1):await()
		if v1 then
			local v3 = Confirmation.new("Are you sure you want to kick " .. v2 .. "?")
			v3.Maid:GiveTask(v3.OnYes:Connect(function() --[[ Line: 103 | Upvalues: persistentCrewStore (ref), ReplicatedStorage (ref), ClanConsts (ref), p1 (copy) ]]
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
	local function attemptAdmin(p1) --[[ Line: 109 | Upvalues: persistentCrewStore (ref), ReplicatedStorage (ref), ClanConsts (ref), Players (ref), Audio (ref) ]]
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
	local function attemptRenameCrew(p1) --[[ Line: 114 | Upvalues: Confirmation (ref), String (ref), ClanConsts (ref), persistentCrewStore (ref), ReplicatedStorage (ref), Players (ref), Audio (ref) ]]
		local v2 = Confirmation.new("Are you sure you want to rename your crew? This will cost " .. "$" .. String.comma((tostring(ClanConsts.CLAN_RENAME_COST))))
		v2.Maid:GiveTask(v2.OnYes:Connect(function() --[[ Line: 120 | Upvalues: persistentCrewStore (ref), ReplicatedStorage (ref), ClanConsts (ref), p1 (copy) ]]
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
	local function attemptUnAdmin(p1) --[[ Line: 126 | Upvalues: persistentCrewStore (ref), ReplicatedStorage (ref), ClanConsts (ref), Players (ref), Audio (ref) ]]
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
	local function onClickJoinRequestAccept(p1) --[[ Line: 131 | Upvalues: persistentCrewStore (ref), ReplicatedStorage (ref), ClanConsts (ref), Players (ref), Audio (ref) ]]
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
	local function onClickJoinRequestDeny(p1) --[[ Line: 136 | Upvalues: persistentCrewStore (ref), ReplicatedStorage (ref), ClanConsts (ref), Players (ref), Audio (ref) ]]
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
	local function onClickReadyUp() --[[ Line: 141 | Upvalues: persistentCrewStore (ref), ReplicatedStorage (ref), ClanMatchmakingConsts (ref), Players (ref), Audio (ref) ]]
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
	local function onClickUnreadyUp() --[[ Line: 146 | Upvalues: persistentCrewStore (ref), ReplicatedStorage (ref), ClanMatchmakingConsts (ref), Players (ref), Audio (ref) ]]
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
	local function attemptReportCrew(p1, p2) --[[ Line: 151 | Upvalues: ReplicatedStorage (ref), PersistentCrewBattleConsts (ref) ]]
		assert(typeof(p1) == "string", "invalid report option")
		ReplicatedStorage:FindFirstChild(PersistentCrewBattleConsts.REPORT_CLAN_REMOTE_NAME):FireServer(p1, p2)
	end
	local v1 = 0
	local function onCountdownFinished() --[[ Line: 157 | Upvalues: v1 (ref), Players (ref), Audio (ref) ]]
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
	t.maid:GiveTask(function() --[[ Line: 203 | Upvalues: Roact (ref), v2 (copy) ]]
		Roact.unmount(v2)
	end)
	RxInstanceUtils.observeAttribute(Players.LocalPlayer, ClanConsts.NETWORK_MUTEX_LOCKED_ATTR_NAME, function(p1) --[[ Line: 210 | Upvalues: persistentCrewStore (ref) ]]
		persistentCrewStore:dispatch({
			type = "setNetworkMutexLocked",
			value = p1
		})
	end)
	local v3 = nil
	persistentCrewStore.changed:connect(function(p1, p2) --[[ Line: 218 | Upvalues: v3 (ref), Players (ref), ClanConsts (ref), persistentCrewStore (ref), ReplicatedStorage (ref), PersistentCrewConsts (ref) ]]
		if p1.networkMutexLocked ~= p2.networkMutexLocked then
			if v3 then
				task.cancel(v3)
				v3 = nil
			end
			if p1.networkMutexLocked then
				v3 = task.delay(0.75, function() --[[ Line: 228 | Upvalues: Players (ref), ClanConsts (ref), persistentCrewStore (ref) ]]
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
	RxInstanceUtils.waitForChild(ReplicatedStorage, PersistentCrewConsts.UPDATE_PERSISTENT_CREW_REMOTE_NAME):andThen(function(p1) --[[ Line: 249 | Upvalues: persistentCrewStore (ref), Players (ref), PlayerUtils (ref), Promise (ref) ]]
		p1.OnClientEvent:Connect(function(p1) --[[ Line: 250 | Upvalues: persistentCrewStore (ref), Players (ref), PlayerUtils (ref), Promise (ref) ]]
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
					table.insert(t, PlayerUtils.promiseNameFromUserId(v8):andThen(function(p1) --[[ Line: 282 | Upvalues: t2 (copy), v8 (copy), AdminIdMap (copy), v3 (copy), v1 (copy), v7 (copy), v6 (copy) ]]
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
				Promise.all(t):andThen(function() --[[ Line: 297 | Upvalues: persistentCrewStore (ref), t2 (copy) ]]
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
						table.insert(t4, PlayerUtils.promiseNameFromUserId(v11):andThen(function(p1) --[[ Line: 313 | Upvalues: t3 (copy), v11 (copy), v1 (copy) ]]
							table.insert(t3, {
								id = v11,
								userId = v11,
								displayName = p1,
								showRequestAccept = v1,
								showRequestDeny = v1
							})
						end):catch(function(p1) --[[ Line: 322 | Upvalues: t3 (copy), v11 (copy), v1 (copy) ]]
							table.insert(t3, {
								id = v11,
								userId = v11,
								displayName = "[#" .. v11 .. "]",
								showRequestAccept = v1,
								showRequestDeny = v1
							})
						end))
					end
					Promise.allSettled(t4):andThen(function() --[[ Line: 334 | Upvalues: persistentCrewStore (ref), t3 (copy) ]]
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
	local function invalidateOnline() --[[ Line: 349 | Upvalues: persistentCrewStore (ref) ]]
		persistentCrewStore:dispatch({
			type = "setMembersOnlineMap",
			value = nil
		})
	end
	local v4 = Maid.new()
	local function updateViewingInfo() --[[ Line: 356 | Upvalues: v4 (copy), persistentCrewStore (ref), PersistentCrewUtils (ref), Players (ref), waitForChild (ref), ReplicatedStorage (ref), ClanConsts (ref), ClanUtils (ref) ]]
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
			v4:GivePromise(waitForChild(ReplicatedStorage, ClanConsts.MEMBERS_ONLINE_OBJECT_NAME, 5):andThen(function(p1) --[[ Line: 371 | Upvalues: waitForChild (ref), v1 (copy) ]]
				return waitForChild(p1, v1, 5)
			end):andThen(function() --[[ Line: 374 | Upvalues: persistentCrewStore (ref), ClanUtils (ref), v1 (copy), v4 (ref) ]]
				local function updateOnline() --[[ Line: 377 | Upvalues: persistentCrewStore (ref), ClanUtils (ref), v1 (ref) ]]
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
	local function updateCurrentInfo() --[[ Line: 394 | Upvalues: ClanUtils (ref), Players (ref), persistentCrewStore (ref), ClanMatchmakingUtils (ref), v5 (copy) ]]
		local v1 = ClanUtils.getCurrentClanId(Players.LocalPlayer)
		if not v1 then
			persistentCrewStore:dispatch({
				type = "setCurrentClanInfo",
				value = nil
			})
		end
		local v2
		if v1 then
			local function dispatchReadyUpChanges() --[[ Line: 404 | Upvalues: ClanMatchmakingUtils (ref), v1 (copy), persistentCrewStore (ref) ]]
				persistentCrewStore:dispatch({
					type = "setIsReadiedUp",
					value = ClanMatchmakingUtils.getIsClanReadiedUp(v1)
				})
			end
			local function callbackWrapper(p1, p2) --[[ Line: 411 | Upvalues: ClanMatchmakingUtils (ref), v1 (copy), persistentCrewStore (ref), dispatchReadyUpChanges (copy) ]]
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