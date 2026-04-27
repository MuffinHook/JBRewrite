local RunService = game:GetService("RunService")
local module = script:FindFirstAncestor("EzUi")
local Dictionary = require(module.Dictionary)
local Maid = require(module.Parent.Std.Maid)
local Roact = require(module.Parent.Roact)
local createElement = Roact.createElement
local component = Roact.PureComponent:extend("ViewportFrame")
component.defaultProps = {
	size = UDim2.new(1, 0, 1, 0),
	position = UDim2.new(0, 0, 0, 0),
	fieldOfView = 70
}
function component.init(self)
	self.maid = Maid.new()
	if self.props.cameraRef then
		self.cameraRef = self.props.cameraRef
	else
		self.cameraRef = Roact.createRef()
	end
	if self.props.viewportRef then
		self.viewportRef = self.props.viewportRef
	else
		self.viewportRef = Roact.createRef()
	end
end
function component.render(self)
	return createElement("ViewportFrame", {
		BackgroundColor3 = self.props.backgroundColor,
		BackgroundTransparency = self.props.backgroundTransparency,
		BorderSizePixel = 0,
		Position = self.props.position,
		Size = self.props.size,
		AnchorPoint = self.props.anchorPoint,
		ZIndex = self.props.zIndex,
		Ambient = Color3.new(255/255, 255/255, 255/255),
		LightColor = Color3.new(255/255, 255/255, 255/255),
		CurrentCamera = self.cameraRef,
		[Roact.Ref] = self.viewportRef
	}, Dictionary.merge({
		Camera = createElement("Camera", {
			FieldOfView = self.props.fieldOfView,
			[Roact.Ref] = self.cameraRef
		})
	}, self.props[Roact.Children]))
end
function component._updateViewport(self)
	local cameraRef = self.cameraRef:getValue()
	local inst = self.maid.inst
	if inst and inst.Parent ~= nil then
		self.props.updateCamera(cameraRef, inst)
	end
end
function component._reparent(self)
	local viewportRef = self.viewportRef:getValue()
	self.maid.inst = nil
	if self.props.getInst then
		local delayThread = task.delay(math.random() * 0.1, function()
			local instance = self.props.getInst()
			self.maid.inst = instance
			instance.Parent = viewportRef
		end)
		function self.maid.cancelDelayThread()
			task.cancel(delayThread)
		end
	end
	self:_updateViewport()
end
function component.didMount(self)
	self:_reparent()
	self.maid.updateCamera = RunService.Heartbeat:Connect(function()
		self:_updateViewport()
	end)
end
function component.didUpdate(self, previousProps)
	if self.props.getInstCompare and self.props.getInstCompare ~= previousProps.getInstCompare or not self.props.getInstCompare and self.props.getInst ~= previousProps.getInst then
		self:_reparent()
	end
end
function component.willUnmount(self)
	self.maid:DoCleaning()
end
return component
