local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.RoactRodux)
require(ReplicatedStorage.EzUi.Dictionary)
local Maid = require(ReplicatedStorage.Std.Maid)
local Interval = require(ReplicatedStorage.Std.Interval)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local RoundButton = require(script.Parent.RoundButton)
local v1 = Roact.PureComponent:extend("Lite")
function v1.init(p1) --[[ Line: 12 | Upvalues: Maid (copy) ]]
	p1.maid = Maid.new()
	p1:setState({
		remaining = 0
	})
end
function v1.render(p1) --[[ Line: 18 | Upvalues: createElement (copy), RoundButton (copy) ]]
	local mainRatio = p1.props.mainRatio
	local paddingRatio = p1.props.paddingRatio
	local cornerPixel = p1.props.cornerPixel
	local v1 = not p1.props.upgraded and not p1.props.inPhysical
	local v2 = math.max(p1.state.remaining, 0)
	local v5 = v2 >= 1 and ("%d:%02d COOLDOWN"):format(math.floor(v2 / 60), v2 % 60) or "READY"
	local t = {
		BorderSizePixel = 0,
		BackgroundTransparency = 0,
		BackgroundColor3 = Color3.fromRGB(55, 83, 255),
		Size = UDim2.new(1, 0, 1, 0),
		LayoutOrder = p1.props.layoutOrder
	}
	local t2 = {
		AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = mainRatio
		}),
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, cornerPixel)
		}),
		UIStroke = createElement("UIStroke", {
			Color = Color3.new(255/255, 255/255, 255/255),
			Thickness = 1,
			Enabled = p1.props.active
		}),
		Cooldown = createElement("Frame", {
			BackgroundTransparency = 0,
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.fromRGB(32, 55, 158),
			Size = UDim2.new(1 - 2 / paddingRatio, 0, 0.15, 0),
			Position = UDim2.new(1 / paddingRatio, 0, mainRatio / paddingRatio, 0)
		}, {
			UICorner = createElement("UICorner", {
				CornerRadius = UDim.new(0, cornerPixel)
			}),
			Title = createElement("TextLabel", {
				BackgroundTransparency = 1,
				Size = UDim2.new(0.9, 0, 1, 0),
				Position = UDim2.new(0.05, 0, 0, 0),
				AnchorPoint = Vector2.new(0, 0),
				Text = v5,
				Font = Enum.Font.Bangers,
				LineHeight = 0.95,
				TextScaled = true,
				TextColor3 = Color3.new(255/255, 255/255, 255/255),
				TextXAlignment = Enum.TextXAlignment.Center,
				TextYAlignment = Enum.TextYAlignment.Center
			})
		})
	}
	t2.Message = v1 and createElement("TextLabel", {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		TextColor3 = Color3.new(255/255, 255/255, 255/255),
		Size = UDim2.new(1 - 2 / paddingRatio, 0, 0.8 - 2 * mainRatio / paddingRatio - 0.15 - 2 * mainRatio / paddingRatio - mainRatio / paddingRatio, 0),
		Position = UDim2.new(1 / paddingRatio, 0, 0.15 + 2 * mainRatio / paddingRatio, 0),
		Text = "Upgrade to the Pro Garage to spawn and customize anything on the go!",
		TextScaled = true,
		Font = Enum.Font.LuckiestGuy
	})
	t2.Lock = v1 and createElement("ImageLabel", {
		BorderSizePixel = 0,
		BackgroundTransparency = 1,
		Size = UDim2.new(0.1 / mainRatio, 0, 0.1, 0),
		AnchorPoint = Vector2.new(0.5, 0),
		Position = UDim2.new(0.5, 0, 0.8 - 2 * mainRatio / paddingRatio, 0),
		Image = "rbxassetid://8715708824"
	})
	t2.Upgrade = v1 and createElement(RoundButton, {
		color = Color3.fromRGB(21, 33, 99),
		layoutOrder = 1,
		title = "UPGRADE",
		size = UDim2.new(1 - 2 / paddingRatio, 0, 0.1, 0),
		position = UDim2.new(1 / paddingRatio, 0, 0.9 - mainRatio / paddingRatio, 0),
		onClick = p1.props.onRequestPremiumUpgrade
	})
	return createElement("Frame", t, t2)
end
function v1.didMount(p1) --[[ Line: 117 | Upvalues: Interval (copy) ]]
	p1:setState({
		remaining = p1.props.getRemainingDebounce()
	})
	p1.maid:GiveTask(Interval.every(1):Connect(function() --[[ Line: 121 | Upvalues: p1 (copy) ]]
		p1:setState({
			remaining = p1.props.getRemainingDebounce()
		})
	end))
end
function v1.willUnmount(p1) --[[ Line: 127 ]]
	p1.maid:DoCleaning()
end
return v1