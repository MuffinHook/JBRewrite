local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerDataConsts = require(ReplicatedStorage.PlayerData.PlayerDataConsts)
local Dictionary = require(ReplicatedStorage.EzUi.Dictionary)
local ColorUtils = require(ReplicatedStorage.Std.ColorUtils)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local v1 = Roact.PureComponent:extend("TradeCategory")
v1.defaultProps = {
	size = UDim2.new(1, 0, 1, 0),
	position = UDim2.new(0, 0, 0, 0),
	cornerPixel = 8,
	selected = false
}
function v1.init(p1) --[[ Line: 15 ]]
	p1:setState({
		hover = false
	})
end
function v1.render(p1) --[[ Line: 20 | Upvalues: PlayerDataConsts (copy), ColorUtils (copy), createElement (copy), Roact (copy), Dictionary (copy) ]]
	local v1 = if p1.props.itemType == PlayerDataConsts.VEHICLE_CUSTOMIZATION_ITEM_TYPE then Color3.fromRGB(122, 212, 255) elseif p1.props.itemType == PlayerDataConsts.VEHICLE_ITEM_TYPE then Color3.fromRGB(255, 90, 82) elseif p1.props.itemType == PlayerDataConsts.HOME_ITEM_ITEM_TYPE then Color3.fromRGB(255, 213, 122) elseif p1.props.itemType == PlayerDataConsts.ITEM_SKIN_ITEM_TYPE then Color3.fromRGB(167, 131, 255) elseif p1.props.itemType == PlayerDataConsts.SAFE_ITEM_TYPE then Color3.fromRGB(255, 126, 191) else Color3.new(204/255, 204/255, 204/255)
	if not p1.props.selected and p1.state.hover then
		v1 = ColorUtils.brightenBy(v1, -0.2)
	end
	local aspectRatio = p1.props.aspectRatio
	return createElement("TextButton", {
		BackgroundTransparency = 0,
		AutoButtonColor = false,
		BorderSizePixel = 0,
		Size = p1.props.size,
		Position = p1.props.position,
		BackgroundColor3 = v1,
		Text = "",
		[Roact.Event.MouseEnter] = function() --[[ Line: 55 | Upvalues: p1 (copy) ]]
			p1:setState({
				hover = true
			})
		end,
		[Roact.Event.MouseLeave] = function() --[[ Line: 60 | Upvalues: p1 (copy) ]]
			p1:setState({
				hover = false
			})
		end,
		[Roact.Event.SelectionGained] = function() --[[ Line: 65 | Upvalues: p1 (copy) ]]
			p1:setState({
				hover = true
			})
		end,
		[Roact.Event.SelectionLost] = function() --[[ Line: 70 | Upvalues: p1 (copy) ]]
			p1:setState({
				hover = false
			})
		end,
		[Roact.Event.Activated] = p1.props.onClick
	}, Dictionary.merge({
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, p1.props.cornerPixel)
		}),
		UIStroke = createElement("UIStroke", {
			Color = ColorUtils.saturateTo(v1, 0.3),
			Thickness = 2,
			Enabled = p1.props.selected,
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
				TextColor3 = ColorUtils.brightenBy(v1, -0.8),
				Text = p1.props.title,
				TextXAlignment = Enum.TextXAlignment.Center,
				Font = Enum.Font.Bangers,
				LineHeight = 1,
				TextScaled = true
			})
		})
	}, {}))
end
return v1