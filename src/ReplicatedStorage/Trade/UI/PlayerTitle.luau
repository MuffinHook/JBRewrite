-- Reviewed by Claude
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Spring = require(ReplicatedStorage.Std.Spring)
local Maid = require(ReplicatedStorage.Std.Maid)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local v1 = Roact.PureComponent:extend("PlayerTitle")
v1.defaultProps = {
	size = UDim2.new(1, 0, 1, 0),
	position = UDim2.new(0, 0, 0, 0),
	aspectRatio = 1,
	parentRatio = 1
}
function v1.init(p1)
	p1.maid = Maid.new()
	p1.spinSpring = Spring.new(0, 0, 0.8, 15)
	p1.scaleSpring = Spring.new(1, 0, 0.5, 40)
	local v1, v2 = Roact.createBinding(0)
	p1.spin = v1
	p1.updateSpin = v2
	local v3, v4 = Roact.createBinding(1)
	p1.scale = v3
	p1.updateScale = v4
end
function v1.render(p1)
	local aspectRatio = p1.props.aspectRatio
	assert(p1.props.size.X.Offset == 0, "cannot support nonzero offset")
	assert(p1.props.size.Y.Offset == 0, "cannot support nonzero offset")
	local t = {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(p1.props.size.X.Scale, 0, p1.props.size.Y.Scale * (p1.props.parentRatio * (p1.props.size.X.Scale / p1.props.size.Y.Scale)) * 1 / aspectRatio, 0),
		Position = p1.props.position
	}
	local t2 = {}
	local t3 = {
		BorderSizePixel = 0,
		BackgroundTransparency = 1,
		BackgroundColor3 = Color3.new(0.1, 0.1, 0.1),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5 / aspectRatio, 0, 0.5, 0),
		Size = p1.scale:map(function(p1)
			return UDim2.new(p1 / aspectRatio, 0, p1, 0)
		end)
	}
	t3.Image = if p1.props.ready then "rbxassetid://9474441364" else p1.props.userId and ("rbxthumb://type=AvatarHeadShot&w=150&h=150&id=%d"):format(p1.props.userId)
	t3.Rotation = p1.spin
	t2.Icon = createElement("ImageLabel", t3, {
		UICorner = createElement("UICorner", {
			CornerRadius = UDim.new(1, 0)
		})
	})
	local t4 = {
		BackgroundTransparency = 1,
		BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
		Size = UDim2.new(1 - 1 / aspectRatio - 0.0078125, 0, 1, 0),
		Position = UDim2.new(1 / aspectRatio + 0.0078125, 0, 0, 0)
	}
	local t5 = {}
	local t6 = {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5)
	}
	t6.TextColor3 = p1.props.ready and Color3.fromRGB(0, 200, 90) or Color3.new(255/255, 255/255, 255/255)
	t6.Text = p1.props.displayName
	t6.TextXAlignment = Enum.TextXAlignment.Left
	t6.Font = Enum.Font.Bangers
	t6.LineHeight = 1
	t6.TextScaled = true
	t5.Text = createElement("TextLabel", t6)
	t2.Title = createElement("Frame", t4, t5)
	return createElement("Frame", t, t2)
end
function v1.PopIcon(p1)
	p1.scaleSpring:Accelerate(15)
	local Target = p1.scaleSpring.Target
	p1.maid.scaleHeartbeat = RunService.Heartbeat:Connect(function()
		local v1, v2 = p1.scaleSpring:Update()
		if math.abs(Target - v1) < 0.001 and math.abs(v2) < 0.001 then
			p1.maid.scaleHeartbeat = nil
			v1 = Target
		end
		p1.updateScale(v1)
	end)
end
function v1.SpinIcon(p1)
	p1.spinSpring:SetTarget(360)
	p1.spinSpring.p = 0
	p1.maid.spinHeartbeat = RunService.Heartbeat:Connect(function()
		local v1, v2 = p1.spinSpring:Update()
		if math.abs(360 - v1) < 0.001 and math.abs(v2) < 0.001 then
			p1.maid.spinHeartbeat = nil
			v1 = 0
		end
		p1.updateSpin(v1)
	end)
end
function v1.didUpdate(p1, p2, p3)
	if p1.props.ready ~= p2.ready and p1.props.ready then
		p1:SpinIcon()
		p1:PopIcon()
	end
end
return v1
