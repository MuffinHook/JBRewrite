local ReplicatedStorage = game:GetService("ReplicatedStorage")
local String = require(ReplicatedStorage.Std.String)
local Dictionary = require(ReplicatedStorage.EzUi.Dictionary)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local ReceiptItem = require(script.Parent.ReceiptItem)
local Receipt = Roact.PureComponent:extend("Receipt")
Receipt.defaultProps = {
	showTotal = true
}
function Receipt.init(self)  end
function Receipt.render(self)
	local mainRatio = self.props.mainRatio
	local cornerPixel = self.props.cornerPixel
	local paddingRatio = self.props.paddingRatio
	local doublePaddingRatio = self.props.paddingRatio * 2
	local adjustedRatio = self.props.showTotal and 1 / (1 / mainRatio - 2/9) or mainRatio
	local sum = 0
	local receiptElements = {}
	local count = 0
	for i = 1, #self.props.receipt do
		local isVisible
		local receiptItem = self.props.receipt[i]
		local itemPrice = receiptItem.price or 0
		isVisible = not (self.props.owned[receiptItem.category] and self.props.owned[receiptItem.category][receiptItem.name])
		if receiptItem.limited then
			isVisible = false
		end
		if isVisible then
			table.insert(receiptElements, (createElement(ReceiptItem, Dictionary.merge({
				layoutOrder = i * 2,
				mainRatio = 1 / (1 / (adjustedRatio * 6) - 1 / doublePaddingRatio + 1 / doublePaddingRatio / 6),
				paddingRatio = paddingRatio,
				cornerPixel = cornerPixel,
				onRequestRemove = function()
					self.props.onRequestRemove(receiptItem)
				end
			}, receiptItem))))
			table.insert(receiptElements, (createElement("Frame", {
				BorderSizePixel = 0,
				BackgroundTransparency = 0,
				BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
				Size = UDim2.new(1, 0, 1, 0),
				LayoutOrder = i * 2 + 1
			}, {
				AspectRatio = createElement("UIAspectRatioConstraint", {
					AspectRatio = doublePaddingRatio
				})
			})))
			sum = sum + itemPrice
			count = count + 1
		end
	end
	local mainFrameProps = {
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		BackgroundColor3 = Color3.new(0.1, 0.1, 0.1),
		Size = UDim2.new(1, 0, 1, 0),
		LayoutOrder = self.props.layoutOrder
	}
	local mainFrameChildren = {
		AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = mainRatio
		}),
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, cornerPixel)
		}),
		ScrollingFrame = createElement("ScrollingFrame", {
			BackgroundTransparency = 1,
			BackgroundColor3 = Color3.new(255/255, 255/255, 255/255),
			BorderSizePixel = 0,
			ScrollBarThickness = 4,
			ScrollBarImageColor3 = Color3.new(255/255, 255/255, 255/255),
			CanvasSize = UDim2.new(0, 0, ((1 + mainRatio / doublePaddingRatio) * count / 6 - mainRatio / doublePaddingRatio) * mainRatio / adjustedRatio, 0),
			Size = UDim2.new(1, 0, mainRatio / adjustedRatio, 0),
			ElasticBehavior = Enum.ElasticBehavior.Always,
			VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Left,
			VerticalScrollBarInset = Enum.ScrollBarInset.None
		}, Dictionary.merge({
			ListLayout = createElement("UIListLayout", {
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Top,
				SortOrder = Enum.SortOrder.LayoutOrder,
				FillDirection = Enum.FillDirection.Vertical
			})
		}, receiptElements))
	}
	local bottomFrameProps = {
		BackgroundTransparency = 0.6,
		BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, mainRatio / 4.5, 0),
		Position = UDim2.new(0, 0, 1 - mainRatio / 4.5, 0),
		Visible = self.props.showTotal
	}
	local bottomFrameChildren = {
		Line = createElement("Frame", {
			Size = UDim2.new(1, 0, 0, 1),
			Position = UDim2.new(0, 0, 0, 0),
			BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
			BorderSizePixel = 0
		}),
		Total = createElement("Frame", {
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = UDim2.new(0.5 - 0.5 / paddingRatio - 1 / paddingRatio, 0, 0.6, 0),
			Position = UDim2.new(1 / paddingRatio, 0, 0.2, 0)
		}, {
			Title = createElement("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 1, 0),
				Position = UDim2.new(0, 0, 0, 0),
				AnchorPoint = Vector2.new(0, 0),
				Text = "TOTAL:",
				Font = Enum.Font.Bangers,
				LineHeight = 0.95,
				TextScaled = true,
				TextColor3 = Color3.new(255/255, 255/255, 255/255),
				TextXAlignment = Enum.TextXAlignment.Right,
				TextYAlignment = Enum.TextYAlignment.Center
			})
		})
	}
	local priceFrameProps = {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(0.5 - 0.5 / paddingRatio - 1 / paddingRatio, 0, 0.6, 0),
		Position = UDim2.new(0.5 + 0.5 / paddingRatio, 0, 0.2, 0)
	}
	local priceFrameChildren = {}
	local priceTextProps = {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0),
		Position = UDim2.new(0, 0, 0, 0),
		AnchorPoint = Vector2.new(0, 0)
	}
	priceTextProps.Text = if sum > 0 then "-" else "" .. "$" .. String.comma(sum)
	priceTextProps.Font = Enum.Font.Bangers
	priceTextProps.LineHeight = 0.95
	priceTextProps.TextScaled = true
	priceTextProps.TextColor3 = sum > 0 and Color3.new(255/255, 0/255, 0/255) or Color3.fromRGB(134, 195, 81)
	priceTextProps.TextXAlignment = Enum.TextXAlignment.Left
	priceTextProps.TextYAlignment = Enum.TextYAlignment.Center
	priceFrameChildren.Title = createElement("TextLabel", priceTextProps)
	bottomFrameChildren.Price = createElement("Frame", priceFrameProps, priceFrameChildren)
	mainFrameChildren.Bottom = createElement("Frame", bottomFrameProps, bottomFrameChildren)
	return createElement("Frame", mainFrameProps, mainFrameChildren)
end
return RoactRodux.connect(function(store, prevState)  end, function(dispatch)
	return {
		onRequestRemove = function(removedItem)
			dispatch({
				type = "removeReceiptItem",
				name = removedItem.name,
				category = removedItem.category
			})
		end
	}
end)(Receipt)
