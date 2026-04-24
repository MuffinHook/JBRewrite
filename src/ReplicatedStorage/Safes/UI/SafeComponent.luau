-- Reviewed by Claude
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ColorUtils = require(ReplicatedStorage.Std.ColorUtils)
local Maid = require(ReplicatedStorage.Std.Maid)
local AccelTween = require(ReplicatedStorage.Std.AccelTween)
local Dictionary = require(ReplicatedStorage.EzUi.Dictionary)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local color = Roact.PureComponent:extend("SafeComponent")
color.defaultProps = {
	static = false,
	selected = false,
	count = nil
}
function color.init(p1)
	p1:setState({
 hover = false
	})
	p1.maid = Maid.new()
	local color, v2 = Roact.createBinding(1)
	p1.iconScale = color
	p1.updateIconScale = v2
	p1.iconScaleAccelTween = AccelTween.new(1000)
	p1.iconScaleAccelTween.p = p1.iconScale:getValue()
end
function color.render(p1)
	local color = Color3.new(0.3, 0.3, 0.3)
	if not p1.props.static and (p1.state.hover or p1.props.selected) then
 color = ColorUtils.brightenBy(color, 0.5)
	end
	local t = {
 AutoButtonColor = false,
 Text = "",
 BackgroundTransparency = 1,
 BorderSizePixel = 0,
 Size = p1.props.size,
 Position = p1.props.position,
 LayoutOrder = p1.props.layoutOrder,
 [Roact.Event.MouseEnter] = function()
 p1:setState({
 hover = true
 })
 end,
 [Roact.Event.MouseLeave] = function()
 p1:setState({
 hover = false
 })
 end,
 [Roact.Event.SelectionGained] = function()
 p1:setState({
 hover = true
 })
 end,
 [Roact.Event.SelectionLost] = function()
 p1:setState({
 hover = false
 })
 end,
 [Roact.Event.Activated] = p1.props.onSelect
	}
	local t2 = {
 Bubble = createElement("Frame", {
 BackgroundColor3 = color,
 Size = UDim2.new(1 / p1.props.aspectRatio, 0, 1, 0),
 AnchorPoint = Vector2.new(0.5, 0.5),
 Position = UDim2.new(0.5, 0, 0.5, 0)
 }, {
 UICorner = createElement("UICorner", {
 CornerRadius = UDim.new(1, 0)
 })
 })
	}
	local t3 = {
 BorderSizePixel = 0,
 BackgroundTransparency = 1,
 Size = p1.iconScale:map(function(p12)
 return UDim2.new(0.8 * p12 / p1.props.aspectRatio, 0, 0.8 * p12, 0)
 end),
 AnchorPoint = Vector2.new(0.5, 0.5),
 Position = UDim2.new(0.5, 0, 0.5, 0)
	}
	t3.Image = if p1.props.imageId then ("rbxassetid://%d"):format(p1.props.imageId) else nil
	t3.ZIndex = 3
	local t4 = {}
	local count = p1.props.count
	if count then
 count = if p1.props.count > 0 then createElement("Frame", {
	BorderSizePixel = 0,
	BackgroundTransparency = 0,
	BackgroundColor3 = Color3.new(0.1, 0.1, 0.1),
	Size = UDim2.new(0.3, 0, 0.3, 0),
	Position = UDim2.new(0.85, 0, 0.15, 0),
	AnchorPoint = Vector2.new(0.5, 0.5),
	ZIndex = 4
}, {
	UICorner = createElement("UICorner", {
 CornerRadius = UDim.new(1, 0)
	}),
	Title = createElement("Frame", {
 BackgroundTransparency = 1,
 BackgroundColor3 = Color3.new(255/255, 0/255, 0/255),
 Size = UDim2.new(1, 0, 1, 0),
 Position = UDim2.new(0, 0, 0, 0)
	}, {
 Text = createElement("TextLabel", {
 BackgroundTransparency = 1,
 Size = UDim2.new(1, 0, 0.6, 0),
 Position = UDim2.new(0.5, 0, 0.5, 0),
 AnchorPoint = Vector2.new(0.5, 0.5),
 Text = p1.props.count,
 Font = Enum.Font.LuckiestGuy,
 LineHeight = 0.7,
 TextScaled = true,
 TextColor3 = Color3.new(255/255, 255/255, 255/255)
 })
	})
}) else false
	end
	t4.Count = count
	t2.Icon = createElement("ImageLabel", t3, t4)
	return createElement("TextButton", t, Dictionary.merge(p1.props[Roact.Children], t2))
end
function color._launchIconScaleUpdater(p1)
	if p1.props.static then
 p1.updateIconScale(p1.iconScaleAccelTween.t)
	else
 p1.maid.iconScaleSpringUpdater = RunService.Heartbeat:Connect(function()
 p1.updateIconScale(p1.iconScaleAccelTween.p)
 if p1.iconScaleAccelTween.rtime < 0.001 then
 p1.maid.iconScaleSpringUpdater = nil
 end
 end)
	end
end
function color._recalculateIconScale(p1)
	local color = if p1.state.hover or p1.props.selected then 1.2 else 1
	if p1.iconScaleAccelTween.t ~= color then
 p1.iconScaleAccelTween.t = color
 p1.updateIconScale(p1.iconScaleAccelTween.p)
 p1:_launchIconScaleUpdater()
	end
end
function color.didMount(p1)
	p1:_recalculateIconScale()
end
function color.didUpdate(p1, p2, p3)
	if p1.state.hover ~= p3.hover or p1.props.selected ~= p2.selected then
 p1:_recalculateIconScale()
	end
end
function color.willUnmount(p1)
	p1.maid:DoCleaning()
end
return color