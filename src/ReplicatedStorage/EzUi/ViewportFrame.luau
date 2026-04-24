-- Reviewed by Claude
local RunService = game:GetService("RunService")
local v1 = script:FindFirstAncestor("EzUi")
local Dictionary = require(v1.Dictionary)
local Maid = require(v1.Parent.Std.Maid)
local Roact = require(v1.Parent.Roact)
local createElement = Roact.createElement
local v2 = Roact.PureComponent:extend("ViewportFrame")
v2.defaultProps = {
	size = UDim2.new(1, 0, 1, 0),
	position = UDim2.new(0, 0, 0, 0),
	fieldOfView = 70
}
function v2.init(p1)
	p1.maid = Maid.new()
	if p1.props.cameraRef then
		p1.cameraRef = p1.props.cameraRef
	else
		p1.cameraRef = Roact.createRef()
	end
	if p1.props.viewportRef then
		p1.viewportRef = p1.props.viewportRef
	else
		p1.viewportRef = Roact.createRef()
	end
end
function v2.render(p1)
	return createElement("ViewportFrame", {
		BackgroundColor3 = p1.props.backgroundColor,
		BackgroundTransparency = p1.props.backgroundTransparency,
		BorderSizePixel = 0,
		Position = p1.props.position,
		Size = p1.props.size,
		AnchorPoint = p1.props.anchorPoint,
		ZIndex = p1.props.zIndex,
		Ambient = Color3.new(255/255, 255/255, 255/255),
		LightColor = Color3.new(255/255, 255/255, 255/255),
		CurrentCamera = p1.cameraRef,
		[Roact.Ref] = p1.viewportRef
	}, Dictionary.merge({
		Camera = createElement("Camera", {
			FieldOfView = p1.props.fieldOfView,
			[Roact.Ref] = p1.cameraRef
		})
	}, p1.props[Roact.Children]))
end
function v2._updateViewport(p1)
	local v1 = p1.cameraRef:getValue()
	local inst = p1.maid.inst
	if inst and inst.Parent ~= nil then
		p1.props.updateCamera(v1, inst)
	end
end
function v2._reparent(p1)
	local v1 = p1.viewportRef:getValue()
	p1.maid.inst = nil
	if p1.props.getInst then
		local v2 = task.delay(math.random() * 0.1, function()
			local v12 = p1.props.getInst()
			p1.maid.inst = v12
			v12.Parent = v1
		end)
		function p1.maid.cancelDelayThread()
			task.cancel(v2)
		end
	end
	p1:_updateViewport()
end
function v2.didMount(p1)
	p1:_reparent()
	p1.maid.updateCamera = RunService.Heartbeat:Connect(function()
		p1:_updateViewport()
	end)
end
function v2.didUpdate(p1, p2)
	if p1.props.getInstCompare and p1.props.getInstCompare ~= p2.getInstCompare or not p1.props.getInstCompare and p1.props.getInst ~= p2.getInst then
		p1:_reparent()
	end
end
function v2.willUnmount(p1)
	p1.maid:DoCleaning()
end
return v2
