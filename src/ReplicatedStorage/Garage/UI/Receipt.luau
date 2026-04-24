-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local String = require(ReplicatedStorage.Std.String)
local Dictionary = require(ReplicatedStorage.EzUi.Dictionary)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local ReceiptItem = require(script.Parent.ReceiptItem)
local v1 = Roact.PureComponent:extend("Receipt")
v1.defaultProps = {
	showTotal = true
}
function v1.init(p1)  end
function v1.render(p1)
	local mainRatio = p1.props.mainRatio
	local cornerPixel = p1.props.cornerPixel
	local paddingRatio = p1.props.paddingRatio
	local v1 = p1.props.paddingRatio * 2
	local v2 = p1.props.showTotal and 1 / (1 / mainRatio - 0.2222222222222222) or mainRatio
	local sum = 0
	local t = {}
	local count = 0
	for i = 1, #p1.props.receipt do
		local v3
		local v4 = p1.props.receipt[i]
		local v5 = v4.price or 0
		v3 = not (p1.props.owned[v4.category] and p1.props.owned[v4.category][v4.name])
		if v4.limited then
			v3 = false
		end
		if v3 then
			table.insert(t, (createElement(ReceiptItem, Dictionary.merge({
				layoutOrder = i * 2,
				mainRatio = 1 / (1 / (v2 * 6) - 1 / v1 + 1 / v1 / 6),
				paddingRatio = paddingRatio,
				cornerPixel = cornerPixel,
				onRequestRemove = function()
					p1.props.onRequestRemove(v4)
				end
			}, v4))))
			table.insert(t, (createElement("Frame", {
				BorderSizePixel = 0,
				BackgroundTransparency = 0,
				BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
				Size = UDim2.new(1, 0, 1, 0),
				LayoutOrder = i * 2 + 1
			}, {
				AspectRatio = createElement("UIAspectRatioConstraint", {
					AspectRatio = v1
				})
			})))
			sum = sum + v5
			count = count + 1
		end
	end
	local t2 = {
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		BackgroundColor3 = Color3.new(0.1, 0.1, 0.1),
		Size = UDim2.new(1, 0, 1, 0),
		LayoutOrder = p1.props.layoutOrder
	}
	local t3 = {
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
			CanvasSize = UDim2.new(0, 0, ((1 + mainRatio / v1) * count / 6 - mainRatio / v1) * mainRatio / v2, 0),
			Size = UDim2.new(1, 0, mainRatio / v2, 0),
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
		}, t))
	}
	local t4 = {
		BackgroundTransparency = 0.6,
		BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, mainRatio / 4.5, 0),
		Position = UDim2.new(0, 0, 1 - mainRatio / 4.5, 0),
		Visible = p1.props.showTotal
	}
	local t5 = {
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
	local t6 = {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(0.5 - 0.5 / paddingRatio - 1 / paddingRatio, 0, 0.6, 0),
		Position = UDim2.new(0.5 + 0.5 / paddingRatio, 0, 0.2, 0)
	}
	local t7 = {}
	local t8 = {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0),
		Position = UDim2.new(0, 0, 0, 0),
		AnchorPoint = Vector2.new(0, 0)
	}
	t8.Text = if sum > 0 then "-" else "" .. "$" .. String.comma(sum)
	t8.Font = Enum.Font.Bangers
	t8.LineHeight = 0.95
	t8.TextScaled = true
	t8.TextColor3 = sum > 0 and Color3.new(255/255, 0/255, 0/255) or Color3.fromRGB(134, 195, 81)
	t8.TextXAlignment = Enum.TextXAlignment.Left
	t8.TextYAlignment = Enum.TextYAlignment.Center
	t7.Title = createElement("TextLabel", t8)
	t5.Price = createElement("Frame", t6, t7)
	t3.Bottom = createElement("Frame", t4, t5)
	return createElement("Frame", t2, t3)
end
return RoactRodux.connect(function(p1, p2)  end, function(p1)
	return {
		onRequestRemove = function(p12)
			p1({
				type = "removeReceiptItem",
				name = p12.name,
				category = p12.category
			})
		end
	}
end)(v1)
