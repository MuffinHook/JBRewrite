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
local v1 = Roact.PureComponent:extend("TradeOffering")
v1.defaultProps = {
	size = UDim2.new(1, 0, 1, 0)
}
function v1.init(p1) --[[ Line: 21 | Upvalues: Maid (copy), Roact (copy) ]]
	p1.maid = Maid.new()
	local v1, v2 = Roact.createBinding(0)
	p1.arrowSine = v1
	p1.updateArrowSine = v2
end
function v1.render(p1) --[[ Line: 25 | Upvalues: ColorUtils (copy), TradeConsts (copy), Dictionary (copy), createElement (copy), PlayerTitle (copy), Grid (copy), TradeCard (copy), TradeButton (copy), TradeChat (copy) ]]
	local v1 = Color3.new(51/255, 51/255, 51/255)
	if p1.props.traderMe.ready then
		v1 = Color3.fromRGB(0, 153, 59)
	end
	if p1.props.traderMe.accepted then
		v1 = ColorUtils.brightenBy(v1, -0.5)
	end
	local v4 = Color3.new(51/255, 51/255, 51/255)
	if p1.props.traderThem.ready then
		v4 = Color3.fromRGB(0, 153, 59)
	end
	if p1.props.traderThem.accepted then
		v4 = ColorUtils.brightenBy(v4, -0.5)
	end
	local t = {}
	for i = 1, TradeConsts.MAX_OFFER_ITEMS do
		local v7 = #p1.props.traderMe.offerItems
		if i <= v7 then
			table.insert(t, Dictionary.merge(p1.props.traderMe.offerItems[i], {
				onClick = function() --[[ Name: onClick | Line: 69 | Upvalues: p1 (copy), i (copy) ]]
					p1.props.removeTraderMeOfferItem(i)
				end
			}))
		elseif i == v7 + 1 and not p1.props.traderMe.ready then
			table.insert(t, {
				showPlus = true,
				onClick = p1.props.promptInventory,
				onCardFlipped = p1.props.onCardFlipped
			})
		else
			table.insert(t, {
				blank = true
			})
		end
	end
	local t2 = {}
	for j = 1, TradeConsts.MAX_OFFER_ITEMS do
		table.insert(t2, p1.props.traderThem.offerItems[j] or {
			blank = true,
			onCardFlipped = p1.props.onCardFlipped
		})
	end
	local v10 = if p1.props.traderMe.accepted then "Waiting..." elseif p1.props.traderMe.ready and p1.props.traderThem.ready then "Accept" elseif p1.props.traderMe.ready then "Unready" else "Ready"
	if p1.state.primaryButtonCountdown ~= nil then
		v10 = v10 .. " (" .. tostring(p1.state.primaryButtonCountdown) .. ")"
	end
	local t3 = {
		BorderSizePixel = 0,
		BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
		BackgroundTransparency = 0.8,
		Size = p1.props.size,
		Position = p1.props.position,
		AnchorPoint = p1.props.anchorPoint
	}
	local t4 = {
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
				ImageColor3 = v1,
				Image = "rbxassetid://9529821938",
				Size = UDim2.new(0.13986013986013987, 0, 0.07459207459207459, 0),
				Position = p1.arrowSine:map(function(p1) --[[ Line: 128 ]]
					return UDim2.new(0, 0, 0.4627039627039627 - 0.07459207459207459 * p1 - 0.005, 0)
				end)
			}),
			Arrow2 = createElement("ImageLabel", {
				BackgroundTransparency = 1,
				ImageColor3 = v4,
				Image = "rbxassetid://9529821938",
				Size = UDim2.new(0.13986013986013987, 0, 0.07459207459207459, 0),
				Position = p1.arrowSine:map(function(p1) --[[ Line: 137 ]]
					return UDim2.new(0.8601398601398601, 0, 0.4627039627039627 + 0.07459207459207459 * p1 + 0.005, 0)
				end),
				Rotation = 180
			}),
			Player1Offering = createElement("Frame", {
				BackgroundColor3 = v1,
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
					ready = p1.props.traderMe.ready,
					displayName = p1.props.traderMe.displayName,
					userId = p1.props.traderMe.userId
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
						items = t
					})
				})
			}),
			Player2Offering = createElement("Frame", {
				BackgroundColor3 = v4,
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
					ready = p1.props.traderThem.ready,
					displayName = p1.props.traderThem.displayName,
					userId = p1.props.traderThem.userId
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
						items = t2
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
					Text = p1.props.infoMessage or "",
					TextXAlignment = Enum.TextXAlignment.Left,
					Font = Enum.Font.Bangers,
					LineHeight = 1,
					TextScaled = true
				})
			})
		})
	}
	local t5 = {
		BorderSizePixel = 0,
		BackgroundColor3 = Color3.new(51/255, 51/255, 51/255),
		BackgroundTransparency = 0,
		Size = UDim2.new(0.984375, 0, 0.07998046875, 0),
		Position = UDim2.new(0.0078125, 0, 0.9047851562500001, 0)
	}
	local t6 = {
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
	local t7 = {
		layoutOrder = 1,
		backgroundColor = Color3.fromRGB(255, 58, 43)
	}
	t7.disabled = p1.props.traderMe.accepted and p1.props.traderThem.accepted
	t7.text = if p1.props.traderMe.ready and p1.props.traderThem.ready then "Decline" else "Exit"
	t7.onClick = if p1.props.traderMe.ready and p1.props.traderThem.ready then p1.props.onClickDecline else p1.props.onClickExit
	t6.Button1 = createElement(TradeButton, t7)
	local t8 = {
		layoutOrder = 2
	}
	t8.backgroundColor = if p1.props.traderMe.ready and p1.props.traderThem.ready then Color3.fromRGB(0, 200, 90) else Color3.fromRGB(41, 171, 255)
	t8.disabled = if p1.state.primaryButtonCountdown == nil then p1.props.traderMe.accepted else true
	t8.text = v10
	t8.onClick = if p1.props.traderMe.ready and p1.props.traderThem.ready then p1.props.onClickAccept elseif p1.props.traderMe.ready then p1.props.onClickUnready else p1.props.onClickReady
	t6.Button2 = createElement(TradeButton, t8)
	t4.Buttons = createElement("Frame", t5, t6)
	t4.Chat = if p1.props.showChat == nil then false else createElement(TradeChat, {
	size = UDim2.new(0.25, 0, 1, 0),
	position = UDim2.new(1.0078125, 0, 0, 0),
	aspectRatio = 0.4,
	verticalPaddingRatio = 80,
	messages = p1.props.tradeChatMessages
})
	return createElement("Frame", t3, t4)
end
function v1.didUpdate(p1, p2, p3) --[[ Line: 304 | Upvalues: Roact (copy), Interval (copy) ]]
	if p2.traderMe.ready ~= p1.props.traderMe.ready or p2.traderThem.ready ~= p1.props.traderThem.ready then
		local v1 = os.clock()
		local function update(p12) --[[ Line: 310 | Upvalues: v1 (copy), p1 (copy), Roact (ref) ]]
			local v12 = p12 - (os.clock() - v1)
			if v12 < 0 then
				p1:setState({
					primaryButtonCountdown = Roact.None
				})
				p1.maid.countdown = nil
			else
				p1:setState({
					primaryButtonCountdown = math.ceil(v12)
				})
			end
		end
		if p1.props.traderMe.ready and p1.props.traderThem.ready then
			update(5)
			p1.maid.countdown = Interval.every(1):Connect(function() --[[ Line: 328 | Upvalues: update (copy) ]]
				update(5)
			end)
			return
		end
		if p2.traderMe.ready and not p1.props.traderMe.ready then
			update(1)
			p1.maid.countdown = Interval.every(1):Connect(function() --[[ Line: 334 | Upvalues: update (copy) ]]
				update(1)
			end)
			return
		end
		p1:setState({
			primaryButtonCountdown = Roact.None
		})
		p1.maid.countdown = nil
	end
end
function v1.didMount(p1) --[[ Line: 345 | Upvalues: RunService (copy) ]]
	p1.maid:GiveTask(RunService.Heartbeat:Connect(function() --[[ Line: 346 | Upvalues: p1 (copy) ]]
		p1.updateArrowSine(math.sin(os.clock() * 3) * 0.5 + 0.5)
	end))
end
function v1.willUnmount(p1) --[[ Line: 351 ]]
	p1.maid:DoCleaning()
end
return v1