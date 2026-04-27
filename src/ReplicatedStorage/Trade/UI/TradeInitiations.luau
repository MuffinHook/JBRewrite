local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Std.Audio)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
local Dictionary = require(ReplicatedStorage.EzUi.Dictionary)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local TradeConsts = require(ReplicatedStorage.Trade.TradeConsts)
local TradeInitiation = require(script.Parent.TradeInitiation)
local TradeService = require(ReplicatedStorage.Trade.TradeService)
local function playTick()
	if Players.LocalPlayer.PlayerGui then
		Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 6105461542, {
			Volume = 0.15
		})
	end
end
local TradeInitiationsComponent = Roact.PureComponent:extend("TradeInitiations")
TradeInitiationsComponent.defaultProps = {
	size = UDim2.new(1, 0, 1, 0),
	position = UDim2.new(0, 0, 0, 0),
	aspectRatio = 1.25,
	maximumItemsDisplayed = 4
}
function TradeInitiationsComponent.init(self)
	function self.onAccept(initiationIndex)
		TradeService.acceptInitiation(self.props.tradeInitiations[initiationIndex].userId)
		self.props.removeByIndex(initiationIndex)
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 6105461542, {
				Volume = 0.15
			})
		end
	end
	function self.onDecline(initiationIndex)
		ReplicatedStorage:FindFirstChild(TradeConsts.DECLINE_TRADE_INITIATION_REMOTE_NAME):FireServer(self.props.tradeInitiations[initiationIndex].userId)
		self.props.removeByIndex(initiationIndex)
		if Players.LocalPlayer.PlayerGui then
			Audio.ObjectLocal(Players.LocalPlayer.PlayerGui, 6105461542, {
				Volume = 0.15
			})
		end
	end
end
function TradeInitiationsComponent.render(self)
	local itemWidth = 1 / (1 / self.props.maximumItemsDisplayed - 1 / (256 / self.props.maximumItemsDisplayed)) * self.props.aspectRatio
	local totalHeight = self.props.maximumItemsDisplayed * self.props.aspectRatio
	local initiationCount = #self.props.tradeInitiations
	local elements = {}
	for i = 1, math.min(initiationCount, self.props.maximumItemsDisplayed) do
		local currentIndex = initiationCount - i + 1
		local initiationData = self.props.tradeInitiations[currentIndex]
		elements[i] = createElement(TradeInitiation, {
			aspectRatio = itemWidth,
			position = UDim2.new(0, 0, 1 + (i - initiationCount - 1) / totalHeight * self.props.aspectRatio, 0),
			displayName = initiationData.name,
			isTradingVIP = initiationData.isTradingVIP,
			obj = initiationData.obj,
			index = currentIndex,
			onAccept = self.onAccept,
			onDecline = self.onDecline
		})
	end
	return createElement("Frame", {
		BackgroundTransparency = 1,
		Size = self.props.size,
		Position = self.props.position,
		AnchorPoint = self.props.anchorPoint,
		ZIndex = 2
	}, Dictionary.merge({
		AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = self.props.aspectRatio
		})
	}, elements))
end
return RoactRodux.connect(function(state, dispatch)
	return {
		tradeInitiations = state.tradeInitiations
	}
end, function(dispatch)
	return {
		removeByIndex = function(initiationIndex)
			dispatch({
				type = "tradeInitiationsRemoveByIndex",
				index = initiationIndex
			})
		end
	}
end)(TradeInitiationsComponent)
