-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local Dictionary = require(ReplicatedStorage.Std.Dictionary)
local ColorUtils = require(ReplicatedStorage.Std.ColorUtils)
local createElement = Roact.createElement
local Elapsed = require(script.Parent.Elapsed)
local BattleRobberyStatus = require(script.Parent.BattleRobberyStatus)
local PersistentCrewBattleConsts = require(ReplicatedStorage.PersistentCrewBattle.PersistentCrewBattleConsts)
local local1 = Roact.PureComponent:extend("BattleCrewInfo")
local1.defaultProps = {
	backgroundColor = Color3.new(0/255, 0/255, 0/255),
	size = UDim2.fromScale(0.5, 0.5),
	anchorPoint = Vector2.new(0.5, 0.5),
	position = UDim2.fromScale(0.5, 0.5),
	attacking = false
}
function local1.render(self)
	local local1 = ColorUtils.saturateBy(self.props.backgroundColor, -0.9)
	local count = 0
	local t = {}
	for local2, local3 in self.props.robberiesCompleted do
		if local3.robberyCompleted then
			count = count + 1
		end
		t["Robbery_" .. tostring(local3.robberyType)] = createElement(BattleRobberyStatus, {
			rowIndex = local2,
			robberyType = local3.robberyType,
			robberyCompleted = local3.robberyCompleted,
			backgroundColor = local1
		})
	end
	local table3 = {
		UICorners = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		}),
		TitleContainer = createElement("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0)
		}, {
			Text = createElement("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 1, 0),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Font = Enum.Font.Bangers,
				Text = self.props.clanName,
				LineHeight = 1,
				TextScaled = true,
				TextColor3 = ColorUtils.brightenBy(self.props.backgroundColor, -0.5)
			})
		})
	}
	table3.TakenContainer = self.props.attacking and createElement("Frame", {
		BorderSizePixel = 0,
		BackgroundColor3 = self.props.backgroundColor,
		Size = UDim2.new(0.5, -2, 0.8, 0),
		AnchorPoint = Vector2.new(0, 0),
		Position = UDim2.new(0, 0, 1, 4)
	}, {
		UICorners = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		}),
		ElapsedContainer = createElement(Elapsed, {
			font = Enum.Font.FredokaOne,
			textColor = ColorUtils.brightenBy(self.props.backgroundColor, -0.5),
			createdAt = self.props.createdAt,
			elapsed = self.props.elapsed,
			disabled = self.props.disabled,
			prefix = "Time Taken: "
		})
	})
	table3.RobberyList = self.props.attacking and createElement("Frame", {
		BorderSizePixel = 0,
		BackgroundColor3 = self.props.backgroundColor,
		Size = UDim2.new(0.5, -2, 0.8, 0),
		AnchorPoint = Vector2.new(0, 0),
		Position = UDim2.new(0.5, 2, 1, 4)
	}, Dictionary.merge({
		UICorners = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		}),
		TitleContainer = createElement("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0)
		}, {
			Text = createElement("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.new(0.9, 0, 0.8, 0),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Font = Enum.Font.FredokaOne,
				Text = ("Checklist (%d/%d)"):format(count, PersistentCrewBattleConsts.NUM_ROBBERIES_TO_FINISH_ROUND),
				LineHeight = 1,
				TextScaled = true,
				TextColor3 = ColorUtils.brightenBy(self.props.backgroundColor, -0.5)
			})
		})
	}, t))
	table3.BeatContainer = not self.props.attacking and createElement("Frame", {
		BorderSizePixel = 0,
		BackgroundColor3 = self.props.backgroundColor,
		Size = UDim2.new(0.5, -2, 0.8, 0),
		AnchorPoint = Vector2.new(0, 0),
		Position = UDim2.new(0, 0, 1, 4)
	}, {
		UICorners = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		}),
		ElapsedContainer = createElement(Elapsed, {
			font = Enum.Font.FredokaOne,
			textColor = ColorUtils.brightenBy(self.props.backgroundColor, -0.5),
			createdAt = self.props.createdAt,
			elapsed = self.props.elapsed,
			disabled = self.props.disabled,
			prefix = "Time Taken: "
		})
	})
	table3.Help = not self.props.attacking and createElement("Frame", {
		BorderSizePixel = 0,
		BackgroundColor3 = self.props.backgroundColor,
		Size = UDim2.new(0.5, -2, 0.8, 0),
		AnchorPoint = Vector2.new(0, 0),
		Position = UDim2.new(0.5, 2, 1, 4)
	}, {
		UICorners = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		}),
		TitleContainer = createElement("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0)
		}, {
			Text = createElement("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.new(0.9, 0, 0.8, 0),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Font = Enum.Font.FredokaOne,
				Text = "Beat their time!",
				LineHeight = 1,
				TextScaled = true,
				TextColor3 = ColorUtils.brightenBy(self.props.backgroundColor, -0.5)
			})
		})
	})
	return createElement("Frame", {
		BorderSizePixel = 0,
		BackgroundColor3 = self.props.backgroundColor,
		Size = self.props.size,
		AnchorPoint = self.props.anchorPoint,
		Position = self.props.position
	}, Dictionary.merge(self.props[Roact.Children], table3))
end
return local1
