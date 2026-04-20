local Players_upvr = game:GetService("Players")
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Audio_upvr = require(ReplicatedStorage_upvr.Std.Audio)
local TradeConsts_upvr = require(ReplicatedStorage_upvr.Trade.TradeConsts)
local function _() -- Line 16, Named "playReadyDing"
    if Players_upvr.LocalPlayer.PlayerGui then
        Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 9856727426, {
            Volume = 0.2;
        })
    end
end
local module_upvr = {
    _tradingWithUserId = nil;
}
local var7_upvw
local RunUtils_upvr = require(ReplicatedStorage_upvr.App.RunUtils)
local store_upvr = require(ReplicatedStorage_upvr.App.store)
local waitForChild_upvr = require(ReplicatedStorage_upvr.Std.waitForChild)
local gameSettingType_upvr = require(ReplicatedStorage_upvr.GameSettings.gameSettingType)
local GameSettingsService_upvr = require(ReplicatedStorage_upvr.GameSettings.GameSettingsService)
local ChatService_upvr = require(ReplicatedStorage_upvr.Chat.ChatService)
local EnumSort_upvr = require(ReplicatedStorage_upvr.Garage.EnumSort)
local RxInstanceUtils_upvr = require(ReplicatedStorage_upvr.Std.RxInstanceUtils)
local TradePopularSortData_upvr = require(script.Parent.TradePopularSortData)
function module_upvr.init(arg1) -- Line 26
    var7_upvw = arg1.em
    if not RunUtils_upvr.isTradingEnabled() then
    else
        store_upvr.changed:connect(function(arg1_2, arg2) -- Line 33
            module_upvr._tradingWithUserId = arg1_2.traderThem.userId
            if arg1_2.traderThem.userId ~= arg2.traderThem.userId then
                store_upvr:dispatch({
                    type = "clearTradeChatMessages";
                })
            end
            for _, v in arg1_2.traderThem.offerItems do
                ({})[v.id] = true
                local var28
            end
            for _, v_2 in arg2.traderThem.offerItems do
                if not var28[v_2.id] then
                    store_upvr:dispatch({
                        type = "addTradeChatMessage";
                        displayName = "SERVER";
                        text = v_2.title.." removed from trade!";
                        me = false;
                        color = Color3.new(1, 0, 0);
                    })
                end
            end
        end)
        waitForChild_upvr(ReplicatedStorage_upvr, TradeConsts_upvr.ARE_TRADE_REQUESTS_ENABLED_REMOTE_NAME):andThen(function(arg1_3) -- Line 62
            local tbl_5 = {
                name = "areTradeRequestsEnabled";
                title = "Allow Trade Requests";
                type = gameSettingType_upvr.Checkbox;
                defaultValue = true;
                order = 41;
            }
            GameSettingsService_upvr.add(tbl_5)
            arg1_3:FireServer(tbl_5:getValue())
            tbl_5.onChanged:Connect(function(arg1_4) -- Line 71, Named "handleTradeRequestsEnabled"
                arg1_3:FireServer(arg1_4)
            end)
        end)
        ChatService_upvr.onMessageIncoming:Connect(function(arg1_5, arg2) -- Line 80
            -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
            local var33
            if arg1_5.Status ~= Enum.TextChatMessageStatus.Success then
            else
                if not arg1_5.TextSource then return end
                local UserId = arg1_5.TextSource.UserId
                var33 = UserId
                local any_GetPlayerByUserId_result1_2 = Players_upvr:GetPlayerByUserId(var33)
                if not any_GetPlayerByUserId_result1_2 then return end
                if arg1_5.TextChannel.Name ~= "RBXGeneral" then return end
                local any_getTradingWithUserId_result1 = module_upvr.getTradingWithUserId()
                if not any_getTradingWithUserId_result1 then return end
                if any_GetPlayerByUserId_result1_2 ~= Players_upvr.LocalPlayer then
                    var33 = false
                else
                    var33 = true
                end
                if UserId ~= any_getTradingWithUserId_result1 then
                else
                end
                if var33 or true then
                    store_upvr:dispatch({
                        type = "addTradeChatMessage";
                        displayName = any_GetPlayerByUserId_result1_2.DisplayName;
                        text = arg2.Text;
                        me = var33;
                    })
                end
            end
        end)
        waitForChild_upvr(ReplicatedStorage_upvr, TradeConsts_upvr.UPDATE_OWNED_REMOTE_NAME):andThen(function(arg1_6) -- Line 115
            arg1_6.OnClientEvent:Connect(function(arg1_7) -- Line 116
                local tbl_14 = {
                    type = "tradeInventorySetItemsOwned";
                }
                tbl_14.itemsOwned = arg1_7
                tbl_14.sortId = EnumSort_upvr.Newest
                store_upvr:dispatch(tbl_14)
            end)
        end)
        waitForChild_upvr(ReplicatedStorage_upvr, TradeConsts_upvr.UPDATE_OFFERING_REMOTE_NAME):andThen(function(arg1_8) -- Line 126
            arg1_8.OnClientEvent:Connect(function(arg1_9, arg2) -- Line 127
                if arg1_9 then
                    local tbl_16 = {
                        type = "updateTraderMe";
                    }
                    tbl_16.itemsOwnedOffering = arg2
                    store_upvr:dispatch(tbl_16)
                else
                    local tbl_21 = {
                        type = "updateTraderThem";
                    }
                    tbl_21.itemsOwnedOffering = arg2
                    store_upvr:dispatch(tbl_21)
                end
            end)
        end)
        waitForChild_upvr(Players_upvr.LocalPlayer, TradeConsts_upvr.ACTIVE_TRADE_OBJ_NAME):andThen(function(arg1_10) -- Line 142
            RxInstanceUtils_upvr.observeAttribute(arg1_10, TradeConsts_upvr.IS_READY_ATTR_NAME, function(arg1_11) -- Line 143
                local tbl_8 = {
                    type = "updateTraderMe";
                }
                tbl_8.ready = arg1_11
                store_upvr:dispatch(tbl_8)
                if arg1_11 and Players_upvr.LocalPlayer.PlayerGui then
                    Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 9856727426, {
                        Volume = 0.2;
                    })
                end
            end)
            RxInstanceUtils_upvr.observeAttribute(arg1_10, TradeConsts_upvr.IS_ACCEPTED_ATTR_NAME, function(arg1_12) -- Line 152
                local tbl_12 = {
                    type = "updateTraderMe";
                }
                tbl_12.accepted = arg1_12
                store_upvr:dispatch(tbl_12)
                if arg1_12 and Players_upvr.LocalPlayer.PlayerGui then
                    Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 9856727426, {
                        Volume = 0.2;
                    })
                end
            end)
            arg1_10.Changed:Connect(function(arg1_13) -- Line 161
                if arg1_13 then
                    store_upvr:dispatch({
                        type = "updateTraderMe";
                        userId = Players_upvr.LocalPlayer.UserId;
                        displayName = Players_upvr.LocalPlayer.DisplayName;
                    })
                else
                    store_upvr:dispatch({
                        type = "updateTraderMe";
                        reset = true;
                    })
                end
                local tbl_22 = {
                    type = "setTradeActive";
                }
                tbl_22.value = arg1_13
                store_upvr:dispatch(tbl_22)
            end)
            RxInstanceUtils_upvr.observeAttribute(arg1_10, TradeConsts_upvr.WITH_USER_ID_ATTR_NAME, function(arg1_14, arg2) -- Line 182
                if arg1_14 then
                    local any_GetPlayerByUserId_result1_3 = Players_upvr:GetPlayerByUserId(arg1_14)
                    if any_GetPlayerByUserId_result1_3 then
                        local SOME_2 = any_GetPlayerByUserId_result1_3:FindFirstChild(TradeConsts_upvr.ACTIVE_TRADE_OBJ_NAME)
                        if SOME_2 then
                            arg2:GiveTask(RxInstanceUtils_upvr.observeAttribute(SOME_2, TradeConsts_upvr.IS_READY_ATTR_NAME, function(arg1_17) -- Line 192
                                local tbl_20 = {
                                    type = "updateTraderThem";
                                }
                                tbl_20.ready = arg1_17
                                store_upvr:dispatch(tbl_20)
                                if arg1_17 and Players_upvr.LocalPlayer.PlayerGui then
                                    Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 9856727426, {
                                        Volume = 0.2;
                                    })
                                end
                            end))
                            arg2:GiveTask(RxInstanceUtils_upvr.observeAttribute(SOME_2, TradeConsts_upvr.IS_ACCEPTED_ATTR_NAME, function(arg1_18) -- Line 207
                                local tbl_18 = {
                                    type = "updateTraderThem";
                                }
                                tbl_18.accepted = arg1_18
                                store_upvr:dispatch(tbl_18)
                                if arg1_18 and Players_upvr.LocalPlayer.PlayerGui then
                                    Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 9856727426, {
                                        Volume = 0.2;
                                    })
                                end
                            end))
                        end
                        local tbl_10 = {
                            type = "updateTraderThem";
                        }
                        tbl_10.userId = arg1_14
                        tbl_10.displayName = any_GetPlayerByUserId_result1_3.DisplayName
                        store_upvr:dispatch(tbl_10)
                    end
                end
                arg2:GiveTask(function() -- Line 226
                    store_upvr:dispatch({
                        type = "updateTraderThem";
                        reset = true;
                    })
                end)
            end)
        end)
        waitForChild_upvr(Players_upvr.LocalPlayer, TradeConsts_upvr.INITIATIONS_FOLDER_NAME):andThen(function(arg1_19) -- Line 236
            local function updateInitiations() -- Line 237
                for _, v_3 in ipairs(arg1_19:GetChildren()) do
                    local tonumber_result1 = tonumber(v_3.Name)
                    if tonumber_result1 then
                        local any_GetPlayerByUserId_result1_4 = Players_upvr:GetPlayerByUserId(tonumber_result1)
                        if any_GetPlayerByUserId_result1_4 then
                            table.insert({}, {
                                userId = any_GetPlayerByUserId_result1_4.UserId;
                                name = any_GetPlayerByUserId_result1_4.DisplayName;
                                obj = v_3;
                                isTradingVIP = any_GetPlayerByUserId_result1_4:GetAttribute(TradeConsts_upvr.TRADING_VIP_ATTRIBUTE_NAME);
                            })
                            if Players_upvr.LocalPlayer.PlayerGui then
                                Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 9781039157, {
                                    Volume = 0.2;
                                })
                            end
                        end
                    end
                end
                local tbl_6 = {
                    type = "tradeInitiationsSet";
                }
                -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                tbl_6.list = {}
                store_upvr:dispatch(tbl_6)
            end
            updateInitiations()
            arg1_19.ChildAdded:Connect(updateInitiations)
            arg1_19.ChildRemoved:Connect(updateInitiations)
        end)
        waitForChild_upvr(ReplicatedStorage_upvr, TradeConsts_upvr.OFFERING_RESULT_REMOTE_NAME):andThen(function(arg1_20) -- Line 267
            arg1_20.OnClientEvent:Connect(function(arg1_21) -- Line 268
                -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
                -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
                -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
                -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
            end)
        end)
        waitForChild_upvr(ReplicatedStorage_upvr, TradeConsts_upvr.UPDATE_OFFERING_INFO_REMOTE_NAME):andThen(function(arg1_22) -- Line 319
            arg1_22.OnClientEvent:Connect(function(arg1_23) -- Line 320
                local tbl_11 = {
                    type = "setTradeInfo";
                }
                tbl_11.info = arg1_23
                store_upvr:dispatch(tbl_11)
            end)
        end)
        waitForChild_upvr(ReplicatedStorage_upvr, TradeConsts_upvr.POPULAR_TRADE_ITEM_DATA_REMOTE_NAME):andThen(function(arg1_24) -- Line 329
            arg1_24.OnClientEvent:Connect(function(arg1_25) -- Line 330
                TradePopularSortData_upvr.setPopularTradeItemData(arg1_25)
            end)
        end)
        waitForChild_upvr(ReplicatedStorage_upvr, TradeConsts_upvr.OTHER_TRADE_SERVER_DATA_REMOTE_NAME):andThen(function(arg1_26) -- Line 337
            arg1_26.OnClientEvent:Connect(function(arg1_27) -- Line 338
                local tbl_15 = {
                    type = "setOtherTradeServerInfo";
                }
                tbl_15.value = arg1_27
                store_upvr:dispatch(tbl_15)
            end)
        end)
        local function updatePlayers() -- Line 348
            store_upvr:dispatch({
                type = "setInventoryPlayers";
                allPlayers = Players_upvr:GetPlayers();
            })
        end
        store_upvr:dispatch({
            type = "setInventoryPlayers";
            allPlayers = Players_upvr:GetPlayers();
        })
        Players_upvr.PlayerAdded:Connect(updatePlayers)
        Players_upvr.ChildRemoved:Connect(updatePlayers)
    end
end
function module_upvr.checkAlreadyInitiated(arg1, arg2) -- Line 359
    if arg2:FindFirstChild(TradeConsts_upvr.INITIATIONS_FOLDER_NAME):FindFirstChild(tostring(arg1.UserId)) then
        return true
    end
    return false
end
function module_upvr.acceptInitiation(arg1) -- Line 367
    ReplicatedStorage_upvr:FindFirstChild(TradeConsts_upvr.ACCEPT_TRADE_INITIATION_REMOTE_NAME):FireServer(arg1)
end
function module_upvr.sendInitiation(arg1) -- Line 371
    ReplicatedStorage_upvr:WaitForChild(TradeConsts_upvr.SEND_TRADE_INITIATION_REMOTE_NAME):FireServer(arg1)
end
function module_upvr.getTradingWithUserId() -- Line 375
    return module_upvr._tradingWithUserId
end
return module_upvr