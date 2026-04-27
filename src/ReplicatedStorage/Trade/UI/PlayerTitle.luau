local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Spring = require(ReplicatedStorage.Std.Spring)
local Maid = require(ReplicatedStorage.Std.Maid)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local PlayerTitle = Roact.PureComponent:extend("PlayerTitle")
PlayerTitle.defaultProps = {
	size = UDim2.new(1, 0, 1, 0),
	position = UDim2.new(0, 0, 0, 0),
	aspectRatio = 1,
	parentRatio = 1
}
function PlayerTitle.init(self)
	self.maid = Maid.new()
	self.spinSpring = Spring.new(0, 0, 0.8, 15)
	self.scaleSpring = Spring.new(1, 0, 0.5, 40)
	local spinBinding, updateSpin = Roact.createBinding(0)
	self.spin = spinBinding
	self.updateSpin = updateSpin
	local scaleBinding, updateScale = Roact.createBinding(1)
	self.scale = scaleBinding
	self.updateScale = updateScale
end
function PlayerTitle.render(self)
	local aspectRatio = self.props.aspectRatio
	assert(self.props.size.X.Offset == 0, "cannot support nonzero offset")
	assert(self.props.size.Y.Offset == 0, "cannot support nonzero offset")
	local frameProps = {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(self.props.size.X.Scale, 0, self.props.size.Y.Scale * (self.props.parentRatio * (self.props.size.X.Scale / self.props.size.Y.Scale)) * 1 / aspectRatio, 0),
		Position = self.props.position
	}
	local frameChildren = {}
	local iconProps = {
		BorderSizePixel = 0,
		BackgroundTransparency = 1,
		BackgroundColor3 = Color3.new(0.1, 0.1, 0.1),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5 / aspectRatio, 0, 0.5, 0),
		Size = self.scale:map(function(scaleValue)
			return UDim2.new(scaleValue / aspectRatio, 0, scaleValue, 0)
		end)
	}
	iconProps.Image = if self.props.ready then "rbxassetid://9474441364" else self.props.userId and ("rbxthumb://type=AvatarHeadShot&w=150&h=150&id=%d"):format(self.props.userId)
	iconProps.Rotation = self.spin
	frameChildren.Icon = createElement("ImageLabel", iconProps, {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(1, 0)
		})
	})
	local titleFrameProps = {
		BackgroundTransparency = 1,
		BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
		Size = UDim2.new(1 - 1 / aspectRatio - 0.0078125, 0, 1, 0),
		Position = UDim2.new(1 / aspectRatio + 0.0078125, 0, 0, 0)
	}
	local titleFrameChildren = {}
	local textLabelProps = {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5)
	}
	textLabelProps.TextColor3 = self.props.ready and Color3.fromRGB(0, 200, 90) or Color3.new(255/255, 255/255, 255/255)
	textLabelProps.Text = self.props.displayName
	textLabelProps.TextXAlignment = Enum.TextXAlignment.Left
	textLabelProps.Font = Enum.Font.Bangers
	textLabelProps.LineHeight = 1
	textLabelProps.TextScaled = true
	titleFrameChildren.Text = createElement("TextLabel", textLabelProps)
	frameChildren.Title = createElement("Frame", titleFrameProps, titleFrameChildren)
	return createElement("Frame", frameProps, frameChildren)
end
function PlayerTitle.PopIcon(self)
	self.scaleSpring:Accelerate(15)
	local Target = self.scaleSpring.Target
	self.maid.scaleHeartbeat = RunService.Heartbeat:Connect(function()
		local scalePosition, scaleVelocity = self.scaleSpring:Update()
		if math.abs(Target - scalePosition) < 0.001 and math.abs(scaleVelocity) < 0.001 then
			self.maid.scaleHeartbeat = nil
			scalePosition = Target
		end
		self.updateScale(scalePosition)
	end)
end
function PlayerTitle.SpinIcon(self)
	self.spinSpring:SetTarget(360)
	self.spinSpring.p = 0
	self.maid.spinHeartbeat = RunService.Heartbeat:Connect(function()
		local spinPosition, spinVelocity = self.spinSpring:Update()
		if math.abs(360 - spinPosition) < 0.001 and math.abs(spinVelocity) < 0.001 then
			self.maid.spinHeartbeat = nil
			spinPosition = 0
		end
		self.updateSpin(spinPosition)
	end)
end
function PlayerTitle.didUpdate(self, oldProps, oldState)
	if self.props.ready ~= oldProps.ready and self.props.ready then
		self:SpinIcon()
		self:PopIcon()
	end
end
return PlayerTitle
