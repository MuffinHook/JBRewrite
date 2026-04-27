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
local OtherTradeServerItem = Roact.PureComponent:extend("OtherTradeServerItem")
function OtherTradeServerItem.render(component)
	local usersWithFriendStatus = TableUtils.map(component.props.userIds, function(userId)
		return {
			userId = userId,
			isFriend = FriendsService.getIsFriendsWith(Players.LocalPlayer, userId)
		}
	end)
	table.sort(usersWithFriendStatus, function(userA, userB)
		return userA.isFriend and not userB.isFriend
	end)
	local frameChildren = {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 6)
		})
	}
	local containerProps = {
		backgroundColor = Color3.new(0.3, 0.3, 0.3),
		backgroundTransparency = 0,
		aspectRatio = component.props.aspectRatio,
		verticalPaddingRatio = component.props.verticalPaddingRatio,
		paddingTop = 0,
		paddingLeft = 0,
		paddingRight = 0,
		paddingBottom = 0,
		size = UDim2.fromScale(1, 1)
	}
	local containerChildren = {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 6)
		})
	}
	local joinButtonPaddingProps = {
		backgroundTransparency = 1,
		size = UDim2.fromScale(0.12, 1),
		position = UDim2.fromScale(0, 0),
		paddingTop = 1,
		paddingLeft = 1,
		paddingRight = 2,
		paddingBottom = 1
	}
	local joinButtonChildren = {}
	local joinButtonProps = {}
	joinButtonProps.BackgroundColor3 = if #component.props.userIds >= TradeConsts.MAX_TRADE_SERVER_SIZE then Color3.fromHex("908f91") else Color3.fromHex("5cc76d")
	joinButtonProps.BackgroundTransparency = 0
	joinButtonProps.Size = UDim2.new(1, 0, 1, 0)
	joinButtonProps.Position = UDim2.new(0.5, 0, 0.5, 0)
	joinButtonProps.AnchorPoint = Vector2.new(0.5, 0.5)
	joinButtonProps.Text = "JOIN"
	joinButtonProps.TextTransparency = 0.3
	joinButtonProps.Font = Enum.Font.FredokaOne
	joinButtonProps.TextXAlignment = Enum.TextXAlignment.Center
	joinButtonProps.LineHeight = 1
	joinButtonProps.TextSize = 26
	joinButtonProps.TextColor3 = Color3.new(255/255, 255/255, 255/255)
	joinButtonProps[Roact.Event.Activated] = function()
		component.props.onJoinOtherTradeServer(component.props.otherServerId)
	end
	joinButtonChildren.TextButton = createElement("TextButton", joinButtonProps, {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 6)
		})
	})
	containerChildren.JoinServer = createElement(PaddedContainer, joinButtonPaddingProps, joinButtonChildren)
	local playerCountPaddingProps = {
		backgroundTransparency = 1,
		size = UDim2.fromScale(7/100, 1),
		position = UDim2.fromScale(0.12, 0),
		paddingTop = 1,
		paddingLeft = 1,
		paddingRight = 1,
		paddingBottom = 1
	}
	local playerCountChildren = {}
	local playerCountLabelProps = {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Font = Enum.Font.FredokaOne,
		TextXAlignment = Enum.TextXAlignment.Center
	}
	local playerCountText = tostring(#component.props.userIds)
	playerCountLabelProps.Text = playerCountText .. "/" .. tostring(TradeConsts.MAX_TRADE_SERVER_SIZE)
	playerCountLabelProps.TextScaled = true
	playerCountLabelProps.TextColor3 = Color3.fromHex("5cc76d")
	playerCountChildren.Text = createElement("TextLabel", playerCountLabelProps)
	containerChildren.NumPlayers = createElement(PaddedContainer, playerCountPaddingProps, playerCountChildren)
	containerChildren.ServerPlayersContainer = createElement(PaddedContainer, {
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
			items = usersWithFriendStatus
		})
	})
	frameChildren.Container = createElement(PaddedContainer, containerProps, containerChildren)
	return createElement("Frame", {
		BorderSizePixel = 0,
		BackgroundTransparency = 1,
		Size = component.props.size,
		Position = component.props.position,
		AnchorPoint = component.props.anchorPoint
	}, frameChildren)
end
return OtherTradeServerItem
