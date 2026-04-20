local Players_upvr = game:GetService("Players")
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local Audio_upvr = require(ReplicatedStorage_upvr.Std.Audio)
local TableUtils_upvr = require(ReplicatedStorage_upvr.Std.TableUtils)
local Roact = require(ReplicatedStorage_upvr.Roact)
local TradeConsts_upvr = require(ReplicatedStorage_upvr.Trade.TradeConsts)
local store_upvr = require(ReplicatedStorage_upvr.App.store)
local function _() -- Line 19, Named "playTick"
    if Players_upvr.LocalPlayer.PlayerGui then
        Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 6105461542, {
            Volume = 0.15;
        })
    end
end
local any_extend_result1 = Roact.PureComponent:extend("Trade")
any_extend_result1.defaultProps = {
    size = UDim2.new(1, 0, 1, 0);
    position = UDim2.new(0.5, 0, 0.5, 0);
    anchorPoint = Vector2.new(0.5, 0.5);
}
local function resetInventoryUserEditedValues_upvr() -- Line 31, Named "resetInventoryUserEditedValues"
    store_upvr:dispatch({
        type = "setTradeInventorySearchText";
        value = "";
    })
    store_upvr:dispatch({
        type = "setInventoryPlayer";
        selectedPlayer = Players_upvr.LocalPlayer;
    })
end
local Maid_upvr = require(ReplicatedStorage_upvr.Std.Maid)
local TradeUtils_upvr = require(ReplicatedStorage_upvr.Trade.TradeUtils)
function any_extend_result1.init(arg1) -- Line 41
    arg1.activeMaid = Maid_upvr.new()
    arg1.categories = TradeUtils_upvr.getCategories()
    arg1:setState({
        inventoryItems = arg1:_getFilteredInventoryItems();
        category = arg1.categories[1];
    })
    function arg1.onClickExitInventory() -- Line 49
        resetInventoryUserEditedValues_upvr()
        arg1.props.setInventoryOpen(false)
    end
    function arg1.promptInventory() -- Line 53
        if Players_upvr.LocalPlayer.PlayerGui then
            Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 6105461542, {
                Volume = 0.15;
            })
        end
        arg1.props.setInventoryOpen(true)
    end
    function arg1.onClickInventoryItem(arg1_2) -- Line 57
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        if not arg1.props.tradeActive then return end
        if arg1.props.inventoryPlayers.selectedPlayer ~= Players_upvr.LocalPlayer then return end
        local ipairs_result1_2, ipairs_result2, ipairs_result3_2 = ipairs(arg1.props.traderMe.offerItems)
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [46.8]
        -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [46.2147483650]
        -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [46.9]
        if nil == nil then
            if not false then
                arg1.props.addTraderMeOfferItem(arg1.state.inventoryItems[arg1_2])
                -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
            end
            -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    end
    function arg1.removeTraderMeOfferItemByIndex(arg1_3) -- Line 81
        arg1.props.removeTraderMeOfferItemByIndex(arg1_3)
        arg1:_updateMyOffer(false)
    end
    function arg1.onClickCategory(arg1_4) -- Line 85
        if Players_upvr.LocalPlayer.PlayerGui then
            Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 6105461542, {
                Volume = 0.25;
            })
        end
        local tbl_5 = {}
        tbl_5.category = arg1_4
        arg1:setState(tbl_5)
        if Players_upvr.LocalPlayer.PlayerGui then
            Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 6105461542, {
                Volume = 0.15;
            })
        end
    end
    function arg1.onClickReady() -- Line 95
        arg1.props.onClickReady()
        arg1:_updateMyOffer(true)
        if Players_upvr.LocalPlayer.PlayerGui then
            Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 6105461542, {
                Volume = 0.15;
            })
        end
    end
    function arg1.onClickUnready() -- Line 100
        arg1.props.onClickUnready()
        arg1:_updateMyOffer(false)
        if Players_upvr.LocalPlayer.PlayerGui then
            Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 6105461542, {
                Volume = 0.15;
            })
        end
    end
    function arg1.onClickAccept() -- Line 105
        ReplicatedStorage_upvr:FindFirstChild(TradeConsts_upvr.ACCEPT_OFFERING_REMOTE_NAME):FireServer()
        if Players_upvr.LocalPlayer.PlayerGui then
            Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 6105461542, {
                Volume = 0.15;
            })
        end
    end
    function arg1.onClickDecline() -- Line 111
        ReplicatedStorage_upvr:FindFirstChild(TradeConsts_upvr.DECLINE_OFFERING_REMOTE_NAME):FireServer()
        if Players_upvr.LocalPlayer.PlayerGui then
            Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 6105461542, {
                Volume = 0.15;
            })
        end
    end
    function arg1.onClickExit() -- Line 117
        ReplicatedStorage_upvr:FindFirstChild(TradeConsts_upvr.EXIT_OFFERING_REMOTE_NAME):FireServer()
        if Players_upvr.LocalPlayer.PlayerGui then
            Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 6105461542, {
                Volume = 0.15;
            })
        end
    end
    function arg1.onCardFlipped() -- Line 123
        if Players_upvr.LocalPlayer.PlayerGui then
            Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 9846199217, {
                Volume = 0.15;
            })
        end
    end
    function arg1.onClickInventoryPlayer(arg1_5) -- Line 128
        local tbl_8 = {
            type = "setInventoryPlayer";
        }
        tbl_8.selectedPlayer = arg1_5
        store_upvr:dispatch(tbl_8)
        if Players_upvr.LocalPlayer.PlayerGui then
            Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 6105461542, {
                Volume = 0.15;
            })
        end
    end
end
function any_extend_result1._updateMyOffer(arg1, arg2) -- Line 136
    if arg2 == nil then
    end
    local SOME = ReplicatedStorage_upvr:FindFirstChild(TradeConsts_upvr.UPDATE_OFFERING_REMOTE_NAME)
    if SOME then
        SOME:FireServer(arg1.props.traderMe.ready, arg1:_getMeOfferIds())
    end
end
function any_extend_result1._getMeOfferIds(arg1) -- Line 146
    return TableUtils_upvr.map(arg1.props.traderMe.offerItems, function(arg1_6) -- Line 147
        return assert(arg1_6.id, "missing id itemProp")
    end)
end
local SortUtils_upvr = require(ReplicatedStorage_upvr.Garage.SortUtils)
function any_extend_result1._getFilteredInventoryItems(arg1) -- Line 153
    local module_2 = {}
    local tradeInventorySearchText = arg1.props.tradeInventorySearchText
    for _, v in ipairs(arg1.props.tradeInventory) do
        if TableUtils_upvr.hasDesiredValuesShallow(v, arg1.state.category.match) and (not tradeInventorySearchText or tradeInventorySearchText == "" or string.find(v.title:lower(), tradeInventorySearchText:lower(), nil, true)) then
            table.insert(module_2, v)
        end
    end
    table.sort(module_2, SortUtils_upvr.getTradeSortFunc(arg1.props.tradeSort))
    return module_2
end
function any_extend_result1._getFilteredInventoryPlayers(arg1) -- Line 171
    table.sort(arg1.props.inventoryPlayers.allPlayers, function(arg1_7, arg2) -- Line 172
        local var57
        if var57 == Players_upvr.LocalPlayer.UserId then
            var57 = true
            return var57
        end
        var57 = arg2.UserId
        if var57 == Players_upvr.LocalPlayer.UserId then
            var57 = false
            return var57
        end
        if arg1_7.DisplayName >= arg2.DisplayName then
            var57 = false
        else
            var57 = true
        end
        return var57
    end)
    if not arg1.props.tradeActive then
        return arg1.props.inventoryPlayers
    end
    local module = {
        allPlayers = {};
    }
    for _, v_2 in arg1.props.inventoryPlayers.allPlayers do
        if v_2.UserId == arg1.props.traderThem.userId or v_2.UserId == Players_upvr.LocalPlayer.UserId then
            table.insert(module.allPlayers, v_2)
        end
    end
    module.selectedPlayer = arg1.props.inventoryPlayers.selectedPlayer
    return module
end
local createElement_upvr = Roact.createElement
local TradeInventory_upvr = require(script.Parent.TradeInventory)
local TradeOffering_upvr = require(script.Parent.TradeOffering)
function any_extend_result1.render(arg1) -- Line 195
    local tbl_3 = {}
    for _, v_3 in ipairs(arg1.props.traderMe.offerItems) do
        tbl_3[v_3.id] = true
    end
    if arg1.props.tradeInventoryOpen then
        local tbl_7 = {}
        local ipairs_result1_3, ipairs_result2_2, ipairs_result3 = ipairs(arg1.state.inventoryItems)
        for _, v_4 in ipairs_result1_3, ipairs_result2_2, ipairs_result3 do
            local tbl_9 = {}
            if tbl_3[v_4.id] then
                tbl_9.selected = true
            end
            table.insert(tbl_7, tbl_9)
        end
        ipairs_result3 = {}
        ipairs_result3.size = arg1.props.size
        ipairs_result3.position = arg1.props.position
        ipairs_result3.anchorPoint = arg1.props.anchorPoint
        ipairs_result3.categories = arg1.categories
        ipairs_result3.category = arg1.state.category
        ipairs_result3.items = arg1.state.inventoryItems
        ipairs_result3.itemMetadata = tbl_7
        ipairs_result3.onClickExit = arg1.onClickExitInventory
        ipairs_result3.onClickItem = arg1.onClickInventoryItem
        ipairs_result3.onClickCategory = arg1.onClickCategory
        ipairs_result3.onCardFlipped = arg1.onCardFlipped
        ipairs_result3.onSelectSort = arg1.props.onSelectSort
        ipairs_result3.inventoryPlayers = arg1:_getFilteredInventoryPlayers()
        ipairs_result3.onClickInventoryPlayer = arg1.onClickInventoryPlayer
        ipairs_result3.sortId = arg1.props.tradeSort
        ipairs_result3.showChat = arg1.props.tradeActive
        ipairs_result3.tradeChatMessages = arg1.props.tradeChatMessages
        return createElement_upvr(TradeInventory_upvr, ipairs_result3)
    end
    if arg1.props.tradeActive then
        local var79 = ""
        if arg1.props.tradeInfo then
            if arg1.props.tradeInfo.msg then
                var79 = arg1.props.tradeInfo.msg
            elseif arg1.props.tradeInfo.debugProbability then
                var79 = "P(you better) [debug] = %.1f%%":format(arg1.props.tradeInfo.debugProbability * 100)
            end
        end
        ipairs_result3 = {}
        ipairs_result3.size = arg1.props.size
        ipairs_result3.position = arg1.props.position
        ipairs_result3.anchorPoint = arg1.props.anchorPoint
        ipairs_result3.traderMe = arg1.props.traderMe
        ipairs_result3.traderThem = arg1.props.traderThem
        ipairs_result3.promptInventory = arg1.promptInventory
        ipairs_result3.removeTraderMeOfferItem = arg1.removeTraderMeOfferItemByIndex
        ipairs_result3.onClickReady = arg1.onClickReady
        ipairs_result3.onClickUnready = arg1.onClickUnready
        ipairs_result3.onClickAccept = arg1.onClickAccept
        ipairs_result3.onClickDecline = arg1.onClickDecline
        ipairs_result3.onClickExit = arg1.onClickExit
        ipairs_result3.onCardFlipped = arg1.onCardFlipped
        ipairs_result3.infoMessage = var79
        ipairs_result3.showChat = arg1.props.tradeActive
        ipairs_result3.tradeChatMessages = arg1.props.tradeChatMessages
        return createElement_upvr(TradeOffering_upvr, ipairs_result3)
    end
end
local ActionButtonService_upvr = require(ReplicatedStorage_upvr.ActionButton.ActionButtonService)
function any_extend_result1.didUpdate(arg1, arg2, arg3) -- Line 262
    if arg1.state.category ~= arg3.category or arg1.props.tradeInventory ~= arg2.tradeInventory or arg1.props.tradeInventorySearchText ~= arg2.tradeInventorySearchText or arg1.props.tradeSort ~= arg2.tradeSort then
        arg1:setState({
            inventoryItems = arg1:_getFilteredInventoryItems();
        })
    end
    if arg1.props.tradeActive ~= arg2.tradeActive then
        if not arg1.props.tradeActive then
            arg1.activeMaid:DoCleaning()
            arg1:setState({
                category = arg1.categories[1];
            })
            arg1.props.setInventoryOpen(false)
            arg1.props.resetTradeInfo()
        end
        if arg1.props.tradeActive then
            arg1.activeMaid:GiveTask(ActionButtonService_upvr.pushHide())
        end
    end
    if arg1.props.tradeInventoryOpen and arg1.props.tradeInventoryOpen ~= arg2.tradeInventoryOpen then
        resetInventoryUserEditedValues_upvr()
    end
end
local EnumSort_upvr = require(ReplicatedStorage_upvr.Garage.EnumSort)
return require(ReplicatedStorage_upvr.RoactRodux).connect(function(arg1, arg2) -- Line 293
    return {
        traderMe = arg1.traderMe;
        traderThem = arg1.traderThem;
        tradeInventory = arg1.tradeInventory;
        tradeInventorySearchText = arg1.tradeInventorySearchText;
        tradeCategory = arg1.tradeCategory;
        tradeActive = arg1.tradeActive;
        tradeSort = arg1.tradeSort;
        tradeInventoryOpen = arg1.tradeInventoryOpen;
        tradeInfo = arg1.tradeInfo;
        inventoryPlayers = arg1.inventoryPlayers;
        tradeChatMessages = arg1.tradeChatMessages;
    }
end, function(arg1) -- Line 307
    return {
        onClickReady = function(arg1_8) -- Line 309, Named "onClickReady"
            arg1({
                type = "updateTraderMe";
                ready = true;
            })
        end;
        onClickUnready = function() -- Line 315, Named "onClickUnready"
            arg1({
                type = "updateTraderMe";
                ready = false;
            })
        end;
        addTraderMeOfferItem = function(arg1_9) -- Line 321, Named "addTraderMeOfferItem"
            local tbl = {
                type = "addTraderMeOfferItem";
            }
            tbl.item = arg1_9
            arg1(tbl)
        end;
        removeTraderMeOfferItem = function(arg1_10) -- Line 327, Named "removeTraderMeOfferItem"
            local tbl_2 = {
                type = "removeTraderMeOfferItem";
            }
            tbl_2.item = arg1_10
            arg1(tbl_2)
        end;
        removeTraderMeOfferItemByIndex = function(arg1_11) -- Line 333, Named "removeTraderMeOfferItemByIndex"
            local tbl_6 = {
                type = "removeTraderMeOfferItemByIndex";
            }
            tbl_6.index = arg1_11
            arg1(tbl_6)
        end;
        onSelectSort = function(arg1_12) -- Line 339, Named "onSelectSort"
            if Players_upvr.LocalPlayer.PlayerGui then
                Audio_upvr.ObjectLocal(Players_upvr.LocalPlayer.PlayerGui, 6105461542, {
                    Volume = 0.15;
                })
            end
            local var94
            if arg1_12 == EnumSort_upvr.Newest then
                var94 = EnumSort_upvr.Popular
            elseif arg1_12 == EnumSort_upvr.Popular then
                var94 = EnumSort_upvr.Alphabetical
            elseif arg1_12 == EnumSort_upvr.Alphabetical then
                var94 = EnumSort_upvr.Newest
            end
            arg1({
                type = "setTradeSortId";
                sortId = var94;
            })
        end;
        setInventoryOpen = function(arg1_13) -- Line 355, Named "setInventoryOpen"
            local tbl_4 = {
                type = "setTradeInventoryOpen";
            }
            tbl_4.value = arg1_13
            arg1(tbl_4)
        end;
        resetTradeInfo = function() -- Line 361, Named "resetTradeInfo"
            arg1({
                type = "setTradeInfo";
                info = nil;
            })
        end;
    }
end)(any_extend_result1)