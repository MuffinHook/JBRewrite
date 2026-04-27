local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerDataConsts = require(ReplicatedStorage.PlayerData.PlayerDataConsts)
local Dictionary = require(ReplicatedStorage.EzUi.Dictionary)
local ColorUtils = require(ReplicatedStorage.Std.ColorUtils)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local TradeCategory = Roact.PureComponent:extend("TradeCategory")
TradeCategory.defaultProps = {
	size = UDim2.new(1, 0, 1, 0),
	position = UDim2.new(0, 0, 0, 0),
	cornerPixel = 8,
	selected = false
}
function TradeCategory.init(self)
	self:setState({
		hover = false
	})
end
function TradeCategory.render(self)
	local buttonColor = if self.props.itemType == PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE then Color3.fromRGB(122, 212, 255) elseif self.props.itemType == PlayerDataConsts.VEHICLE_ITEM_TYPE then Color3.fromRGB(255, 90, 82) elseif self.props.itemType == PlayerDataConsts.HOME_ITEM_ITEM_TYPE then Color3.fromRGB(255, 213, 122) elseif self.props.itemType == PlayerDataConsts.ITEM_SKIN_ITEM_TYPE then Color3.fromRGB(167, 131, 255) elseif self.props.itemType == PlayerDataConsts.SAFE_ITEM_TYPE then Color3.fromRGB(255, 126, 191) else Color3.new(204/255, 204/255, 204/255)
	if not self.props.selected and self.state.hover then
		buttonColor = ColorUtils.brightenBy(buttonColor, -0.2)
	end
	local aspectRatio = self.props.aspectRatio
	return createElement("TextButton", {
		BackgroundTransparency = 0,
		AutoButtonColor = false,
		BorderSizePixel = 0,
		Size = self.props.size,
		Position = self.props.position,
		BackgroundColor3 = buttonColor,
		Text = "",
		[Roact.Event.MouseEnter] = function()
			self:setState({
				hover = true
			})
		end,
		[Roact.Event.MouseLeave] = function()
			self:setState({
				hover = false
			})
		end,
		[Roact.Event.SelectionGained] = function()
			self:setState({
				hover = true
			})
		end,
		[Roact.Event.SelectionLost] = function()
			self:setState({
				hover = false
			})
		end,
		[Roact.Event.Activated] = self.props.onClick
	}, Dictionary.merge({
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, self.props.cornerPixel)
		}),
		UIStroke = createElement("UIStroke", {
			Color = ColorUtils.saturateTo(buttonColor, 0.3),
			Thickness = 2,
			Enabled = self.props.selected,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		}),
		Title = createElement("Frame", {
			BackgroundTransparency = 1,
			BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
			Size = UDim2.new(0.9375, 0, 1 - 0.0625 * aspectRatio, 0),
			Position = UDim2.new(0.03125, 0, 0.03125 * aspectRatio, 0)
		}, {
			Text = createElement("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 1, 0),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				AnchorPoint = Vector2.new(0.5, 0.5),
				TextColor3 = ColorUtils.brightenBy(buttonColor, -0.8),
				Text = self.props.title,
				TextXAlignment = Enum.TextXAlignment.Center,
				Font = Enum.Font.Bangers,
				LineHeight = 1,
				TextScaled = true
			})
		})
	}, {}))
end
return TradeCategory
