local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ColorUtils = require(ReplicatedStorage.Std.ColorUtils)
local Maid = require(ReplicatedStorage.Std.Maid)
local AccelTween = require(ReplicatedStorage.Std.AccelTween)
local Dictionary = require(ReplicatedStorage.EzUi.Dictionary)
local Roact = require(ReplicatedStorage.Roact)
local createElement = Roact.createElement
local SafeComponent = Roact.PureComponent:extend("SafeComponent")
SafeComponent.defaultProps = {
	static = false,
	selected = false,
	count = nil
}
function SafeComponent.init(self)
	self:setState({
 hover = false
	})
	self.maid = Maid.new()
	local iconScaleBinding, updateIconScaleBinding = Roact.createBinding(1)
	self.iconScale = iconScaleBinding
	self.updateIconScale = updateIconScaleBinding
	self.iconScaleAccelTween = AccelTween.new(1000)
	self.iconScaleAccelTween.p = self.iconScale:getValue()
end
function SafeComponent.render(self)
	local buttonBackgroundColor = Color3.new(0.3, 0.3, 0.3)
	if not self.props.static and (self.state.hover or self.props.selected) then
 buttonBackgroundColor = ColorUtils.brightenBy(buttonBackgroundColor, 0.5)
	end
	local buttonProps = {
 AutoButtonColor = false,
 Text = "",
 BackgroundTransparency = 1,
 BorderSizePixel = 0,
 Size = self.props.size,
 Position = self.props.position,
 LayoutOrder = self.props.layoutOrder,
 [Roact.Event.MouseEnter] = function()
 self:setState({
 hover = true
 })
 end,
 [Roact.Event.MouseLeave] = function()
 self:setState({
 hover = false
 })
 end,
 [Roact.Event.SelectionGained] = function()
 self:setState({
 hover = true
 })
 end,
 [Roact.Event.SelectionLost] = function()
 self:setState({
 hover = false
 })
 end,
 [Roact.Event.Activated] = self.props.onSelect
	}
	local childElements = {
 Bubble = createElement("Frame", {
 BackgroundColor3 = buttonBackgroundColor,
 Size = UDim2.new(1 / self.props.aspectRatio, 0, 1, 0),
 AnchorPoint = Vector2.new(0.5, 0.5),
 Position = UDim2.new(0.5, 0, 0.5, 0)
 }, {
 UICorner = createElement("UICorner", {
 CornerRadius = UDim.new(1, 0)
 })
 })
	}
	local imageProps = {
 BorderSizePixel = 0,
 BackgroundTransparency = 1,
 Size = self.iconScale:map(function(scaleFactor)
 return UDim2.new(0.8 * scaleFactor / self.props.aspectRatio, 0, 0.8 * scaleFactor, 0)
 end),
 AnchorPoint = Vector2.new(0.5, 0.5),
 Position = UDim2.new(0.5, 0, 0.5, 0)
	}
	imageProps.Image = if self.props.imageId then ("rbxassetid://%d"):format(self.props.imageId) else nil
	imageProps.ZIndex = 3
	local imageChildren = {}
	local count = self.props.count
	if count then
 count = if self.props.count > 0 then createElement("Frame", {
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
 Text = self.props.count,
 Font = Enum.Font.LuckiestGuy,
 LineHeight = 0.7,
 TextScaled = true,
 TextColor3 = Color3.new(255/255, 255/255, 255/255)
 })
	})
}) else false
	end
	imageChildren.Count = count
	childElements.Icon = createElement("ImageLabel", imageProps, imageChildren)
	return createElement("TextButton", buttonProps, Dictionary.merge(self.props[Roact.Children], childElements))
end
function SafeComponent._launchIconScaleUpdater(self)
	if self.props.static then
 self.updateIconScale(self.iconScaleAccelTween.t)
	else
 self.maid.iconScaleSpringUpdater = RunService.Heartbeat:Connect(function()
 self.updateIconScale(self.iconScaleAccelTween.p)
 if self.iconScaleAccelTween.rtime < 0.001 then
 self.maid.iconScaleSpringUpdater = nil
 end
 end)
	end
end
function SafeComponent._recalculateIconScale(self)
	local targetScale = if self.state.hover or self.props.selected then 1.2 else 1
	if self.iconScaleAccelTween.t ~= targetScale then
 self.iconScaleAccelTween.t = targetScale
 self.updateIconScale(self.iconScaleAccelTween.p)
 self:_launchIconScaleUpdater()
	end
end
function SafeComponent.didMount(self)
	self:_recalculateIconScale()
end
function SafeComponent.didUpdate(self, previousProps, previousState)
	if self.state.hover ~= previousState.hover or self.props.selected ~= previousProps.selected then
 self:_recalculateIconScale()
	end
end
function SafeComponent.willUnmount(self)
	self.maid:DoCleaning()
end
return SafeComponent
