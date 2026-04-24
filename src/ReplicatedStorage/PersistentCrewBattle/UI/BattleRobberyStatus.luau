-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ColorUtils = require(ReplicatedStorage.Std.ColorUtils)
local RobberyConsts = require(ReplicatedStorage.Robbery.RobberyConsts)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local identityColor = Color3.fromRGB(127, 249, 82)
local local2 = Roact.PureComponent:extend("BattleRobberyStatus")
function local2.render(self)
	local rowIndex = self.props.rowIndex
	local t = {
		BorderSizePixel = 0
	}
	t.BackgroundColor3 = if self.props.robberyCompleted then ColorUtils.brightenBy(identityColor, -0.1) else self.props.backgroundColor
	t.Size = UDim2.new(1, 0, 0.6666666666666666, 0)
	t.AnchorPoint = Vector2.new(0, 0)
	t.Position = UDim2.new(0, 0, 0.6666666666666666 * (rowIndex - 1) + 1, 2.6666666666666665 * rowIndex)
	local table2 = {
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
				Text = RobberyConsts.PRETTY_NAME[self.props.robberyType],
				LineHeight = 1,
				TextScaled = true,
				TextColor3 = ColorUtils.brightenBy(self.props.backgroundColor, -0.75)
			})
		})
	}
	local table3 = {
		BackgroundTransparency = 1,
		Size = UDim2.new(0.2, 0, 1, 0),
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, 0, 0, 0)
	}
	local table4 = {}
	local table5 = {}
	table5.BackgroundColor3 = if self.props.robberyCompleted then identityColor else ColorUtils.brightenBy(self.props.backgroundColor, -0.8)
	table5.BackgroundTransparency = 0
	table5.Size = UDim2.fromScale(0.75, 0.75)
	table5.AnchorPoint = Vector2.new(0.5, 0.5)
	table5.Position = UDim2.fromScale(0.5, 0.5)
	table4.Status = createElement("Frame", table5, {
		UICorners = createElement("UICorner", {
			CornerRadius = UDim.new(1, 0)
		}),
		AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = 3
		})
	})
	table2.StatusContainer = createElement("Frame", table3, table4)
	return createElement("Frame", t, table2)
end
return local2
