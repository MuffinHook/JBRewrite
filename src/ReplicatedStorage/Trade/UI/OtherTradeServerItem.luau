-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Avatar = require(script.Parent.Avatar)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local PaddedContainer = require(ReplicatedStorage.EzUi.PaddedContainer)
local ScrollingGrid = require(ReplicatedStorage.EzUi.ScrollingGrid)
local TableUtils = require(ReplicatedStorage.Std.TableUtils)
local TradeConsts = require(ReplicatedStorage.Trade.TradeConsts)
local Players = game:GetService("Players")
local FriendsService = require(ReplicatedStorage.Friends.FriendsService)
local v1 = Roact.PureComponent:extend("OtherTradeServerItem")
function v1.render(p1)
	local v1 = TableUtils.map(p1.props.userIds, function(p1)
		return {
			userId = p1,
			isFriend = FriendsService.getIsFriendsWith(Players.LocalPlayer, p1)
		}
	end)
	table.sort(v1, function(p1, p2)
		return p1.isFriend and not p2.isFriend
	end)
	local t2 = {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 6)
		})
	}
	local t3 = {
		backgroundColor = Color3.new(0.3, 0.3, 0.3),
		backgroundTransparency = 0,
		aspectRatio = p1.props.aspectRatio,
		verticalPaddingRatio = p1.props.verticalPaddingRatio,
		paddingTop = 0,
		paddingLeft = 0,
		paddingRight = 0,
		paddingBottom = 0,
		size = UDim2.fromScale(1, 1)
	}
	local t4 = {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 6)
		})
	}
	local t5 = {
		backgroundTransparency = 1,
		size = UDim2.fromScale(0.12, 1),
		position = UDim2.fromScale(0, 0),
		paddingTop = 1,
		paddingLeft = 1,
		paddingRight = 2,
		paddingBottom = 1
	}
	local t6 = {}
	local t7 = {}
	t7.BackgroundColor3 = if #p1.props.userIds >= TradeConsts.MAX_TRADE_SERVER_SIZE then Color3.fromHex("908f91") else Color3.fromHex("5cc76d")
	t7.BackgroundTransparency = 0
	t7.Size = UDim2.new(1, 0, 1, 0)
	t7.Position = UDim2.new(0.5, 0, 0.5, 0)
	t7.AnchorPoint = Vector2.new(0.5, 0.5)
	t7.Text = "JOIN"
	t7.TextTransparency = 0.3
	t7.Font = Enum.Font.FredokaOne
	t7.TextXAlignment = Enum.TextXAlignment.Center
	t7.LineHeight = 1
	t7.TextSize = 26
	t7.TextColor3 = Color3.new(255/255, 255/255, 255/255)
	t7[Roact.Event.Activated] = function()
		p1.props.onJoinOtherTradeServer(p1.props.otherServerId)
	end
	t6.TextButton = createElement("TextButton", t7, {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 6)
		})
	})
	t4.JoinServer = createElement(PaddedContainer, t5, t6)
	local t8 = {
		backgroundTransparency = 1,
		size = UDim2.fromScale(0.06999999999999999, 1),
		position = UDim2.fromScale(0.12, 0),
		paddingTop = 1,
		paddingLeft = 1,
		paddingRight = 1,
		paddingBottom = 1
	}
	local t9 = {}
	local t10 = {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Font = Enum.Font.FredokaOne,
		TextXAlignment = Enum.TextXAlignment.Center
	}
	local v15 = tostring(#p1.props.userIds)
	t10.Text = v15 .. "/" .. tostring(TradeConsts.MAX_TRADE_SERVER_SIZE)
	t10.TextScaled = true
	t10.TextColor3 = Color3.fromHex("5cc76d")
	t9.Text = createElement("TextLabel", t10)
	t4.NumPlayers = createElement(PaddedContainer, t8, t9)
	t4.ServerPlayersContainer = createElement(PaddedContainer, {
		backgroundTransparency = 1,
		size = UDim2.fromScale(0.81, 1),
		position = UDim2.fromScale(0.19, 0),
		paddingLeft = 0.5,
		paddingRight = 0.5
	}, {
		Scrolling = createElement(ScrollingGrid, {
			exposePaddedContainerProps = true,
			rowsPerPage = 1,
			colsPerRow = 17,
			component = Avatar,
			items = v1
		})
	})
	t2.Container = createElement(PaddedContainer, t3, t4)
	return createElement("Frame", {
		BorderSizePixel = 0,
		BackgroundTransparency = 1,
		Size = p1.props.size,
		Position = p1.props.position,
		AnchorPoint = p1.props.anchorPoint
	}, t2)
end
return v1
