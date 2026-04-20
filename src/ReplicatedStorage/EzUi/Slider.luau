local GamepadService_upvr = game:GetService("GamepadService")
local EzUi = script:FindFirstAncestor("EzUi")
local Roact_upvr = require(EzUi.Parent.Roact)
local RunService_upvr = game:GetService("RunService")
local any_extend_result1 = Roact_upvr.PureComponent:extend("Slider")
any_extend_result1.defaultProps = {
    backgroundColor = Color3.new(1, 0, 0);
    handleColor = Color3.new(1, 1, 1);
    min = 0;
    max = 1;
    step = 0;
}
local Maid_upvr = require(EzUi.Parent.Std.Maid)
function any_extend_result1.init(arg1) -- Line 23
    arg1.sliderRef = Roact_upvr.createRef()
    arg1.handleRef = Roact_upvr.createRef()
    arg1.maid = Maid_upvr.new()
    arg1:setState({
        sliderAbsoluteSize = Vector2.new(1, 1);
    })
end
local createElement_upvr = Roact_upvr.createElement
local GuiService_upvr = game:GetService("GuiService")
local ContextActionService_upvr = game:GetService("ContextActionService")
function any_extend_result1.render(arg1) -- Line 31
    local var12_upvr = arg1.state.sliderAbsoluteSize.Y / arg1.state.sliderAbsoluteSize.X
    return createElement_upvr("Frame", {
        BackgroundColor3 = arg1.props.backgroundColor;
        BorderSizePixel = 0;
        Position = arg1.props.position;
        Size = arg1.props.size;
        LayoutOrder = arg1.props.layoutOrder;
        [Roact_upvr.Ref] = arg1.sliderRef;
        [Roact_upvr.Change.AbsoluteSize] = function(arg1_2) -- Line 42
            arg1:setState({
                sliderAbsoluteSize = arg1_2.AbsoluteSize;
            })
        end;
    }, {
        UICorner = createElement_upvr("UICorner", {
            CornerRadius = UDim.new(1, 0);
        });
        Handle = createElement_upvr("TextButton", {
            BackgroundTransparency = 0;
            BackgroundColor3 = arg1.props.handleColor;
            BorderSizePixel = 0;
            Size = UDim2.new(0, 3 * arg1.state.sliderAbsoluteSize.Y * 0.8, 0, arg1.state.sliderAbsoluteSize.Y * 0.8);
            Position = arg1.props.value:map(function(arg1_3) -- Line 61
                local var20 = 1.3000000000000003 * var12_upvr
                return UDim2.new((arg1_3 - arg1.props.min) / (arg1.props.max - arg1.props.min) * (1 - 2 * var20) + var20, 0, 0.5, 0)
            end);
            Font = Enum.Font.SourceSansBold;
            Text = arg1.props.text;
            TextScaled = true;
            TextColor3 = Color3.new(0.1, 0.1, 0.1);
            AnchorPoint = Vector2.new(0.5, 0.5);
            [Roact_upvr.Event.InputBegan] = function(arg1_4, arg2) -- Line 72
                if arg2.UserInputType == Enum.UserInputType.MouseButton1 or arg2.UserInputType == Enum.UserInputType.Touch or arg2.UserInputState == Enum.UserInputState.Begin then
                    arg1.maid.waitForEnd = arg2:GetPropertyChangedSignal("UserInputState"):Connect(function() -- Line 78
                        if arg2.UserInputState == Enum.UserInputState.End then
                            arg1.maid.waitForEnd = nil
                            arg1.maid.dragHeartbeat = nil
                        end
                    end)
                    local any_getValue_result1_upvr_2 = arg1.sliderRef:getValue()
                    arg1.maid.dragHeartbeat = RunService_upvr.Heartbeat:Connect(function() -- Line 85
                        if arg1._mouseMovementInput then
                            local AbsoluteSize_2 = any_getValue_result1_upvr_2.AbsoluteSize
                            local var32 = 1.3000000000000003 * var12_upvr
                            arg1:_setValue((arg1._mouseMovementInput.Position.X - any_getValue_result1_upvr_2.AbsolutePosition.X - AbsoluteSize_2.X * var32) / (AbsoluteSize_2.X * (1 - 2 * var32)))
                        end
                    end)
                end
                any_getValue_result1_upvr_2 = arg2.UserInputType
                local function decompInlinedCondition_2() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                    any_getValue_result1_upvr_2 = arg2.UserInputType
                    return any_getValue_result1_upvr_2 == Enum.UserInputType.Touch
                end
                if any_getValue_result1_upvr_2 == Enum.UserInputType.MouseMovement or decompInlinedCondition_2() then
                    any_getValue_result1_upvr_2 = arg1
                    any_getValue_result1_upvr_2._mouseMovementInput = arg2
                end
                any_getValue_result1_upvr_2 = arg2.UserInputType
                if any_getValue_result1_upvr_2 == Enum.UserInputType.Gamepad1 then
                    any_getValue_result1_upvr_2 = arg2.KeyCode
                    if any_getValue_result1_upvr_2 == Enum.KeyCode.ButtonA then
                        any_getValue_result1_upvr_2 = GuiService_upvr
                        any_getValue_result1_upvr_2 = any_getValue_result1_upvr_2.SelectedObject
                        arg1.isGamepadDragging = true
                        GuiService_upvr.SelectedObject = nil
                        arg1.maid.waitForEnd = arg2:GetPropertyChangedSignal("UserInputState"):Connect(function() -- Line 113
                            if arg2.UserInputState == Enum.UserInputState.End then
                                arg1.maid.waitForEnd = nil
                                GuiService_upvr.SelectedObject = any_getValue_result1_upvr_2
                                arg1.isGamepadDragging = false
                            end
                        end)
                    end
                end
            end;
            [Roact_upvr.Event.SelectionGained] = function() -- Line 124
                if GamepadService_upvr.GamepadCursorEnabled then
                elseif not arg1.isGamepadDragging then
                    arg1:_hookSelection(true)
                    ContextActionService_upvr:BindActionAtPriority("sinkThumb1", function() -- Line 130
                        return Enum.ContextActionResult.Sink
                    end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.Thumbstick1)
                    ContextActionService_upvr:BindActionAtPriority("sinkThumb2", function() -- Line 133
                        return Enum.ContextActionResult.Sink
                    end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.Thumbstick2)
                end
            end;
            [Roact_upvr.Event.SelectionLost] = function() -- Line 138
                if GamepadService_upvr.GamepadCursorEnabled then
                elseif not arg1.isGamepadDragging then
                    ContextActionService_upvr:UnbindAction("sinkThumb1")
                    ContextActionService_upvr:UnbindAction("sinkThumb2")
                    arg1:_hookSelection(false)
                end
            end;
            [Roact_upvr.Ref] = arg1.handleRef;
        }, {
            UICorner = createElement_upvr("UICorner", {
                CornerRadius = UDim.new(1, 0);
            });
        });
    })
end
function any_extend_result1._setValue(arg1, arg2) -- Line 156
    arg2 = math.clamp(arg2, 0, 1)
    local var40 = arg2
    local step = arg1.props.step
    local var42 = arg1.props.max - arg1.props.min
    if 0 < step then
        local var43 = var42 / step
        var40 = math.floor(var40 * var43 + 0.5) / var43
    end
    local var44 = var40 * var42 + arg1.props.min
    if arg1.props.value:getValue() ~= var44 then
        arg1.props.updateValue(var44)
    end
end
local UserInputService_upvr = game:GetService("UserInputService")
function any_extend_result1._hookSelection(arg1, arg2) -- Line 169
    if arg2 then
        local var46_upvw
        arg1.maid.selectionDragListen = UserInputService_upvr.InputChanged:Connect(function(arg1_5) -- Line 172
            if GamepadService_upvr.GamepadCursorEnabled then
            elseif arg1_5.UserInputType == Enum.UserInputType.Gamepad1 and arg1_5.KeyCode == Enum.KeyCode.Thumbstick2 then
                var46_upvw = arg1_5
            end
        end)
        arg1.maid.dragHeartbeat = RunService_upvr.Heartbeat:Connect(function(arg1_6) -- Line 186
            if var46_upvw then
                local X_2 = var46_upvw.Position.X
                if 0.1 < math.abs(X_2) then
                    arg1:_setValue((arg1.props.value:getValue() - arg1.props.min) / (arg1.props.max - arg1.props.min) + X_2 * arg1_6)
                end
            end
        end)
    else
        arg1.maid.selectionDragListen = nil
        arg1.maid.dragHeartbeat = nil
    end
end
function any_extend_result1.willUnmount(arg1) -- Line 202
    arg1.maid:DoCleaning()
end
return any_extend_result1