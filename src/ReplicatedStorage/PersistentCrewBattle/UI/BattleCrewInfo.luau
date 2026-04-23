local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local Dictionary = require(ReplicatedStorage.Std.Dictionary)
local ColorUtils = require(ReplicatedStorage.Std.ColorUtils)
local createElement = Roact.createElement
local Elapsed = require(script.Parent.Elapsed)
local BattleRobberyStatus = require(script.Parent.BattleRobberyStatus)
local PersistentCrewBattleConsts = require(ReplicatedStorage.PersistentCrewBattle.PersistentCrewBattleConsts)
local v1 = Roact.PureComponent:extend("BattleCrewInfo")
v1.defaultProps = {
	backgroundColor = Color3.new(0/255, 0/255, 0/255),
	size = UDim2.fromScale(0.5, 0.5),
	anchorPoint = Vector2.new(0.5, 0.5),
	position = UDim2.fromScale(0.5, 0.5),
	attacking = false
}
function v1.render(p1) --[[ Line: 19 | Upvalues: ColorUtils (copy), createElement (copy), BattleRobberyStatus (copy), Dictionary (copy), Roact (copy), Elapsed (copy), PersistentCrewBattleConsts (copy) ]]
	local v1 = ColorUtils.saturateBy(p1.props.backgroundColor, -0.9)
	local count = 0
	local t = {}
	for v2, v3 in p1.props.robberiesCompleted do
		if v3.robberyCompleted then
			count = count + 1
		end
		t["Robbery_" .. tostring(v3.robberyType)] = createElement(BattleRobberyStatus, {
			rowIndex = v2,
			robberyType = v3.robberyType,
			robberyCompleted = v3.robberyCompleted,
			backgroundColor = v1
		})
	end
	local t3 = {
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
				Text = p1.props.clanName,
				LineHeight = 1,
				TextScaled = true,
				TextColor3 = ColorUtils.brightenBy(p1.props.backgroundColor, -0.5)
			})
		})
	}
	t3.TakenContainer = p1.props.attacking and createElement("Frame", {
		BorderSizePixel = 0,
		BackgroundColor3 = p1.props.backgroundColor,
		Size = UDim2.new(0.5, -2, 0.8, 0),
		AnchorPoint = Vector2.new(0, 0),
		Position = UDim2.new(0, 0, 1, 4)
	}, {
		UICorners = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		}),
		ElapsedContainer = createElement(Elapsed, {
			font = Enum.Font.FredokaOne,
			textColor = ColorUtils.brightenBy(p1.props.backgroundColor, -0.5),
			createdAt = p1.props.createdAt,
			elapsed = p1.props.elapsed,
			disabled = p1.props.disabled,
			prefix = "Time Taken: "
		})
	})
	t3.RobberyList = p1.props.attacking and createElement("Frame", {
		BorderSizePixel = 0,
		BackgroundColor3 = p1.props.backgroundColor,
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
				TextColor3 = ColorUtils.brightenBy(p1.props.backgroundColor, -0.5)
			})
		})
	}, t))
	t3.BeatContainer = not p1.props.attacking and createElement("Frame", {
		BorderSizePixel = 0,
		BackgroundColor3 = p1.props.backgroundColor,
		Size = UDim2.new(0.5, -2, 0.8, 0),
		AnchorPoint = Vector2.new(0, 0),
		Position = UDim2.new(0, 0, 1, 4)
	}, {
		UICorners = createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		}),
		ElapsedContainer = createElement(Elapsed, {
			font = Enum.Font.FredokaOne,
			textColor = ColorUtils.brightenBy(p1.props.backgroundColor, -0.5),
			createdAt = p1.props.createdAt,
			elapsed = p1.props.elapsed,
			disabled = p1.props.disabled,
			prefix = "Time Taken: "
		})
	})
	t3.Help = not p1.props.attacking and createElement("Frame", {
		BorderSizePixel = 0,
		BackgroundColor3 = p1.props.backgroundColor,
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
				TextColor3 = ColorUtils.brightenBy(p1.props.backgroundColor, -0.5)
			})
		})
	})
	return createElement("Frame", {
		BorderSizePixel = 0,
		BackgroundColor3 = p1.props.backgroundColor,
		Size = p1.props.size,
		AnchorPoint = p1.props.anchorPoint,
		Position = p1.props.position
	}, Dictionary.merge(p1.props[Roact.Children], t3))
end
return v1