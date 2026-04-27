local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Maid = require(ReplicatedStorage.Std.Maid)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local PaddedContainer = require(ReplicatedStorage.EzUi.PaddedContainer)
local TradeChat = Roact.PureComponent:extend("TradeChat")
TradeChat.defaultProps = {
	size = UDim2.new(1, 0, 1, 0),
	position = UDim2.new(0, 0, 0, 0),
	aspectRatio = 1,
	verticalPaddingRatio = 128
}
function TradeChat.init(self)
	self.maid = Maid.new()
end
function TradeChat.render(self)
	local aspectRatio = self.props.aspectRatio
	local verticalPaddingRatio = self.props.verticalPaddingRatio
	local children = {
		ListLayout = createElement("UIListLayout", {
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			VerticalAlignment = Enum.VerticalAlignment.Top,
			SortOrder = Enum.SortOrder.LayoutOrder,
			FillDirection = Enum.FillDirection.Vertical,
			Padding = UDim.new(1 / verticalPaddingRatio, 0)
		})
	}
	if self.props.messages then
		for messageIndex, message in self.props.messages do
			local messageColor
			local color = message.color
			if not color then
				messageColor = if message.me then Color3.new(255/255, 255/255, 255/255) else Color3.new(0.75, 0.75, 0.75) or Color3.new(255/255, 255/255, 255/255)
				color = messageColor
			end
			children[message] = createElement("TextLabel", {
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Size = UDim2.new(1, 0, 0, 0),
				AutomaticSize = Enum.AutomaticSize.Y,
				RichText = true,
				Text = message.displayName .. ": " .. message.text,
				LayoutOrder = messageIndex,
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
		Size = self.props.size,
		Position = self.props.position
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
				}, children)
			})
		})
	})
end
return TradeChat
