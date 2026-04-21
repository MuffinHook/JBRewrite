local EzUi = script:FindFirstAncestor("EzUi")
local Roact_upvr = require(EzUi.Parent.Roact)
local any_extend_result1 = Roact_upvr.PureComponent:extend("ViewportFrame")
any_extend_result1.defaultProps = {
    size = UDim2.new(1, 0, 1, 0);
    position = UDim2.new(0, 0, 0, 0);
    fieldOfView = 70;
}
local Maid_upvr = require(EzUi.Parent.Std.Maid)
function any_extend_result1.init(arg1) -- Line 19
    arg1.maid = Maid_upvr.new()
    if arg1.props.cameraRef then
        arg1.cameraRef = arg1.props.cameraRef
    else
        arg1.cameraRef = Roact_upvr.createRef()
    end
    if arg1.props.viewportRef then
        arg1.viewportRef = arg1.props.viewportRef
    else
        arg1.viewportRef = Roact_upvr.createRef()
    end
end
local createElement_upvr = Roact_upvr.createElement
local Dictionary_upvr = require(EzUi.Dictionary)
function any_extend_result1.render(arg1) -- Line 32
    return createElement_upvr("ViewportFrame", {
        BackgroundColor3 = arg1.props.backgroundColor;
        BackgroundTransparency = arg1.props.backgroundTransparency;
        BorderSizePixel = 0;
        Position = arg1.props.position;
        Size = arg1.props.size;
        AnchorPoint = arg1.props.anchorPoint;
        ZIndex = arg1.props.zIndex;
        Ambient = Color3.new(1, 1, 1);
        LightColor = Color3.new(1, 1, 1);
        CurrentCamera = arg1.cameraRef;
        [Roact_upvr.Ref] = arg1.viewportRef;
    }, Dictionary_upvr.merge({
        Camera = createElement_upvr("Camera", {
            FieldOfView = arg1.props.fieldOfView;
            [Roact_upvr.Ref] = arg1.cameraRef;
        });
    }, arg1.props[Roact_upvr.Children]))
end
function any_extend_result1._updateViewport(arg1) -- Line 56
    local inst = arg1.maid.inst
    if inst and inst.Parent ~= nil then
        arg1.props.updateCamera(arg1.cameraRef:getValue(), inst)
    end
end
function any_extend_result1._reparent(arg1) -- Line 63
    arg1.maid.inst = nil
    if arg1.props.getInst then
        local any_getValue_result1_upvr = arg1.viewportRef:getValue()
        local task_delay_result1_upvr = task.delay(math.random() * 0.1, function() -- Line 70
            local any_getInst_result1 = arg1.props.getInst()
            arg1.maid.inst = any_getInst_result1
            any_getInst_result1.Parent = any_getValue_result1_upvr
        end)
        arg1.maid.cancelDelayThread = function() -- Line 75
            task.cancel(task_delay_result1_upvr)
        end
    end
    local _task_delay_result1_upvr = task_delay_result1_upvr
    arg1:_updateViewport()
end
local RunService_upvr = game:GetService("RunService")
function any_extend_result1.didMount(arg1) -- Line 81
    arg1:_reparent()
    arg1.maid.updateCamera = RunService_upvr.Heartbeat:Connect(function() -- Line 83
        arg1:_updateViewport()
    end)
end
function any_extend_result1.didUpdate(arg1, arg2) -- Line 87
    if arg1.props.getInstCompare and arg1.props.getInstCompare ~= arg2.getInstCompare or not arg1.props.getInstCompare and arg1.props.getInst ~= arg2.getInst then
        arg1:_reparent()
    end
end
function any_extend_result1.willUnmount(arg1) -- Line 95
    arg1.maid:DoCleaning()
end
return any_extend_result1