local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Dictionary = require(ReplicatedStorage.EzUi.Dictionary)
local Maid = require(ReplicatedStorage.Std.Maid)
local Interval = require(ReplicatedStorage.Std.Interval)
local ColorUtils = require(ReplicatedStorage.Std.ColorUtils)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local Grid = require(ReplicatedStorage.EzUi.Grid)
local TradeConsts = require(ReplicatedStorage.Trade.TradeConsts)
local TradeButton = require(script.Parent.TradeButton)
local TradeCard = require(script.Parent.TradeCard)
local TradeChat = require(script.Parent.TradeChat)
local PlayerTitle = require(script.Parent.PlayerTitle)
local TradeOffering = Roact.PureComponent:extend("TradeOffering")
TradeOffering.defaultProps = {
	size = UDim2.new(1, 0, 1, 0)
}
function TradeOffering.init(self)
	self.maid = Maid.new()
	local arrowSineBinding, updateArrowSine = Roact.createBinding(0)
	self.arrowSine = arrowSineBinding
	self.updateArrowSine = updateArrowSine
end
function TradeOffering.render(self)
	local traderMeColor = Color3.new(51/255, 51/255, 51/255)
	if self.props.traderMe.ready then
		traderMeColor = Color3.fromRGB(0, 153, 59)
	end
	if self.props.traderMe.accepted then
		traderMeColor = ColorUtils.brightenBy(traderMeColor, -0.5)
	end
	local traderThemColor = Color3.new(51/255, 51/255, 51/255)
	if self.props.traderThem.ready then
		traderThemColor = Color3.fromRGB(0, 153, 59)
	end
	if self.props.traderThem.accepted then
		traderThemColor = ColorUtils.brightenBy(traderThemColor, -0.5)
	end
	local traderMeOfferItems = {}
	for i = 1, TradeConsts.MAX_OFFER_ITEMS do
		local traderMeItemCount = #self.props.traderMe.offerItems
		if i <= traderMeItemCount then
			table.insert(traderMeOfferItems, Dictionary.merge(self.props.traderMe.offerItems[i], {
				onClick = function()
					self.props.removeTraderMeOfferItem(i)
				end
			}))
		elseif i == traderMeItemCount + 1 and not self.props.traderMe.ready then
			table.insert(traderMeOfferItems, {
				showPlus = true,
				onClick = self.props.promptInventory,
				onCardFlipped = self.props.onCardFlipped
			})
		else
			table.insert(traderMeOfferItems, {
				blank = true
			})
		end
	end
	local traderThemOfferItems = {}
	for j = 1, TradeConsts.MAX_OFFER_ITEMS do
		table.insert(traderThemOfferItems, self.props.traderThem.offerItems[j] or {
			blank = true,
			onCardFlipped = self.props.onCardFlipped
		})
	end
	local primaryButtonText = if self.props.traderMe.accepted then "Waiting..." elseif self.props.traderMe.ready and self.props.traderThem.ready then "Accept" elseif self.props.traderMe.ready then "Unready" else "Ready"
	if self.state.primaryButtonCountdown ~= nil then
		primaryButtonText = primaryButtonText .. " (" .. tostring(self.state.primaryButtonCountdown) .. ")"
	end
	local mainFrameProps = {
		BorderSizePixel = 0,
		BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
		BackgroundTransparency = 0.8,
		Size = self.props.size,
		Position = self.props.position,
		AnchorPoint = self.props.anchorPoint
	}
	local mainFrameChildren = {
		AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = 1.6
		}),
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		}),
		Offerings = createElement("Frame", {
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.new(255/255, 255/255, 255/255),
			BackgroundTransparency = 1,
			Size = UDim2.new(0.984375, 0, 0.8797851562500001, 0),
			Position = UDim2.new(0.0078125, 0, 0.0125, 0)
		}, {
			Arrow1 = createElement("ImageLabel", {
				BackgroundTransparency = 1,
				ImageColor3 = traderMeColor,
				Image = "rbxassetid://9529821938",
				Size = UDim2.new(0.13986013986013987, 0, 0.07459207459207459, 0),
				Position = self.arrowSine:map(function(sineValue)
					return UDim2.new(0, 0, 0.4627039627039627 - 0.07459207459207459 * sineValue - 0.005, 0)
				end)
			}),
			Arrow2 = createElement("ImageLabel", {
				BackgroundTransparency = 1,
				ImageColor3 = traderThemColor,
				Image = "rbxassetid://9529821938",
				Size = UDim2.new(0.13986013986013987, 0, 0.07459207459207459, 0),
				Position = self.arrowSine:map(function(sineValue)
					return UDim2.new(0.8601398601398601, 0, 0.4627039627039627 + 0.07459207459207459 * sineValue + 0.005, 0)
				end),
				Rotation = 180
			}),
			Player1Offering = createElement("Frame", {
				BackgroundColor3 = traderMeColor,
				BackgroundTransparency = 0,
				Size = UDim2.new(1, 0, 0.4627039627039627, 0),
				Position = UDim2.new(0, 0, 0, 0),
				BorderSizePixel = 0,
				ZIndex = 3
			}, {
				UICorner = createElement("UICorner", {
					CornerRadius = UDim.new(0, 4)
				}),
				PlayerTitle = createElement(PlayerTitle, {
					size = UDim2.new(0.984375, 0, 1, 0),
					position = UDim2.new(0.0078125, 0, 0.030226700251889168, 0),
					parentRatio = 3.8690176322418135,
					aspectRatio = 30,
					ready = self.props.traderMe.ready,
					displayName = self.props.traderMe.displayName,
					userId = self.props.traderMe.userId
				}),
				Cards = createElement("Frame", {
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0.8105793450881612, 0),
					Position = UDim2.new(0, 0, 0.1894206549118388, 0)
				}, {
					Grid = createElement(Grid, {
						aspectRatio = 4.773151025481665,
						paddingRatio = 128,
						rowsPerPage = 1,
						colsPerRow = TradeConsts.MAX_OFFER_ITEMS,
						component = TradeCard,
						items = traderMeOfferItems
					})
				})
			}),
			Player2Offering = createElement("Frame", {
				BackgroundColor3 = traderThemColor,
				BackgroundTransparency = 0,
				Size = UDim2.new(1, 0, 0.4627039627039627, 0),
				Position = UDim2.new(0, 0, 0.5372960372960373, 0),
				BorderSizePixel = 0,
				ZIndex = 3
			}, {
				UICorner = createElement("UICorner", {
					CornerRadius = UDim.new(0, 4)
				}),
				PlayerTitle = createElement(PlayerTitle, {
					size = UDim2.new(0.984375, 0, 1, 0),
					position = UDim2.new(0.0078125, 0, 0.030226700251889168, 0),
					parentRatio = 3.8690176322418135,
					aspectRatio = 30,
					ready = self.props.traderThem.ready,
					displayName = self.props.traderThem.displayName,
					userId = self.props.traderThem.userId
				}),
				Cards = createElement("Frame", {
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0.8105793450881612, 0),
					Position = UDim2.new(0, 0, 0.1894206549118388, 0)
				}, {
					Grid = createElement(Grid, {
						aspectRatio = 4.773151025481665,
						paddingRatio = 128,
						rowsPerPage = 1,
						colsPerRow = TradeConsts.MAX_OFFER_ITEMS,
						component = TradeCard,
						items = traderThemOfferItems
					})
				})
			})
		}),
		Info = createElement("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(0.6644531250000001, 0, 0.07998046875, 0),
			Position = UDim2.new(0.0078125, 0, 0.9047851562500001, 0),
			ZIndex = 2
		}, {
			Title = createElement("Frame", {
				BackgroundTransparency = 1,
				BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
				Size = UDim2.new(0.9921875, 0, 1, 0),
				Position = UDim2.new(0.0078125, 0, 0, 0)
			}, {
				Text = createElement("TextLabel", {
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 1, 0),
					Position = UDim2.new(0.5, 0, 0.5, 0),
					AnchorPoint = Vector2.new(0.5, 0.5),
					TextColor3 = Color3.new(255/255, 255/255, 255/255),
					Text = self.props.infoMessage or "",
					TextXAlignment = Enum.TextXAlignment.Left,
					Font = Enum.Font.Bangers,
					LineHeight = 1,
					TextScaled = true
				})
			})
		})
	}
	local buttonBarFrameProps = {
		BorderSizePixel = 0,
		BackgroundColor3 = Color3.new(51/255, 51/255, 51/255),
		BackgroundTransparency = 0,
		Size = UDim2.new(0.984375, 0, 0.07998046875, 0),
		Position = UDim2.new(0.0078125, 0, 0.9047851562500001, 0)
	}
	local buttonBarChildren = {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		}),
		ListLayout = createElement("UIListLayout", {
			HorizontalAlignment = Enum.HorizontalAlignment.Right,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			SortOrder = Enum.SortOrder.LayoutOrder,
			FillDirection = Enum.FillDirection.Horizontal,
			Padding = UDim.new(0.0078125, 0)
		}),
		Padding = createElement("UIPadding", {
			PaddingLeft = UDim.new(0.0078125, 0),
			PaddingRight = UDim.new(0.0078125, 0),
			PaddingTop = UDim.new(0.15384615384615385, 0),
			PaddingBottom = UDim.new(0.15384615384615385, 0)
		})
	}
	local declineExitButtonProps = {
		layoutOrder = 1,
		backgroundColor = Color3.fromRGB(255, 58, 43)
	}
	declineExitButtonProps.disabled = self.props.traderMe.accepted and self.props.traderThem.accepted
	declineExitButtonProps.text = if self.props.traderMe.ready and self.props.traderThem.ready then "Decline" else "Exit"
	declineExitButtonProps.onClick = if self.props.traderMe.ready and self.props.traderThem.ready then self.props.onClickDecline else self.props.onClickExit
	buttonBarChildren.Button1 = createElement(TradeButton, declineExitButtonProps)
	local primaryButtonProps = {
		layoutOrder = 2
	}
	primaryButtonProps.backgroundColor = if self.props.traderMe.ready and self.props.traderThem.ready then Color3.fromRGB(0, 200, 90) else Color3.fromRGB(41, 171, 255)
	primaryButtonProps.disabled = if self.state.primaryButtonCountdown == nil then self.props.traderMe.accepted else true
	primaryButtonProps.text = primaryButtonText
	primaryButtonProps.onClick = if self.props.traderMe.ready and self.props.traderThem.ready then self.props.onClickAccept elseif self.props.traderMe.ready then self.props.onClickUnready else self.props.onClickReady
	buttonBarChildren.Button2 = createElement(TradeButton, primaryButtonProps)
	mainFrameChildren.Buttons = createElement("Frame", buttonBarFrameProps, buttonBarChildren)
	mainFrameChildren.Chat = if self.props.showChat == nil then false else createElement(TradeChat, {
	size = UDim2.new(0.25, 0, 1, 0),
	position = UDim2.new(1.0078125, 0, 0, 0),
	aspectRatio = 0.4,
	verticalPaddingRatio = 80,
	messages = self.props.tradeChatMessages
})
	return createElement("Frame", mainFrameProps, mainFrameChildren)
end
function TradeOffering.didUpdate(self, previousProps, previousState)
	if previousProps.traderMe.ready ~= self.props.traderMe.ready or previousProps.traderThem.ready ~= self.props.traderThem.ready then
		local countdownStartTime = os.clock()
		local function update(countdownSeconds)
			local timeRemaining = countdownSeconds - (os.clock() - countdownStartTime)
			if timeRemaining < 0 then
				self:setState({
					primaryButtonCountdown = Roact.None
				})
				self.maid.countdown = nil
			else
				self:setState({
					primaryButtonCountdown = math.ceil(timeRemaining)
				})
			end
		end
		if self.props.traderMe.ready and self.props.traderThem.ready then
			update(5)
			self.maid.countdown = Interval.every(1):Connect(function()
				update(5)
			end)
			return
		end
		if previousProps.traderMe.ready and not self.props.traderMe.ready then
			update(1)
			self.maid.countdown = Interval.every(1):Connect(function()
				update(1)
			end)
			return
		end
		self:setState({
			primaryButtonCountdown = Roact.None
		})
		self.maid.countdown = nil
	end
end
function TradeOffering.didMount(self)
	self.maid:GiveTask(RunService.Heartbeat:Connect(function()
		self.updateArrowSine(math.sin(os.clock() * 3) * 0.5 + 0.5)
	end))
end
function TradeOffering.willUnmount(self)
	self.maid:DoCleaning()
end
return TradeOffering
