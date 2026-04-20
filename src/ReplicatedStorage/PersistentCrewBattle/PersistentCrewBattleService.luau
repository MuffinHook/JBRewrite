local Players_upvr = game:GetService("Players")
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Audio_upvr = require(ReplicatedStorage_upvr.Std.Audio)
local waitForChild_upvr = require(ReplicatedStorage_upvr.Std.waitForChild)
local Roact_upvr = require(ReplicatedStorage_upvr.Roact)
local PersistentCrewBattleConsts_upvr = require(ReplicatedStorage_upvr.PersistentCrewBattle.PersistentCrewBattleConsts)
local persistentCrewStore_upvr = require(ReplicatedStorage_upvr.PersistentCrew.persistentCrewStore)
local function _() -- Line 20, Named "playHover"
    if Players_upvr.LocalPlayer.PlayerGui then
        Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 12617498616, {
            Volume = 0.5;
        })
    end
end
local function _() -- Line 26, Named "playLost"
    if Players_upvr.LocalPlayer.PlayerGui then
        Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 12617493597, {
            Volume = 0.7;
        })
    end
end
local function _() -- Line 31, Named "playWon"
    if Players_upvr.LocalPlayer.PlayerGui then
        Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 12617488605, {
            Volume = 1;
        })
    end
end
local function _() -- Line 36, Named "playDrums"
    if Players_upvr.LocalPlayer.PlayerGui then
        Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 12617487453, {
            Volume = 0.5;
        })
    end
end
local module_upvr = {}
local PrivateServerUtils_upvr = require(ReplicatedStorage_upvr.PrivateServer.PrivateServerUtils)
function module_upvr.init() -- Line 43
    local var15_upvw = false
    PrivateServerUtils_upvr.promiseGetIsBattleServer():timeout(10):andThen(function(arg1) -- Line 45
        if arg1 then
            var15_upvw = true
            module_upvr.initBattleServer()
        end
    end)
end
local LevelUISystem_upvr = require(ReplicatedStorage_upvr.Game.Level2.LevelUISystem)
local createElement_upvr = Roact_upvr.createElement
local RoactRodux_upvr = require(ReplicatedStorage_upvr.RoactRodux)
local GameModeCrewApp_upvr = require(ReplicatedStorage_upvr.PersistentCrew.UI.GameModeCrewApp)
local var20_upvw = 0
local RxInstanceUtils_upvr = require(ReplicatedStorage_upvr.Std.RxInstanceUtils)
local PersistentCrewBattleUtils_upvr = require(ReplicatedStorage_upvr.PersistentCrewBattle.PersistentCrewBattleUtils)
function module_upvr.initBattleServer() -- Line 54
    LevelUISystem_upvr.hideTopbar()
    local _ = {
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
        ResetOnSpawn = false;
        IgnoreGuiInset = true;
        DisplayOrder = 0;
    }
    ;({})[1] = Roact_upvr.createElement(RoactRodux_upvr.StoreProvider, {
        store = persistentCrewStore_upvr;
    }, {createElement_upvr(GameModeCrewApp_upvr, {
        onCountdownFinished = function() -- Line 70, Named "onCountdownFinished"
            if var20_upvw < 1 and Players_upvr.LocalPlayer.PlayerGui then
                Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 12617487453, {
                    Volume = 0.5;
                })
            end
            var20_upvw += 1
        end;
    })})
    persistentCrewStore_upvr:dispatch({
        type = "setIsBattleServer";
        value = true;
    })
    waitForChild_upvr(ReplicatedStorage_upvr, PersistentCrewBattleConsts_upvr.ALL_CREW_BATTLE_DATA_OBJ_NAME):andThen(function(arg1) -- Line 88
        RxInstanceUtils_upvr.observeChildren(arg1, function(arg1_2, arg2) -- Line 89
            local function handleChange() -- Line 90
                local any_getCrewStartTime_result1 = PersistentCrewBattleUtils_upvr.getCrewStartTime(arg1_2)
                local any_getCrewPenaltyDuration_result1 = PersistentCrewBattleUtils_upvr.getCrewPenaltyDuration(arg1_2)
                if any_getCrewStartTime_result1 and any_getCrewPenaltyDuration_result1 then
                    persistentCrewStore_upvr:dispatch({
                        type = "setStartedAt";
                        clanId = arg1_2.Name;
                        value = any_getCrewStartTime_result1 - any_getCrewPenaltyDuration_result1;
                    })
                end
                local any_getCrewTimeTook_result1 = PersistentCrewBattleUtils_upvr.getCrewTimeTook(arg1_2)
                if any_getCrewTimeTook_result1 then
                    persistentCrewStore_upvr:dispatch({
                        type = "setTimeTook";
                        clanId = arg1_2.Name;
                        value = any_getCrewTimeTook_result1;
                    })
                end
            end
            handleChange()
            arg2:GiveTask(arg1_2:GetAttributeChangedSignal(PersistentCrewBattleConsts_upvr.ROUND_START_ATTR_NAME):Connect(handleChange))
            arg2:GiveTask(arg1_2:GetAttributeChangedSignal(PersistentCrewBattleConsts_upvr.ROUND_PENALTY_DURATION_ATTR_NAME):Connect(handleChange))
            arg2:GiveTask(arg1_2:GetAttributeChangedSignal(PersistentCrewBattleConsts_upvr.ROUND_TIME_TOOK_ATTR_NAME):Connect(handleChange))
            persistentCrewStore_upvr:dispatch({
                type = "setClanName";
                clanId = arg1_2.Name;
                value = arg1_2:GetAttribute(PersistentCrewBattleConsts_upvr.CLAN_NAME_ATTR_NAME);
            })
            arg2:GiveTask(arg1_2:GetAttributeChangedSignal(PersistentCrewBattleConsts_upvr.CLAN_NAME_ATTR_NAME):Connect(function() -- Line 126, Named "handleClanName"
                persistentCrewStore_upvr:dispatch({
                    type = "setClanName";
                    clanId = arg1_2.Name;
                    value = arg1_2:GetAttribute(PersistentCrewBattleConsts_upvr.CLAN_NAME_ATTR_NAME);
                })
            end))
        end)
        persistentCrewStore_upvr:dispatch({
            type = "setAttackingClanId";
            value = PersistentCrewBattleUtils_upvr.getAttackingClanId();
        })
        PersistentCrewBattleUtils_upvr.getAttackingClanIdChangedSignal():Connect(function() -- Line 143, Named "updateAttackingClanId"
            persistentCrewStore_upvr:dispatch({
                type = "setAttackingClanId";
                value = PersistentCrewBattleUtils_upvr.getAttackingClanId();
            })
        end)
    end)
    waitForChild_upvr(ReplicatedStorage_upvr, PersistentCrewBattleConsts_upvr.ROBBERIES_COMPLETED_REMOTE_NAME):andThen(function(arg1) -- Line 157
        arg1.OnClientEvent:Connect(function(arg1_3) -- Line 158, Named "receiveRobberiesCompleted"
            local tbl_3 = {
                type = "setRobberiesCompleted";
            }
            tbl_3.value = arg1_3
            persistentCrewStore_upvr:dispatch(tbl_3)
        end)
    end)
    waitForChild_upvr(ReplicatedStorage_upvr, PersistentCrewBattleConsts_upvr.ANNOUNCE_PENALTY_REMOTE_NAME):andThen(function(arg1) -- Line 169
        arg1.OnClientEvent:Connect(function(arg1_4, arg2) -- Line 170
            persistentCrewStore_upvr:dispatch({
                type = "setPenaltyText";
                value = "%s +%ss":format(arg2, arg1_4);
            })
        end)
    end)
    waitForChild_upvr(ReplicatedStorage_upvr, PersistentCrewBattleConsts_upvr.ANNOUNCE_WIN_REMOTE_NAME):andThen(function(arg1) -- Line 180
        arg1.OnClientEvent:Connect(function(arg1_5) -- Line 181
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 12617488605, {
                Volume = 1;
            })
            do
                return
            end
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            if Players_upvr.LocalPlayer.PlayerGui then
                Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 12617493597, {
                    Volume = 0.7;
                })
            end
            -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        end)
    end)
    local var51_upvw
    persistentCrewStore_upvr.changed:connect(function(arg1, arg2) -- Line 192
        if arg1.penalty ~= arg2.penalty then
            if var51_upvw then
                task.cancel(var51_upvw)
                var51_upvw = nil
            end
            if arg1.penalty then
                var51_upvw = task.delay(5, function() -- Line 200
                    persistentCrewStore_upvr:dispatch({
                        type = "setPenaltyText";
                        value = nil;
                    })
                end)
            end
        end
    end)
end
local persistentCrewBattleStore_upvr = require(ReplicatedStorage_upvr.PersistentCrewBattle.persistentCrewBattleStore)
function module_upvr.initNonBattleServer() -- Line 210
    persistentCrewStore_upvr:dispatch({
        type = "setIsBattleServer";
        value = false;
    })
    waitForChild_upvr(Players_upvr.LocalPlayer, PersistentCrewBattleConsts_upvr.INVITES_FOLDER_NAME):andThen(function(arg1) -- Line 215
        local function updateInitiations() -- Line 216
            local tbl_5 = {}
            for _, v in arg1:GetChildren() do
                table.insert(tbl_5, {
                    clanName = v:GetAttribute(PersistentCrewBattleConsts_upvr.INVITE_OPPOSING_CLAN_NAME_ATTR_NAME);
                    battleNumPlayersPerTeam = v:GetAttribute(PersistentCrewBattleConsts_upvr.INVITE_NUM_PLAYERS_PER_TEAM_ATTR_NAME);
                    clanRating = v:GetAttribute(PersistentCrewBattleConsts_upvr.INVITE_CLAN_DISPLAY_RATING_ATTR_NAME);
                    ranked = v:GetAttribute(PersistentCrewBattleConsts_upvr.INVITE_RANKED_ATTR_NAME);
                    opposingClanOwnerName = v:GetAttribute(PersistentCrewBattleConsts_upvr.INVITE_OPPOSING_CLAN_OWNER_NAME_ATTR_NAME);
                    obj = v;
                })
                Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 9781039157, {
                    Volume = 0.2;
                })
            end
            persistentCrewStore_upvr:dispatch({
                type = "battleInvitesSet";
                list = tbl_5;
            })
        end
        updateInitiations()
        arg1.ChildAdded:Connect(updateInitiations)
        arg1.ChildRemoved:Connect(updateInitiations)
    end)
    waitForChild_upvr(ReplicatedStorage_upvr, PersistentCrewBattleConsts_upvr.LEADERBOARD_INFO_REMOTE_NAME):andThen(function(arg1) -- Line 246
        arg1.OnClientEvent:Connect(function(arg1_6) -- Line 247
            local tbl_4 = {
                type = "setCrewLeaderboard";
            }
            tbl_4.value = arg1_6
            persistentCrewBattleStore_upvr:dispatch(tbl_4)
        end)
    end)
    waitForChild_upvr(ReplicatedStorage_upvr, PersistentCrewBattleConsts_upvr.CREWS_IN_SERVER_DISPLAY_INFO_REMOTE_NAME):andThen(function(arg1) -- Line 256
        arg1.OnClientEvent:Connect(function(arg1_7) -- Line 257
            local tbl = {
                type = "setCrewsInServerDisplayInfo";
            }
            tbl.value = arg1_7
            persistentCrewBattleStore_upvr:dispatch(tbl)
        end)
    end)
    waitForChild_upvr(ReplicatedStorage_upvr, PersistentCrewBattleConsts_upvr.UPDATE_BATTLE_RESPONSES_REMOTE_NAME):andThen(function(arg1) -- Line 267
        local var76_upvw = 0
        arg1.OnClientEvent:Connect(function(arg1_8, arg2) -- Line 270
            -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
            local battleResponseData = persistentCrewStore_upvr:getState().battleResponseData
            if arg2 == nil and battleResponseData ~= nil and arg1_8 ~= battleResponseData.BattleUniqueId then
                do
                    return
                end
                local var78
            end
            if arg2 then
                if arg2.OurClanAccepted then
                    var78 = #arg2.OurClanAccepted
                else
                    var78 = 0
                end
                if arg2.TheirClanAccepted then
                else
                end
                local var79 = var78 + 0
                if var76_upvw < var79 and Players_upvr.LocalPlayer.PlayerGui then
                    Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 12617498616, {
                        Volume = 0.5;
                    })
                end
                var76_upvw = var79
            end
            local tbl_2 = {
                type = "setBattleResponseData";
            }
            tbl_2.value = arg2
            persistentCrewStore_upvr:dispatch(tbl_2)
        end)
    end)
end
return module_upvr