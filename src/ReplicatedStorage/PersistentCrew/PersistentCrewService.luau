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
		local local2 = Confirmation.new("Are you sure you want to leave? If you joined for less than " .. ("%d days"):format(ClanConsts.CLAN_JOIN_COOLDOWN_DURATION / 86400) .. ", you\'ll have to wait to join another crew.")
		local2.Maid:GiveTask(local2.OnYes:Connect(function()
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
	local function attemptCreate(self, self)
		persistentCrewStore:dispatch({
			type = "setNetworkMutexLocked",
			value = true
		})
		ReplicatedStorage:FindFirstChild(ClanConsts.CREATE_CLAN_REMOTE_NAME):FireServer(self, self)
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617491114, {
				Volume = 0.2
			})
		end
	end
	local function attemptRequestJoinUserId(self)
		persistentCrewStore:dispatch({
			type = "setNetworkMutexLocked",
			value = true
		})
		ReplicatedStorage:FindFirstChild(ClanConsts.REQUEST_JOIN_CLAN_REMOTE_NAME):FireServer(self)
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617491114, {
				Volume = 0.2
			})
		end
	end
	local function attemptBattleClanId(self, self)
		persistentCrewStore:dispatch({
			type = "setNetworkMutexLocked",
			value = true
		})
		ReplicatedStorage:FindFirstChild(PersistentCrewBattleConsts.CUSTOM_BATTLE_INVITE_REMOTE_NAME):FireServer(self, self)
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617491114, {
				Volume = 0.2
			})
		end
	end
	local function attemptViewUserIdClan(self)
		persistentCrewStore:dispatch({
			type = "setNetworkMutexLocked",
			value = true
		})
		ReplicatedStorage:FindFirstChild(PersistentCrewConsts.VIEW_CLAN_REMOTE_NAME):FireServer(self)
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617491114, {
				Volume = 0.2
			})
		end
	end
	local function onAcceptBattleInvite(self)
		ReplicatedStorage:FindFirstChild(PersistentCrewBattleConsts.RESPONSE_REMOTE_NAME):FireServer(self.obj.Name, true)
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617491114, {
				Volume = 0.2
			})
		end
	end
	local function onDeclineBattleInvite(self)
		ReplicatedStorage:FindFirstChild(PersistentCrewBattleConsts.RESPONSE_REMOTE_NAME):FireServer(self.obj.Name, false)
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
	local function attemptKick(self)
		local counter, local2 = PlayerUtils.promiseNameFromUserId(self):await()
		if counter then
			local local3 = Confirmation.new("Are you sure you want to kick " .. local2 .. "?")
			local3.Maid:GiveTask(local3.OnYes:Connect(function()
				persistentCrewStore:dispatch({
					type = "setNetworkMutexLocked",
					value = true
				})
				ReplicatedStorage:FindFirstChild(ClanConsts.REMOVE_PLAYER_FROM_CLAN_REMOTE_NAME):FireServer(self)
			end))
			if Players.LocalPlayer.PlayerGui then
				Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617491114, {
					Volume = 0.2
				})
			end
		end
	end
	local function attemptAdmin(self)
		persistentCrewStore:dispatch({
			type = "setNetworkMutexLocked",
			value = true
		})
		ReplicatedStorage:FindFirstChild(ClanConsts.ADD_PLAYER_AS_ADMIN_REMOTE_NAME):FireServer(self)
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617491114, {
				Volume = 0.2
			})
		end
	end
	local function attemptRenameCrew(self)
		local local2 = Confirmation.new("Are you sure you want to rename your crew? This will cost " .. "$" .. String.comma((tostring(ClanConsts.CLAN_RENAME_COST))))
		local2.Maid:GiveTask(local2.OnYes:Connect(function()
			persistentCrewStore:dispatch({
				type = "setNetworkMutexLocked",
				value = true
			})
			ReplicatedStorage:FindFirstChild(ClanConsts.RENAME_CLAN_REMOTE_NAME):FireServer(self)
		end))
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617491114, {
				Volume = 0.2
			})
		end
	end
	local function attemptUnAdmin(self)
		persistentCrewStore:dispatch({
			type = "setNetworkMutexLocked",
			value = true
		})
		ReplicatedStorage:FindFirstChild(ClanConsts.REMOVE_PLAYER_ADMIN_REMOTE_NAME):FireServer(self)
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617491114, {
				Volume = 0.2
			})
		end
	end
	local function onClickJoinRequestAccept(self)
		persistentCrewStore:dispatch({
			type = "setNetworkMutexLocked",
			value = true
		})
		ReplicatedStorage:FindFirstChild(ClanConsts.ACCEPT_JOIN_REQUEST_REMOTE_NAME):FireServer(self)
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617491114, {
				Volume = 0.2
			})
		end
	end
	local function onClickJoinRequestDeny(self)
		persistentCrewStore:dispatch({
			type = "setNetworkMutexLocked",
			value = true
		})
		ReplicatedStorage:FindFirstChild(ClanConsts.DENY_JOIN_REQUEST_REMOTE_NAME):FireServer(self)
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
	local function attemptReportCrew(self, self)
		assert(typeof(self) == "string", "invalid report option")
		ReplicatedStorage:FindFirstChild(PersistentCrewBattleConsts.REPORT_CLAN_REMOTE_NAME):FireServer(self, self)
	end
	local counter = 0
	local function onCountdownFinished()
		if counter < 1 and Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 12617487453, {
				Volume = 0.5
			})
		end
		counter = counter + 1
	end
	local local2 = Roact.mount(createElement("ScreenGui", {
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
		Roact.unmount(local2)
	end)
	RxInstanceUtils.observeAttribute(Players.LocalPlayer, ClanConsts.NETWORK_MUTEX_LOCKED_ATTR_NAME, function(self)
		persistentCrewStore:dispatch({
			type = "setNetworkMutexLocked",
			value = self
		})
	end)
	local local3 = nil
	persistentCrewStore.changed:connect(function(self, self)
		if self.networkMutexLocked ~= self.networkMutexLocked then
			if local3 then
				task.cancel(local3)
				local3 = nil
			end
			if self.networkMutexLocked then
				local3 = task.delay(0.75, function()
					if not Players.LocalPlayer:GetAttribute(ClanConsts.NETWORK_MUTEX_LOCKED_ATTR_NAME) then
						persistentCrewStore:dispatch({
							type = "setNetworkMutexLocked",
							value = false
						})
					end
				end)
			end
		end
		if self.groupVisible ~= self.groupVisible then
			ReplicatedStorage:FindFirstChild(PersistentCrewConsts.INFORM_UI_IS_OPEN_REMOTE_NAME):FireServer(self.groupVisible)
		end
	end)
	RxInstanceUtils.waitForChild(ReplicatedStorage, PersistentCrewConsts.UPDATE_PERSISTENT_CREW_REMOTE_NAME):andThen(function(self)
		self.OnClientEvent:Connect(function(self)
			if self then
				persistentCrewStore:dispatch({
					type = "setViewingClanInfo",
					value = self
				})
				if self.IsPlayersClan then
					persistentCrewStore:dispatch({
						type = "setCurrentClanInfo",
						value = self
					})
				end
				local AdminIdMap = self.AdminIdMap
				local counter = AdminIdMap[tostring(Players.LocalPlayer.UserId)] == true
				local local2 = self.MemberBattleInfoMap or {}
				local t = {}
				local table2 = {}
				for local3, local4 in self.Members do
					local local5 = local2[local3] or {}
					local local6 = local5.BattlesWon or 0
					local local7 = local5.BattlesPlayed or 0
					local local8 = tonumber(local3)
					table.insert(t, PlayerUtils.promiseNameFromUserId(local8):andThen(function(self)
						local t = {
							id = local8,
							userId = local8,
							displayName = self,
							isAdmin = AdminIdMap[local3],
							showKick = counter
						}
						local local2 = counter
						if local2 then
							local2 = not (AdminIdMap[local3] == true)
						end
						t.showAdmin = local2
						t.showUnAdmin = counter and AdminIdMap[local3] == true
						t.battlesPlayed = local7
						t.battlesWon = local6
						table.insert(table2, t)
					end))
				end
				Promise.all(t):andThen(function()
					persistentCrewStore:dispatch({
						type = "setMembers",
						value = table2
					})
				end)
				local table3 = {}
				if counter then
					local table4 = {}
					for local10 in self.JoinRequests do
						local local11 = tonumber(local10)
						table.insert(table4, PlayerUtils.promiseNameFromUserId(local11):andThen(function(self)
							table.insert(table3, {
								id = local11,
								userId = local11,
								displayName = self,
								showRequestAccept = counter,
								showRequestDeny = counter
							})
						end):catch(function(self)
							table.insert(table3, {
								id = local11,
								userId = local11,
								displayName = "[#" .. local11 .. "]",
								showRequestAccept = counter,
								showRequestDeny = counter
							})
						end))
					end
					Promise.allSettled(table4):andThen(function()
						persistentCrewStore:dispatch({
							type = "setJoinRequests",
							value = table3
						})
					end)
				else
					persistentCrewStore:dispatch({
						type = "setJoinRequests",
						value = table3
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
	local local4 = Maid.new()
	local function updateViewingInfo()
		local4:DoCleaning()
		persistentCrewStore:dispatch({
			type = "setMembersOnlineMap",
			value = nil
		})
		local counter = PersistentCrewUtils.getPlayerViewingClanId(Players.LocalPlayer)
		if not counter then
			persistentCrewStore:dispatch({
				type = "setViewingClanInfo",
				value = nil
			})
		end
		if counter then
			local4:GivePromise(waitForChild(ReplicatedStorage, ClanConsts.MEMBERS_ONLINE_OBJECT_NAME, 5):andThen(function(self)
				return waitForChild(self, counter, 5)
			end):andThen(function()
				local function updateOnline()
					persistentCrewStore:dispatch({
						type = "setMembersOnlineMap",
						value = ClanUtils.getMembersOnline(counter)
					})
				end
				persistentCrewStore:dispatch({
					type = "setMembersOnlineMap",
					value = ClanUtils.getMembersOnline(counter)
				})
				local4:GiveTask(ClanUtils.getMembersOnlineChangedSignal(counter):Connect(updateOnline))
			end))
		end
	end
	PersistentCrewUtils.getPlayerViewingClanIdChangedSignal(Players.LocalPlayer):Connect(updateViewingInfo)
	updateViewingInfo()
	local local5 = Maid.new()
	local function updateCurrentInfo()
		local counter = ClanUtils.getCurrentClanId(Players.LocalPlayer)
		if not counter then
			persistentCrewStore:dispatch({
				type = "setCurrentClanInfo",
				value = nil
			})
		end
		local local2
		if counter then
			local function dispatchReadyUpChanges()
				persistentCrewStore:dispatch({
					type = "setIsReadiedUp",
					value = ClanMatchmakingUtils.getIsClanReadiedUp(counter)
				})
			end
			local function callbackWrapper(self, self)
				persistentCrewStore:dispatch({
					type = "setIsReadiedUp",
					value = ClanMatchmakingUtils.getIsClanReadiedUp(counter)
				})
				self:GiveTask(dispatchReadyUpChanges)
			end
			local local3 = ClanMatchmakingUtils.observeIsClanReadiedUp(counter, callbackWrapper)
			persistentCrewStore:dispatch({
				type = "setIsReadiedUp",
				value = ClanMatchmakingUtils.getIsClanReadiedUp(counter)
			})
			local2 = local3
		else
			local2 = nil
		end
		local5.observingClan = local2
	end
	ClanUtils.getCurrentClanIdChangedSignal(Players.LocalPlayer):Connect(updateCurrentInfo)
	updateCurrentInfo()
end
return t
