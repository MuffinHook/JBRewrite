local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.RoactRodux)
require(ReplicatedStorage.EzUi.Dictionary)
local Maid = require(ReplicatedStorage.Std.Maid)
local Interval = require(ReplicatedStorage.Std.Interval)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local RoundButton = require(script.Parent.RoundButton)
local LiteComponent = Roact.PureComponent:extend("Lite")
function LiteComponent.init(self)
	self.maid = Maid.new()
	self:setState({
		remaining = 0
	})
end
function LiteComponent.render(self)
	local mainRatio = self.props.mainRatio
	local paddingRatio = self.props.paddingRatio
	local cornerPixel = self.props.cornerPixel
	local shouldShowUpgradePrompt = not self.props.upgraded and not self.props.inPhysical
	local remainingCooldown = math.max(self.state.remaining, 0)
	local cooldownText = remainingCooldown >= 1 and ("%d:%02d COOLDOWN"):format(math.floor(remainingCooldown / 60), remainingCooldown % 60) or "READY"
	local frameProps = {
		BorderSizePixel = 0,
		BackgroundTransparency = 0,
		BackgroundColor3 = Color3.fromRGB(55, 83, 255),
		Size = UDim2.new(1, 0, 1, 0),
		LayoutOrder = self.props.layoutOrder
	}
	local frameChildren = {
		AspectRatio = createElement("UIAspectRatioConstraint", {
			AspectRatio = mainRatio
		}),
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(0, cornerPixel)
		}),
		UIStroke = createElement("UIStroke", {
			Color = Color3.new(255/255, 255/255, 255/255),
			Thickness = 1,
			Enabled = self.props.active
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
				Text = cooldownText,
				Font = Enum.Font.Bangers,
				LineHeight = 0.95,
				TextScaled = true,
				TextColor3 = Color3.new(255/255, 255/255, 255/255),
				TextXAlignment = Enum.TextXAlignment.Center,
				TextYAlignment = Enum.TextYAlignment.Center
			})
		})
	}
	frameChildren.Message = shouldShowUpgradePrompt and createElement("TextLabel", {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		TextColor3 = Color3.new(255/255, 255/255, 255/255),
		Size = UDim2.new(1 - 2 / paddingRatio, 0, 0.8 - 2 * mainRatio / paddingRatio - 0.15 - 2 * mainRatio / paddingRatio - mainRatio / paddingRatio, 0),
		Position = UDim2.new(1 / paddingRatio, 0, 0.15 + 2 * mainRatio / paddingRatio, 0),
		Text = "Upgrade to the Pro Garage to spawn and customize anything on the go!",
		TextScaled = true,
		Font = Enum.Font.LuckiestGuy
	})
	frameChildren.Lock = shouldShowUpgradePrompt and createElement("ImageLabel", {
		BorderSizePixel = 0,
		BackgroundTransparency = 1,
		Size = UDim2.new(0.1 / mainRatio, 0, 0.1, 0),
		AnchorPoint = Vector2.new(0.5, 0),
		Position = UDim2.new(0.5, 0, 0.8 - 2 * mainRatio / paddingRatio, 0),
		Image = "rbxassetid://8715708824"
	})
	frameChildren.Upgrade = shouldShowUpgradePrompt and createElement(RoundButton, {
		color = Color3.fromRGB(21, 33, 99),
		layoutOrder = 1,
		title = "UPGRADE",
		size = UDim2.new(1 - 2 / paddingRatio, 0, 0.1, 0),
		position = UDim2.new(1 / paddingRatio, 0, 0.9 - mainRatio / paddingRatio, 0),
		onClick = self.props.onRequestPremiumUpgrade
	})
	return createElement("Frame", frameProps, frameChildren)
end
function LiteComponent.didMount(self)
	self:setState({
		remaining = self.props.getRemainingDebounce()
	})
	self.maid:GiveTask(Interval.every(1):Connect(function()
		self:setState({
			remaining = self.props.getRemainingDebounce()
		})
	end))
end
function LiteComponent.willUnmount(self)
	self.maid:DoCleaning()
end
return LiteComponent
