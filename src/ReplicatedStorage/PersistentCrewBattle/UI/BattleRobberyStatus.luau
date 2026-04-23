local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ColorUtils = require(ReplicatedStorage.Std.ColorUtils)
local RobberyConsts = require(ReplicatedStorage.Robbery.RobberyConsts)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local v1 = Color3.fromRGB(127, 249, 82)
local v2 = Roact.PureComponent:extend("BattleRobberyStatus")
function v2.render(p1) --[[ Line: 10 | Upvalues: createElement (copy), ColorUtils (copy), v1 (copy), RobberyConsts (copy) ]]
	local rowIndex = p1.props.rowIndex
	local t = {
		BorderSizePixel = 0
	}
	t.BackgroundColor3 = if p1.props.robberyCompleted then ColorUtils.brightenBy(v1, -0.1) else p1.props.backgroundColor
	t.Size = UDim2.new(1, 0, 0.6666666666666666, 0)
	t.AnchorPoint = Vector2.new(0, 0)
	t.Position = UDim2.new(0, 0, 0.6666666666666666 * (rowIndex - 1) + 1, 2.6666666666666665 * rowIndex)
	local t2 = {
		UICorners = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		}),
		TitleContainer = createElement("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(0.8, 0, 1, 0)
		}, {
			Text = createElement("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.new(0.95, 0, 0.9, 0),
				Position = UDim2.new(1, 0, 0.5, 0),
				AnchorPoint = Vector2.new(1, 0.5),
				Font = Enum.Font.FredokaOne,
				TextXAlignment = Enum.TextXAlignment.Left,
				Text = RobberyConsts.PRETTY_NAME[p1.props.robberyType],
				LineHeight = 1,
				TextScaled = true,
				TextColor3 = ColorUtils.brightenBy(p1.props.backgroundColor, -0.75)
			})
		})
	}
	local t3 = {
		BackgroundTransparency = 1,
		Size = UDim2.new(0.2, 0, 1, 0),
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, 0, 0, 0)
	}
	local t4 = {}
	local t5 = {}
	t5.BackgroundColor3 = if p1.props.robberyCompleted then v1 else ColorUtils.brightenBy(p1.props.backgroundColor, -0.8)
	t5.BackgroundTransparency = 0
	t5.Size = UDim2.fromScale(0.75, 0.75)
	t5.AnchorPoint = Vector2.new(0.5, 0.5)
	t5.Position = UDim2.fromScale(0.5, 0.5)
	t4.Status = createElement("Frame", t5, {
		UICorners = createElement("UICorner", {
			CornerRadius = UDim.new(1, 0)
		}),
		AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = 3
		})
	})
	t2.StatusContainer = createElement("Frame", t3, t4)
	return createElement("Frame", t, t2)
end
return v2