-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local PaddedContainer = require(ReplicatedStorage.EzUi.PaddedContainer)
local v1 = Roact.PureComponent:extend("TradeChat")
v1.defaultProps = {
	size = UDim2.new(1, 0, 1, 0),
	position = UDim2.new(0, 0, 0, 0),
	aspectRatio = 1,
	verticalPaddingRatio = 128
}
function v1.init(p1)
	p1.maid = Maid.new()
end
function v1.render(p1)
	local aspectRatio = p1.props.aspectRatio
	local verticalPaddingRatio = p1.props.verticalPaddingRatio
	local t = {
		ListLayout = createElement("UIListLayout", {
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			VerticalAlignment = Enum.VerticalAlignment.Top,
			SortOrder = Enum.SortOrder.LayoutOrder,
			FillDirection = Enum.FillDirection.Vertical,
			Padding = UDim.new(1 / verticalPaddingRatio, 0)
		})
	}
	if p1.props.messages then
		for v2, v3 in p1.props.messages do
			local v1
			local color = v3.color
			if not color then
				v1 = if v3.me then Color3.new(255/255, 255/255, 255/255) else Color3.new(0.75, 0.75, 0.75) or Color3.new(255/255, 255/255, 255/255)
				color = v1
			end
			t[v3] = createElement("TextLabel", {
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Size = UDim2.new(1, 0, 0, 0),
				AutomaticSize = Enum.AutomaticSize.Y,
				RichText = true,
				Text = v3.displayName .. ": " .. v3.text,
				LayoutOrder = v2,
				Font = Enum.Font.SourceSansBold,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextColor3 = color,
				TextSize = 15,
				TextWrapped = true
			})
		end
	end
	return createElement("Frame", {
		BackgroundTransparency = 0.8,
		BackgroundColor3 = Color3.new(0/255, 0/255, 0/255),
		Size = p1.props.size,
		Position = p1.props.position
	}, {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		}),
		Title = createElement(PaddedContainer, {
			size = UDim2.new(1, 0, 0.1, 0),
			backgroundColor = Color3.new(51/255, 51/255, 51/255),
			backgroundTransparency = 0,
			aspectRatio = aspectRatio,
			verticalPaddingRatio = verticalPaddingRatio,
			paddingBottom = 0.5
		}, {
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(0, 4)
			}),
			Text = createElement("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 1, 0),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Text = "TRADE CHAT",
				TextXAlignment = Enum.TextXAlignment.Center,
				Font = Enum.Font.Bangers,
				LineHeight = 1,
				TextScaled = true,
				TextColor3 = Color3.new(255/255, 255/255, 255/255)
			})
		}),
		Inner = createElement(PaddedContainer, {
			size = UDim2.new(1, 0, 0.9, 0),
			position = UDim2.new(0, 0, 0.1, 0),
			backgroundColor = Color3.new(51/255, 51/255, 51/255),
			backgroundTransparency = 0,
			aspectRatio = aspectRatio,
			verticalPaddingRatio = verticalPaddingRatio,
			paddingTop = 0.5
		}, {
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(0, 4)
			}),
			Messages = createElement(PaddedContainer, {
				backgroundTransparency = 1
			}, {
				ScrollingFrame = createElement("ScrollingFrame", {
					BackgroundTransparency = 1,
					BackgroundColor3 = Color3.new(255/255, 255/255, 255/255),
					BorderSizePixel = 0,
					ScrollBarThickness = 4,
					ScrollBarImageColor3 = Color3.new(255/255, 255/255, 255/255),
					Size = UDim2.new(1, 0, 1, 0),
					CanvasSize = UDim2.new(0, 0, 0, 0),
					AutomaticCanvasSize = Enum.AutomaticSize.Y,
					ElasticBehavior = Enum.ElasticBehavior.Always,
					VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right,
					VerticalScrollBarInset = Enum.ScrollBarInset.None
				}, t)
			})
		})
	})
end
return v1
