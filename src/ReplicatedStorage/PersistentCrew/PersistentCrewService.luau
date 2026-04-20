local Players_upvr = game:GetService("Players")
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Maid_upvr = require(ReplicatedStorage_upvr.Std.Maid)
local Audio_upvr = require(ReplicatedStorage_upvr.Std.Audio)
local Roact_upvr = require(ReplicatedStorage_upvr.Roact)
local function _() -- Line 26, Named "playDrums"
    if Players_upvr.LocalPlayer.PlayerGui then
        Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 12617487453, {
            Volume = 0.5;
        })
    end
end
local function _() -- Line 31, Named "playClick"
    if Players_upvr.LocalPlayer.PlayerGui then
        Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 12617491114, {
            Volume = 0.2;
        })
    end
end
local module_upvr = {
    maid = Maid_upvr.new();
}
local persistentCrewStore_upvr = require(ReplicatedStorage_upvr.PersistentCrew.persistentCrewStore)
local ClanConsts_upvr = require(ReplicatedStorage_upvr.Clan.ClanConsts)
local Confirmation_upvr = require(ReplicatedStorage_upvr.Module.Confirmation)
local PersistentCrewBattleConsts_upvr = require(ReplicatedStorage_upvr.PersistentCrewBattle.PersistentCrewBattleConsts)
local PersistentCrewConsts_upvr = require(ReplicatedStorage_upvr.PersistentCrew.PersistentCrewConsts)
local PlayerUtils_upvr = require(ReplicatedStorage_upvr.Std.PlayerUtils)
local String_upvr = require(ReplicatedStorage_upvr.Std.String)
local ClanMatchmakingConsts_upvr = require(ReplicatedStorage_upvr.ClanMatchmaking.ClanMatchmakingConsts)
local createElement_upvr = Roact_upvr.createElement
local RoactRodux_upvr = require(ReplicatedStorage_upvr.RoactRodux)
local PersistentCrewApp_upvr = require(ReplicatedStorage_upvr.PersistentCrew.UI.PersistentCrewApp)
local RxInstanceUtils_upvr = require(ReplicatedStorage_upvr.Std.RxInstanceUtils)
local Promise_upvr = require(ReplicatedStorage_upvr.Std.Promise)
local PersistentCrewUtils_upvr = require(ReplicatedStorage_upvr.PersistentCrew.PersistentCrewUtils)
local waitForChild_upvr = require(ReplicatedStorage_upvr.Std.waitForChild)
local ClanUtils_upvr = require(ReplicatedStorage_upvr.Clan.ClanUtils)
local ClanMatchmakingUtils_upvr = require(ReplicatedStorage_upvr.ClanMatchmaking.ClanMatchmakingUtils)
function module_upvr.init() -- Line 39
    local var65_upvw = 0
    local any_mount_result1_upvr = Roact_upvr.mount(createElement_upvr("ScreenGui", {
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
        ResetOnSpawn = false;
        IgnoreGuiInset = true;
        DisplayOrder = 0;
    }, {Roact_upvr.createElement(RoactRodux_upvr.StoreProvider, {
        store = persistentCrewStore_upvr;
    }, {createElement_upvr(PersistentCrewApp_upvr, {
        attemptLeave = function() -- Line 46, Named "attemptLeave"
            local any_new_result1_2 = Confirmation_upvr.new("Are you sure you want to leave? If you joined for less than ".."%d days":format(ClanConsts_upvr.CLAN_JOIN_COOLDOWN_DURATION / 86400)..", you'll have to wait to join another crew.")
            any_new_result1_2.Maid:GiveTask(any_new_result1_2.OnYes:Connect(function() -- Line 54
                persistentCrewStore_upvr:dispatch({
                    type = "setNetworkMutexLocked";
                    value = true;
                })
                ReplicatedStorage_upvr:FindFirstChild(ClanConsts_upvr.LEAVE_CLAN_REMOTE_NAME):FireServer()
            end))
            if Players_upvr.LocalPlayer.PlayerGui then
                Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 12617491114, {
                    Volume = 0.2;
                })
            end
        end;
        attemptCreate = function(arg1, arg2) -- Line 60, Named "attemptCreate"
            persistentCrewStore_upvr:dispatch({
                type = "setNetworkMutexLocked";
                value = true;
            })
            ReplicatedStorage_upvr:FindFirstChild(ClanConsts_upvr.CREATE_CLAN_REMOTE_NAME):FireServer(arg1, arg2)
            if Players_upvr.LocalPlayer.PlayerGui then
                Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 12617491114, {
                    Volume = 0.2;
                })
            end
        end;
        attemptRequestJoinUserId = function(arg1) -- Line 65, Named "attemptRequestJoinUserId"
            persistentCrewStore_upvr:dispatch({
                type = "setNetworkMutexLocked";
                value = true;
            })
            ReplicatedStorage_upvr:FindFirstChild(ClanConsts_upvr.REQUEST_JOIN_CLAN_REMOTE_NAME):FireServer(arg1)
            if Players_upvr.LocalPlayer.PlayerGui then
                Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 12617491114, {
                    Volume = 0.2;
                })
            end
        end;
        attemptBattleClanId = function(arg1, arg2) -- Line 70, Named "attemptBattleClanId"
            persistentCrewStore_upvr:dispatch({
                type = "setNetworkMutexLocked";
                value = true;
            })
            ReplicatedStorage_upvr:FindFirstChild(PersistentCrewBattleConsts_upvr.CUSTOM_BATTLE_INVITE_REMOTE_NAME):FireServer(arg1, arg2)
            if Players_upvr.LocalPlayer.PlayerGui then
                Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 12617491114, {
                    Volume = 0.2;
                })
            end
        end;
        attemptViewUserIdClan = function(arg1) -- Line 76, Named "attemptViewUserIdClan"
            persistentCrewStore_upvr:dispatch({
                type = "setNetworkMutexLocked";
                value = true;
            })
            ReplicatedStorage_upvr:FindFirstChild(PersistentCrewConsts_upvr.VIEW_CLAN_REMOTE_NAME):FireServer(arg1)
            if Players_upvr.LocalPlayer.PlayerGui then
                Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 12617491114, {
                    Volume = 0.2;
                })
            end
        end;
        onAcceptBattleInvite = function(arg1) -- Line 81, Named "onAcceptBattleInvite"
            ReplicatedStorage_upvr:FindFirstChild(PersistentCrewBattleConsts_upvr.RESPONSE_REMOTE_NAME):FireServer(arg1.obj.Name, true)
            if Players_upvr.LocalPlayer.PlayerGui then
                Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 12617491114, {
                    Volume = 0.2;
                })
            end
        end;
        onDeclineBattleInvite = function(arg1) -- Line 86, Named "onDeclineBattleInvite"
            ReplicatedStorage_upvr:FindFirstChild(PersistentCrewBattleConsts_upvr.RESPONSE_REMOTE_NAME):FireServer(arg1.obj.Name, false)
            if Players_upvr.LocalPlayer.PlayerGui then
                Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 12617491114, {
                    Volume = 0.2;
                })
            end
        end;
        onCountdownFinished = function() -- Line 157, Named "onCountdownFinished"
            if var65_upvw < 1 and Players_upvr.LocalPlayer.PlayerGui then
                Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 12617487453, {
                    Volume = 0.5;
                })
            end
            var65_upvw += 1
        end;
        attemptKick = function(arg1) -- Line 97, Named "attemptKick"
            local any_await_result1, any_await_result2 = PlayerUtils_upvr.promiseNameFromUserId(arg1):await()
            if not any_await_result1 then
            else
                local any_new_result1_3 = Confirmation_upvr.new("Are you sure you want to kick "..any_await_result2..'?')
                any_new_result1_3.Maid:GiveTask(any_new_result1_3.OnYes:Connect(function() -- Line 103
                    persistentCrewStore_upvr:dispatch({
                        type = "setNetworkMutexLocked";
                        value = true;
                    })
                    ReplicatedStorage_upvr:FindFirstChild(ClanConsts_upvr.REMOVE_PLAYER_FROM_CLAN_REMOTE_NAME):FireServer(arg1)
                end))
                if Players_upvr.LocalPlayer.PlayerGui then
                    Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 12617491114, {
                        Volume = 0.2;
                    })
                end
            end
        end;
        attemptAdmin = function(arg1) -- Line 109, Named "attemptAdmin"
            persistentCrewStore_upvr:dispatch({
                type = "setNetworkMutexLocked";
                value = true;
            })
            ReplicatedStorage_upvr:FindFirstChild(ClanConsts_upvr.ADD_PLAYER_AS_ADMIN_REMOTE_NAME):FireServer(arg1)
            if Players_upvr.LocalPlayer.PlayerGui then
                Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 12617491114, {
                    Volume = 0.2;
                })
            end
        end;
        attemptUnAdmin = function(arg1) -- Line 126, Named "attemptUnAdmin"
            persistentCrewStore_upvr:dispatch({
                type = "setNetworkMutexLocked";
                value = true;
            })
            ReplicatedStorage_upvr:FindFirstChild(ClanConsts_upvr.REMOVE_PLAYER_ADMIN_REMOTE_NAME):FireServer(arg1)
            if Players_upvr.LocalPlayer.PlayerGui then
                Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 12617491114, {
                    Volume = 0.2;
                })
            end
        end;
        attemptRenameCrew = function(arg1) -- Line 114, Named "attemptRenameCrew"
            local any_new_result1 = Confirmation_upvr.new("Are you sure you want to rename your crew? This will cost "..'$'..String_upvr.comma(tostring(ClanConsts_upvr.CLAN_RENAME_COST)))
            any_new_result1.Maid:GiveTask(any_new_result1.OnYes:Connect(function() -- Line 120
                persistentCrewStore_upvr:dispatch({
                    type = "setNetworkMutexLocked";
                    value = true;
                })
                ReplicatedStorage_upvr:FindFirstChild(ClanConsts_upvr.RENAME_CLAN_REMOTE_NAME):FireServer(arg1)
            end))
            if Players_upvr.LocalPlayer.PlayerGui then
                Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 12617491114, {
                    Volume = 0.2;
                })
            end
        end;
        onClickJoinRequestAccept = function(arg1) -- Line 131, Named "onClickJoinRequestAccept"
            persistentCrewStore_upvr:dispatch({
                type = "setNetworkMutexLocked";
                value = true;
            })
            ReplicatedStorage_upvr:FindFirstChild(ClanConsts_upvr.ACCEPT_JOIN_REQUEST_REMOTE_NAME):FireServer(arg1)
            if Players_upvr.LocalPlayer.PlayerGui then
                Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 12617491114, {
                    Volume = 0.2;
                })
            end
        end;
        onClickJoinRequestDeny = function(arg1) -- Line 136, Named "onClickJoinRequestDeny"
            persistentCrewStore_upvr:dispatch({
                type = "setNetworkMutexLocked";
                value = true;
            })
            ReplicatedStorage_upvr:FindFirstChild(ClanConsts_upvr.DENY_JOIN_REQUEST_REMOTE_NAME):FireServer(arg1)
            if Players_upvr.LocalPlayer.PlayerGui then
                Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 12617491114, {
                    Volume = 0.2;
                })
            end
        end;
        onClickReadyUp = function() -- Line 141, Named "onClickReadyUp"
            persistentCrewStore_upvr:dispatch({
                type = "setNetworkMutexLocked";
                value = true;
            })
            ReplicatedStorage_upvr:FindFirstChild(ClanMatchmakingConsts_upvr.READY_UP_REMOTE_NAME):FireServer()
            if Players_upvr.LocalPlayer.PlayerGui then
                Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 12617491114, {
                    Volume = 0.2;
                })
            end
        end;
        onClickUnreadyUp = function() -- Line 146, Named "onClickUnreadyUp"
            persistentCrewStore_upvr:dispatch({
                type = "setNetworkMutexLocked";
                value = true;
            })
            ReplicatedStorage_upvr:FindFirstChild(ClanMatchmakingConsts_upvr.UNREADY_UP_REMOTE_NAME):FireServer()
            if Players_upvr.LocalPlayer.PlayerGui then
                Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 12617491114, {
                    Volume = 0.2;
                })
            end
        end;
        onUnAcceptBattleInvite = function() -- Line 92, Named "onUnAcceptBattleInvite"
            ReplicatedStorage_upvr:FindFirstChild(PersistentCrewBattleConsts_upvr.UNACCEPT_BATTLE_INVITE_REMOTE_NAME):FireServer()
            if Players_upvr.LocalPlayer.PlayerGui then
                Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 12617491114, {
                    Volume = 0.2;
                })
            end
        end;
        optimisticallyLockNetworkMutex = function() -- Line 40, Named "optimisticallyLockNetworkMutex"
            persistentCrewStore_upvr:dispatch({
                type = "setNetworkMutexLocked";
                value = true;
            })
        end;
        attemptReportCrew = function(arg1, arg2) -- Line 151, Named "attemptReportCrew"
            local var64
            if typeof(arg1) ~= "string" then
                var64 = false
            else
                var64 = true
            end
            assert(var64, "invalid report option")
            ReplicatedStorage_upvr:FindFirstChild(PersistentCrewBattleConsts_upvr.REPORT_CLAN_REMOTE_NAME):FireServer(arg1, arg2)
        end;
    })})}), Players_upvr.LocalPlayer.PlayerGui, "PersistentCrewUI")
    module_upvr.maid:GiveTask(function() -- Line 203
        Roact_upvr.unmount(any_mount_result1_upvr)
    end)
    RxInstanceUtils_upvr.observeAttribute(Players_upvr.LocalPlayer, ClanConsts_upvr.NETWORK_MUTEX_LOCKED_ATTR_NAME, function(arg1) -- Line 210
        local tbl_7 = {
            type = "setNetworkMutexLocked";
        }
        tbl_7.value = arg1
        persistentCrewStore_upvr:dispatch(tbl_7)
    end)
    local var77_upvw
    persistentCrewStore_upvr.changed:connect(function(arg1, arg2) -- Line 218
        if arg1.networkMutexLocked ~= arg2.networkMutexLocked then
            if var77_upvw then
                task.cancel(var77_upvw)
                var77_upvw = nil
            end
            if arg1.networkMutexLocked then
                var77_upvw = task.delay(0.75, function() -- Line 228
                    if not Players_upvr.LocalPlayer:GetAttribute(ClanConsts_upvr.NETWORK_MUTEX_LOCKED_ATTR_NAME) then
                        persistentCrewStore_upvr:dispatch({
                            type = "setNetworkMutexLocked";
                            value = false;
                        })
                    end
                end)
            end
        end
        if arg1.groupVisible ~= arg2.groupVisible then
            ReplicatedStorage_upvr:FindFirstChild(PersistentCrewConsts_upvr.INFORM_UI_IS_OPEN_REMOTE_NAME):FireServer(arg1.groupVisible)
        end
    end)
    RxInstanceUtils_upvr.waitForChild(ReplicatedStorage_upvr, PersistentCrewConsts_upvr.UPDATE_PERSISTENT_CREW_REMOTE_NAME):andThen(function(arg1) -- Line 249
        arg1.OnClientEvent:Connect(function(arg1_2) -- Line 250
            if not arg1_2 then
            else
                local tbl_6 = {
                    type = "setViewingClanInfo";
                }
                tbl_6.value = arg1_2
                persistentCrewStore_upvr:dispatch(tbl_6)
                if arg1_2.IsPlayersClan then
                    local tbl_3 = {
                        type = "setCurrentClanInfo";
                    }
                    tbl_3.value = arg1_2
                    persistentCrewStore_upvr:dispatch(tbl_3)
                end
                local AdminIdMap_upvr = arg1_2.AdminIdMap
                if AdminIdMap_upvr[tostring(Players_upvr.LocalPlayer.UserId)] ~= true then
                    local _ = false
                    -- KONSTANTWARNING: Skipped task `defvar` above
                else
                end
                if not arg1_2.MemberBattleInfoMap then
                end
                local tbl_2_upvr = {}
                local tbl_5 = {}
                for i_upvr, _ in arg1_2.Members do
                    local var94 = ({})[i_upvr]
                    if not var94 then
                        var94 = {}
                    end
                    local tonumber_result1_upvr = tonumber(i_upvr)
                    local var97_upvr = true
                    local var98_upvr = var94.BattlesPlayed or 0
                    local var99_upvr = var94.BattlesWon or 0
                    table.insert(tbl_5, PlayerUtils_upvr.promiseNameFromUserId(tonumber_result1_upvr):andThen(function(arg1_3) -- Line 282
                        -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
                        local tbl = {
                            id = tonumber_result1_upvr;
                            userId = tonumber_result1_upvr;
                        }
                        tbl.displayName = arg1_3
                        local var101 = AdminIdMap_upvr
                        tbl.isAdmin = var101[i_upvr]
                        tbl.showKick = var97_upvr
                        if var97_upvr then
                            if AdminIdMap_upvr[i_upvr] ~= true then
                                var101 = false
                            else
                                var101 = true
                            end
                        end
                        tbl.showAdmin = not var101
                        if var97_upvr then
                            var101 = AdminIdMap_upvr[i_upvr]
                            if var101 ~= true then
                            else
                            end
                        end
                        tbl.showUnAdmin = true
                        tbl.battlesPlayed = var98_upvr
                        tbl.battlesWon = var99_upvr
                        table.insert(tbl_2_upvr, tbl)
                    end))
                end
                Promise_upvr.all(tbl_5):andThen(function() -- Line 297
                    persistentCrewStore_upvr:dispatch({
                        type = "setMembers";
                        value = tbl_2_upvr;
                    })
                end)
                tbl_2_upvr = {}
                local var104_upvr = tbl_2_upvr
                if var97_upvr then
                    for i_2 in arg1_2.JoinRequests do
                        var99_upvr = i_2
                        local tonumber_result1_upvr_2 = tonumber(var99_upvr)
                        var98_upvr = {}
                        tonumber_result1_upvr = PlayerUtils_upvr
                        tonumber_result1_upvr = tonumber_result1_upvr.promiseNameFromUserId(tonumber_result1_upvr_2)
                        tonumber_result1_upvr = tonumber_result1_upvr:andThen(function(arg1_4) -- Line 313
                            local tbl_4 = {
                                id = tonumber_result1_upvr_2;
                                userId = tonumber_result1_upvr_2;
                            }
                            tbl_4.displayName = arg1_4
                            tbl_4.showRequestAccept = var97_upvr
                            tbl_4.showRequestDeny = var97_upvr
                            table.insert(var104_upvr, tbl_4)
                        end)
                        tonumber_result1_upvr = tonumber_result1_upvr:catch(function(arg1_5) -- Line 322
                            table.insert(var104_upvr, {
                                id = tonumber_result1_upvr_2;
                                userId = tonumber_result1_upvr_2;
                                displayName = "[#"..tonumber_result1_upvr_2..']';
                                showRequestAccept = var97_upvr;
                                showRequestDeny = var97_upvr;
                            })
                        end)
                        var99_upvr = table.insert
                        var99_upvr(var98_upvr, tonumber_result1_upvr)
                        local var111
                    end
                    Promise_upvr.allSettled(var111):andThen(function() -- Line 334
                        persistentCrewStore_upvr:dispatch({
                            type = "setJoinRequests";
                            value = var104_upvr;
                        })
                    end)
                    return
                end
                persistentCrewStore_upvr:dispatch({
                    type = "setJoinRequests";
                    value = var104_upvr;
                })
            end
        end)
    end)
    local function _() -- Line 349, Named "invalidateOnline"
        persistentCrewStore_upvr:dispatch({
            type = "setMembersOnlineMap";
            value = nil;
        })
    end
    local any_new_result1_upvr_2 = Maid_upvr.new()
    local function updateViewingInfo() -- Line 356
        any_new_result1_upvr_2:DoCleaning()
        persistentCrewStore_upvr:dispatch({
            type = "setMembersOnlineMap";
            value = nil;
        })
        local any_getPlayerViewingClanId_result1_upvr = PersistentCrewUtils_upvr.getPlayerViewingClanId(Players_upvr.LocalPlayer)
        if not any_getPlayerViewingClanId_result1_upvr then
            persistentCrewStore_upvr:dispatch({
                type = "setViewingClanInfo";
                value = nil;
            })
        end
        if any_getPlayerViewingClanId_result1_upvr then
            any_new_result1_upvr_2:GivePromise(waitForChild_upvr(ReplicatedStorage_upvr, ClanConsts_upvr.MEMBERS_ONLINE_OBJECT_NAME, 5):andThen(function(arg1) -- Line 371
                return waitForChild_upvr(arg1, any_getPlayerViewingClanId_result1_upvr, 5)
            end):andThen(function() -- Line 374
                persistentCrewStore_upvr:dispatch({
                    type = "setMembersOnlineMap";
                    value = ClanUtils_upvr.getMembersOnline(any_getPlayerViewingClanId_result1_upvr);
                })
                any_new_result1_upvr_2:GiveTask(ClanUtils_upvr.getMembersOnlineChangedSignal(any_getPlayerViewingClanId_result1_upvr):Connect(function() -- Line 377, Named "updateOnline"
                    persistentCrewStore_upvr:dispatch({
                        type = "setMembersOnlineMap";
                        value = ClanUtils_upvr.getMembersOnline(any_getPlayerViewingClanId_result1_upvr);
                    })
                end))
            end))
        end
    end
    PersistentCrewUtils_upvr.getPlayerViewingClanIdChangedSignal(Players_upvr.LocalPlayer):Connect(updateViewingInfo)
    updateViewingInfo()
    local any_new_result1_upvr = Maid_upvr.new()
    local function updateCurrentInfo() -- Line 394
        local any_getCurrentClanId_result1_upvr = ClanUtils_upvr.getCurrentClanId(Players_upvr.LocalPlayer)
        if not any_getCurrentClanId_result1_upvr then
            persistentCrewStore_upvr:dispatch({
                type = "setCurrentClanInfo";
                value = nil;
            })
        end
        local var127
        if any_getCurrentClanId_result1_upvr then
            local function dispatchReadyUpChanges_upvr() -- Line 404, Named "dispatchReadyUpChanges"
                persistentCrewStore_upvr:dispatch({
                    type = "setIsReadiedUp";
                    value = ClanMatchmakingUtils_upvr.getIsClanReadiedUp(any_getCurrentClanId_result1_upvr);
                })
            end
            var127 = ClanMatchmakingUtils_upvr.observeIsClanReadiedUp(any_getCurrentClanId_result1_upvr, function(arg1, arg2) -- Line 411, Named "callbackWrapper"
                persistentCrewStore_upvr:dispatch({
                    type = "setIsReadiedUp";
                    value = ClanMatchmakingUtils_upvr.getIsClanReadiedUp(any_getCurrentClanId_result1_upvr);
                })
                arg2:GiveTask(dispatchReadyUpChanges_upvr)
            end)
            persistentCrewStore_upvr:dispatch({
                type = "setIsReadiedUp";
                value = ClanMatchmakingUtils_upvr.getIsClanReadiedUp(any_getCurrentClanId_result1_upvr);
            })
        end
        dispatchReadyUpChanges_upvr = any_new_result1_upvr
        dispatchReadyUpChanges_upvr.observingClan = var127
    end
    ClanUtils_upvr.getCurrentClanIdChangedSignal(Players_upvr.LocalPlayer):Connect(updateCurrentInfo)
    updateCurrentInfo()
end
return module_upvr