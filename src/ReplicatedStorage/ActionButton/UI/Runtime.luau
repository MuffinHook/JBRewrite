local UserInputService_upvr = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact_upvr = require(ReplicatedStorage.Roact)
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local ActionButtonService_upvr = require(script.Parent.Parent.ActionButtonService)
local function isToggle(arg1) -- Line 20, Named "isToggle"
    local inputTypePressed = arg1._inputTypePressed
    if inputTypePressed == Enum.UserInputType.Touch or inputTypePressed == Enum.UserInputType.MouseButton1 then
        return arg1.touchIsToggle == true
    end
    if inputTypePressed == Enum.UserInputType.Gamepad1 then
        return arg1.gamepadIsToggle == true
    end
    return false
end
local any_extend_result1 = Roact_upvr.PureComponent:extend("Runtime")
any_extend_result1.defaultProps = {
    gridPosition = UDim2.new(1, -10, 1, -70);
}
function any_extend_result1.init(arg1) -- Line 38
    arg1._maid = Maid_upvr.new()
    arg1:_fetchInputType()
    arg1._maid:GiveTask(UserInputService_upvr.LastInputTypeChanged:Connect(function() -- Line 41
        arg1:_fetchInputType()
        arg1:_fetchState()
        task.delay(0, function() -- Line 44
            arg1:_updateViewType()
        end)
    end))
    arg1:_fetchState()
    arg1._maid:GiveTask(ActionButtonService_upvr.triggerUpdate:Connect(function() -- Line 49
        arg1:_fetchState()
    end))
    arg1._maid:GiveTask(workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function() -- Line 52
        arg1:_updateViewType()
    end))
    arg1:_updateViewType()
end
local InputUtils_upvr_2 = require(ReplicatedStorage.Std.InputUtils)
local Utils_upvr = require(ReplicatedStorage.EzUi.Utils)
function any_extend_result1._updateViewType(arg1) -- Line 57
    arg1:setState({
        touchControls = InputUtils_upvr_2.isTouch();
        isSmallScreen = Utils_upvr.isSmallScreen();
    })
end
function any_extend_result1._fetchInputType(arg1) -- Line 65
    local any_GetLastInputType_result1 = UserInputService_upvr:GetLastInputType()
    if any_GetLastInputType_result1 == Enum.UserInputType.Gamepad1 or any_GetLastInputType_result1 == Enum.UserInputType.Keyboard or any_GetLastInputType_result1 == Enum.UserInputType.Touch then
        arg1:setState({
            inputType = any_GetLastInputType_result1;
        })
    end
end
local InputUtils_upvr = require(script.Parent.InputUtils)
local RunService_upvr = game:GetService("RunService")
function any_extend_result1._fetchStateButton(arg1, arg2, arg3, arg4, arg5) -- Line 77
    local any_getBestKeyCode_result1 = InputUtils_upvr.getBestKeyCode(arg3.keyCodes, arg1.state.inputType)
    if not any_getBestKeyCode_result1 then
        any_getBestKeyCode_result1 = Roact_upvr
        any_getBestKeyCode_result1 = any_getBestKeyCode_result1.None
    end
    arg2[string.format("%s_%d_%s", arg4, arg5, "keyCode")] = any_getBestKeyCode_result1
    if arg3.useEvery then
        if not arg3.progressBinding then
            local any_createBinding_result1, any_createBinding_result2_2 = Roact_upvr.createBinding(0)
            arg3.progressBinding = any_createBinding_result1
            arg3.updateProgressBinding = any_createBinding_result2_2
        end
    end
    local function releaseState(...) -- Line 91
        if isToggle(arg3) then
            return
        end
        if not arg3._i then
            return
        end
        local pressedKey = string.format("%s_%d_%s", arg3._groupKey, arg3._i, "pressed")
        if arg1.state[pressedKey] then
            arg1:setState({
                [pressedKey] = false;
            })
            arg3._pressed = false
            if arg3.onReleased then
                arg3.onReleased(...)
            end
        end
    end
    arg2[string.format("%s_%d_%s", arg4, arg5, "onReleased")] = releaseState
    arg3._releaseState = releaseState
    local function pressState(...) -- Line 114
        -- Decomp Error: Reconstructed the button press state transition from a failed Konstant control-flow block.
        if not arg3._i then
            return
        end
        local pressedKey = string.format("%s_%d_%s", arg3._groupKey, arg3._i, "pressed")
        local wasPressed = arg1.state[pressedKey] == true
        if isToggle(arg3) and wasPressed then
            arg1:setState({
                [pressedKey] = false;
            })
            arg3._pressed = false
            if arg3.onReleased then
                arg3.onReleased(...)
            end
            return
        end
        if wasPressed then
            return
        end
        arg1:setState({
            [pressedKey] = true;
        })
        arg3._pressed = true
        local used
        if arg3.onPressed then
            used = arg3.onPressed(...)
        end
        if arg3.useEvery then
            assert(typeof(used) == "boolean", "onPressed must return a boolean is there is also a useEvery so that useEvery knows whether to set it as used or not")
            if used then
                arg3._lastUsed = os.clock()
                if arg3.updateProgressBinding then
                    arg3.updateProgressBinding(0)
                end
            end
        end
    end
    arg2[string.format("%s_%d_%s", arg4, arg5, "onPressed")] = pressState
    arg3._pressState = pressState
    local image = arg3.image
    if not image then
        image = Roact_upvr
        image = image.None
    end
    arg2[string.format("%s_%d_%s", arg4, arg5, "image")] = image
    arg2[string.format("%s_%d_%s", arg4, arg5, "button")] = arg3
    if arg3._pressed then
        arg2[string.format("%s_%d_%s", arg4, arg5, "pressed")] = true
    else
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        arg2[string.format("%s_%d_%s", arg4, arg5, "pressed")] = false
    end
    arg3._groupKey = arg4
    arg3._i = arg5
end
function any_extend_result1._fetchState(arg1) -- Line 175
    -- Decomp Logic Error: Rebuilt state aggregation after Konstant assigned through dead temporaries.
    for _, v in ipairs(ActionButtonService_upvr.active) do
        v._groupKey = nil
        v._i = nil
        v._releaseState = nil
        v._pressState = nil
        if not v._maid then
            v._maid = Maid_upvr.new()
        end
    end
    local tbl_5 = {}
    local any_getDataInner_result1 = ActionButtonService_upvr.getDataInner()
    tbl_5.countInner = #any_getDataInner_result1
    for i_2, v_2 in ipairs(any_getDataInner_result1) do
        arg1:_fetchStateButton(tbl_5, v_2, "inner", i_2)
    end
    local any_getDataOuter_result1 = ActionButtonService_upvr.getDataOuter()
    tbl_5.countOuter = #any_getDataOuter_result1
    for i_3, v_3 in ipairs(any_getDataOuter_result1) do
        arg1:_fetchStateButton(tbl_5, v_3, "outer", i_3)
    end
    arg1:setState(tbl_5)
end
local GuiService_upvr = game:GetService("GuiService")
function any_extend_result1.didMount(arg1) -- Line 202
    local var87_upvw = 0
    arg1._maid:GiveTask(UserInputService_upvr.InputBegan:Connect(function(arg1_2, arg2) -- Line 204
        if arg2 then
            if arg1_2.KeyCode ~= Enum.KeyCode.ButtonA and arg1_2.KeyCode ~= Enum.KeyCode.ButtonR3 then return end
            if arg1_2.KeyCode == Enum.KeyCode.ButtonA and (GuiService_upvr.SelectedObject or GuiService_upvr.MenuIsOpen or os.clock() - var87_upvw < 0.1) then return end
        end
        if arg1_2.UserInputType == Enum.UserInputType.Keyboard or arg1_2.UserInputType == Enum.UserInputType.Gamepad1 then
            local tbl = {}
            for i_4, v_4 in ipairs(ActionButtonService_upvr.active) do
                if not v_4.disabled then
                    local var112
                    if v_4.keyCodes then
                        if typeof(v_4.keyCodes) ~= "table" then
                            var112 = false
                        else
                            var112 = true
                        end
                        assert(var112, "keyCodes was not a table")
                        var112 = v_4.keyCodes
                        if table.find(var112, arg1_2.KeyCode) then
                            var112 = tbl
                            table.insert(var112, v_4)
                        end
                    end
                end
            end
            if #tbl == 0 then return end
            table.sort(tbl, function(arg1_4, arg2_3) -- Line 236
                local var114
                if (arg2_3.priority or 1) >= (arg1_4.priority or 1) then
                    var114 = false
                else
                    var114 = true
                end
                return var114
            end)
            for i_5 = 1, #tbl do
                i_4 = tbl[i_5]
                -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                i_4._keyCodePressed = arg1_2.KeyCode
                v_4 = arg1_2.UserInputType
                i_4._inputTypePressed = v_4
                v_4 = i_4._pressState
                if v_4 then
                    v_4 = i_4._pressState
                    v_4(arg1_2.UserInputType)
                end
                v_4 = i_4.allowPassThrough
                if not v_4 then break end
            end
        end
    end))
    arg1._maid:GiveTask(UserInputService_upvr.InputEnded:Connect(function(arg1_5) -- Line 252
        if arg1_5.UserInputType == Enum.UserInputType.Keyboard or arg1_5.UserInputType == Enum.UserInputType.Gamepad1 then
            for _, v_5 in ipairs(ActionButtonService_upvr.active) do
                if v_5._keyCodePressed == arg1_5.KeyCode then
                    v_5._keyCodePressed = nil
                    if v_5._releaseState then
                        v_5._releaseState(arg1_5.UserInputType)
                    end
                end
            end
        end
    end))
    arg1._maid:GiveTask(GuiService_upvr.MenuClosed:Connect(function() -- Line 268
        var87_upvw = os.clock()
    end))
end
function any_extend_result1._copyStateButton(arg1, arg2, arg3, arg4) -- Line 272
    local formatted = string.format("%s_%d_%s", arg3, arg4, "onReleased")
    local formatted_4 = string.format("%s_%d_%s", arg3, arg4, "onPressed")
    local formatted_2 = string.format("%s_%d_%s", arg3, arg4, "image")
    local formatted_6 = string.format("%s_%d_%s", arg3, arg4, "pressed")
    local formatted_3 = string.format("%s_%d_%s", arg3, arg4, "keyCode")
    local formatted_5 = string.format("%s_%d_%s", arg3, arg4, "button")
    arg2[formatted] = arg1.state[formatted]
    arg2[formatted_4] = arg1.state[formatted_4]
    arg2[formatted_2] = arg1.state[formatted_2]
    arg2[formatted_6] = arg1.state[formatted_6]
    arg2[formatted_3] = arg1.state[formatted_3]
    arg2[formatted_5] = arg1.state[formatted_5]
end
local createElement_upvr = Roact_upvr.createElement
local Radial_upvr = require(script.Parent.Radial)
local Dictionary_upvr = require(ReplicatedStorage.EzUi.Dictionary)
local Grid_upvr = require(script.Parent.Grid)
function any_extend_result1.render(arg1) -- Line 286
    -- Decomp Logic Error: Rebuilt render prop aggregation after Konstant assigned through dead temporaries.
    if not ActionButtonService_upvr.enabled then
        return nil
    end
    local buttonProps = {}
    if arg1.state.countInner then
        for i_7 = 1, arg1.state.countInner do
            arg1:_copyStateButton(buttonProps, "inner", i_7)
        end
    end
    if arg1.state.countOuter then
        for i_8 = 1, arg1.state.countOuter do
            arg1:_copyStateButton(buttonProps, "outer", i_8)
        end
    end
    local var148
    if arg1.props.DEBUG_forceRadial or arg1.state.touchControls then
        local var149
        var148 = nil
        if arg1.state.isSmallScreen then
            var149 = UDim2.new(0.6, 0, 0.6, 0)
            var148 = UDim2.new(1, 10, 1, -10)
        else
            var149 = UDim2.new(0.4, 0, 0.4, 0)
            var148 = UDim2.new(1, 10, 1, 10)
        end
        return createElement_upvr(Radial_upvr, Dictionary_upvr.merge({
            anchorPoint = Vector2.new(1, 1);
            size = var149;
            position = var148;
            countInner = arg1.state.countInner;
            countOuter = arg1.state.countOuter;
            enabled = arg1.props.enabled;
            color = arg1.props.color;
        }, buttonProps))
    end
    return createElement_upvr(Grid_upvr, Dictionary_upvr.merge({
        anchorPoint = Vector2.new(1, 1);
        size = UDim2.new(0.07, 0, 0.5, 0);
        position = arg1.props.gridPosition;
        countInner = arg1.state.countInner;
        countOuter = arg1.state.countOuter;
        enabled = arg1.props.enabled;
        color = arg1.props.color;
    }, buttonProps))
end
function any_extend_result1.willUnmount(arg1) -- Line 340
    arg1._maid:Destroy()
end
return any_extend_result1
