local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage.Roact)
local any_extend_result1 = Roact_upvr.PureComponent:extend("CustomizeItem")
any_extend_result1.defaultProps = {
    faved = false;
    canFavorite = true;
    favHeight = 0.165;
    cashHeight = 0.08;
    accentColor = Color3.fromRGB(98, 222, 253);
}
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
function any_extend_result1.init(arg1) -- Line 19
    arg1:setState({
        hover = false;
        favHover = false;
    })
    arg1.cameraRef = Roact_upvr.createRef()
    arg1.viewportRef = Roact_upvr.createRef()
    arg1.maid = Maid_upvr.new()
    arg1.mountCount = 0
end
local String_upvr = require(ReplicatedStorage.Std.String)
local createElement_upvr = Roact_upvr.createElement
local ColorUtils_upvr = require(ReplicatedStorage.Std.ColorUtils)
function any_extend_result1.render(arg1) -- Line 29
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    if arg1.props.equipped then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    if arg1.props.owned then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
function any_extend_result1._updateViewport(arg1) -- Line 408
    local inst = arg1.maid.inst
    if inst and inst.Parent ~= nil then
        arg1.props.updateCamera(arg1.cameraRef:getValue(), inst)
    end
end
function any_extend_result1._reparent(arg1) -- Line 415
    arg1.maid.inst = nil
    if arg1.props.getInst then
        local mountCount_upvr = arg1.mountCount
        local any_getValue_result1_upvr = arg1.viewportRef:getValue()
        task.delay(math.random() * 0.3, function() -- Line 423
            if arg1.mounted and arg1.mountCount == mountCount_upvr then
                local any_getInst_result1 = arg1.props.getInst()
                arg1.maid.inst = any_getInst_result1
                any_getInst_result1.Parent = any_getValue_result1_upvr
            end
        end)
    end
    mountCount_upvr = arg1:_updateViewport
    mountCount_upvr()
end
local RunService_upvr = game:GetService("RunService")
function any_extend_result1.didMount(arg1) -- Line 434
    arg1.mounted = true
    arg1.mountCount += 1
    arg1:_reparent()
    arg1.maid.updateCamera = RunService_upvr.Heartbeat:Connect(function() -- Line 438
        arg1:_updateViewport()
    end)
end
function any_extend_result1.didUpdate(arg1, arg2, arg3) -- Line 442
    if arg1.props.getInstCompare and arg1.props.getInstCompare ~= arg2.getInstCompare or not arg1.props.getInstCompare and arg1.props.getInst ~= arg2.getInst then
        arg1:_reparent()
    end
end
function any_extend_result1.willUnmount(arg1) -- Line 452
    arg1.mounted = false
    arg1.maid:DoCleaning()
end
return any_extend_result1