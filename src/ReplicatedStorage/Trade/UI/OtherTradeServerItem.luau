local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage.Roact)
local any_extend_result1 = Roact_upvr.PureComponent:extend("OtherTradeServerItem")
local TableUtils_upvr = require(ReplicatedStorage.Std.TableUtils)
local FriendsService_upvr = require(ReplicatedStorage.Friends.FriendsService)
local Players_upvr = game:GetService("Players")
local createElement_upvr = Roact_upvr.createElement
local PaddedContainer_upvr = require(ReplicatedStorage.EzUi.PaddedContainer)
local TradeConsts_upvr = require(ReplicatedStorage.Trade.TradeConsts)
local ScrollingGrid_upvr = require(ReplicatedStorage.EzUi.ScrollingGrid)
local Avatar_upvr = require(script.Parent.Avatar)
function any_extend_result1.render(arg1) -- Line 13
    local any_map_result1 = TableUtils_upvr.map(arg1.props.userIds, function(arg1_2) -- Line 21
        local module_2 = {}
        module_2.userId = arg1_2
        module_2.isFriend = FriendsService_upvr.getIsFriendsWith(Players_upvr.LocalPlayer, arg1_2)
        return module_2
    end)
    table.sort(any_map_result1, function(arg1_3, arg2) -- Line 24
        local isFriend = arg1_3.isFriend
        if isFriend then
            isFriend = not arg2.isFriend
        end
        return isFriend
    end)
    local module = {
        UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, 6);
        });
    }
    local tbl_3 = {
        UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(0, 6);
        });
    }
    local tbl_4 = {}
    local tbl_7 = {}
    local var26
    if TradeConsts_upvr.MAX_TRADE_SERVER_SIZE <= #arg1.props.userIds then
        var26 = Color3.fromHex("908f91")
    else
        var26 = Color3.fromHex("5cc76d")
    end
    tbl_7.BackgroundColor3 = var26
    var26 = 0
    tbl_7.BackgroundTransparency = var26
    var26 = UDim2.new(1, 0, 1, 0)
    tbl_7.Size = var26
    var26 = UDim2.new(0.5, 0, 0.5, 0)
    tbl_7.Position = var26
    var26 = Vector2.new(0.5, 0.5)
    tbl_7.AnchorPoint = var26
    var26 = "JOIN"
    tbl_7.Text = var26
    var26 = 0.3
    tbl_7.TextTransparency = var26
    var26 = Enum.Font.FredokaOne
    tbl_7.Font = var26
    var26 = Enum.TextXAlignment.Center
    tbl_7.TextXAlignment = var26
    var26 = 1
    tbl_7.LineHeight = var26
    var26 = 26
    tbl_7.TextSize = var26
    var26 = Color3.new(1, 1, 1)
    tbl_7.TextColor3 = var26
    var26 = Roact_upvr
    var26 = var26.Event
    var26 = var26.Activated
    tbl_7[var26] = function() -- Line 76
        arg1.props.onJoinOtherTradeServer(arg1.props.otherServerId)
    end
    var26 = {}
    var26.UICorner = createElement_upvr("UICorner", {
        CornerRadius = UDim.new(0, 6);
    })
    tbl_4.TextButton = createElement_upvr("TextButton", tbl_7, var26)
    tbl_3.JoinServer = createElement_upvr(PaddedContainer_upvr, {
        backgroundTransparency = 1;
        size = UDim2.fromScale(0.12, 1);
        position = UDim2.fromScale(0, 0);
        paddingTop = 1;
        paddingLeft = 1;
        paddingRight = 2;
        paddingBottom = 1;
    }, tbl_4)
    local tbl_5 = {}
    local tbl_6 = {}
    var26 = 1
    tbl_6.BackgroundTransparency = var26
    var26 = UDim2.new(1, 0, 1, 0)
    tbl_6.Size = var26
    var26 = UDim2.new(0.5, 0, 0.5, 0)
    tbl_6.Position = var26
    var26 = Vector2.new(0.5, 0.5)
    tbl_6.AnchorPoint = var26
    var26 = Enum.Font.FredokaOne
    tbl_6.Font = var26
    var26 = Enum.TextXAlignment.Center
    tbl_6.TextXAlignment = var26
    var26 = tostring(#arg1.props.userIds)..'/'..tostring(TradeConsts_upvr.MAX_TRADE_SERVER_SIZE)
    tbl_6.Text = var26
    var26 = true
    tbl_6.TextScaled = var26
    var26 = Color3.fromHex("5cc76d")
    tbl_6.TextColor3 = var26
    tbl_5.Text = createElement_upvr("TextLabel", tbl_6)
    tbl_3.NumPlayers = createElement_upvr(PaddedContainer_upvr, {
        backgroundTransparency = 1;
        size = UDim2.fromScale(0.06999999999999999, 1);
        position = UDim2.fromScale(0.12, 0);
        paddingTop = 1;
        paddingLeft = 1;
        paddingRight = 1;
        paddingBottom = 1;
    }, tbl_5)
    local tbl = {}
    local tbl_2 = {}
    var26 = true
    tbl_2.exposePaddedContainerProps = var26
    var26 = 1
    tbl_2.rowsPerPage = var26
    var26 = 17
    tbl_2.colsPerRow = var26
    var26 = Avatar_upvr
    tbl_2.component = var26
    tbl_2.items = any_map_result1
    tbl.Scrolling = createElement_upvr(ScrollingGrid_upvr, tbl_2)
    tbl_3.ServerPlayersContainer = createElement_upvr(PaddedContainer_upvr, {
        backgroundTransparency = 1;
        size = UDim2.fromScale(0.81, 1);
        position = UDim2.fromScale(0.19, 0);
        paddingLeft = 0.5;
        paddingRight = 0.5;
    }, tbl)
    module.Container = createElement_upvr(PaddedContainer_upvr, {
        backgroundColor = Color3.new(0.3, 0.3, 0.3);
        backgroundTransparency = 0;
        aspectRatio = arg1.props.aspectRatio;
        verticalPaddingRatio = arg1.props.verticalPaddingRatio;
        paddingTop = 0;
        paddingLeft = 0;
        paddingRight = 0;
        paddingBottom = 0;
        size = UDim2.fromScale(1, 1);
    }, tbl_3)
    return createElement_upvr("Frame", {
        BorderSizePixel = 0;
        BackgroundTransparency = 1;
        Size = arg1.props.size;
        Position = arg1.props.position;
        AnchorPoint = arg1.props.anchorPoint;
    }, module)
end
return any_extend_result1