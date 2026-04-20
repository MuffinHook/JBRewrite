local ReplicatedStorage = game:GetService("ReplicatedStorage")
local tbl_2_upvr = {
    [Enum.KeyCode.A] = 2;
    [Enum.KeyCode.D] = 4;
    [Enum.KeyCode.Q] = 5;
    [Enum.KeyCode.E] = 6;
    [Enum.KeyCode.ButtonR2] = 1;
    [Enum.KeyCode.ButtonL2] = 3;
    [Enum.KeyCode.Left] = 2;
    [Enum.KeyCode.Right] = 4;
}
local function GetMoveVector_upvw() -- Line 26, Named "GetMoveVector"
    return Vector3.new()
end
local ControlModule = game:GetService("Players").LocalPlayer:FindFirstChild("PlayerScripts"):FindFirstChild("PlayerModule"):FindFirstChild("ControlModule")
if ControlModule then
    local var3_2_upvw = require(ControlModule)
    function GetMoveVector_upvw() -- Line 36, Named "GetMoveVector"
        return var3_2_upvw:GetMoveVector()
    end
end
local module_upvr = {}
module_upvr.__index = module_upvr
local Maid_upvr = require(ReplicatedStorage.Std.Maid)
local UserInputService_upvr = game:GetService("UserInputService")
local ActionButtonService_upvr = require(ReplicatedStorage.ActionButton.ActionButtonService)
local RunService_upvr = game:GetService("RunService")
function module_upvr.new() -- Line 45
    local module_upvr_2 = {}
    setmetatable(module_upvr_2, module_upvr)
    module_upvr_2._wasdqe = {0, 0, 0, 0, 0, 0}
    module_upvr_2._maid = Maid_upvr.new()
    module_upvr_2._maid:GiveTask(UserInputService_upvr.InputBegan:Connect(function(arg1, arg2) -- Line 52
        if arg2 then
        elseif arg1.UserInputType == Enum.UserInputType.Keyboard then
            local KeyCode_2 = arg1.KeyCode
            if tbl_2_upvr[KeyCode_2] then
                module_upvr_2._wasdqe[tbl_2_upvr[KeyCode_2]] = 1
            end
        end
    end))
    module_upvr_2._maid:GiveTask(UserInputService_upvr.InputEnded:Connect(function(arg1, arg2) -- Line 63
        if arg2 then
        elseif arg1.UserInputType == Enum.UserInputType.Keyboard then
            local KeyCode = arg1.KeyCode
            if tbl_2_upvr[KeyCode] then
                module_upvr_2._wasdqe[tbl_2_upvr[KeyCode]] = 0
            end
        end
    end))
    local tbl = {
        primary = true;
        priority = 1000;
        saturateTo = 0;
        image = "rbxassetid://7858765663";
        keyCodes = {Enum.KeyCode.W, Enum.KeyCode.Up};
    }
    local function onPressed() -- Line 80
        module_upvr_2._wasdqe[1] = 1
    end
    tbl.onPressed = onPressed
    local function onReleased() -- Line 83
        module_upvr_2._wasdqe[1] = 0
    end
    tbl.onReleased = onReleased
    module_upvr_2._maid:GiveTask(ActionButtonService_upvr.add(tbl))
    module_upvr_2._maid:GiveTask(ActionButtonService_upvr.add({
        primary = true;
        priority = 700;
        saturateTo = 0;
        image = "rbxassetid://7858764373";
        keyCodes = {Enum.KeyCode.S, Enum.KeyCode.Down};
        onPressed = function() -- Line 93, Named "onPressed"
            module_upvr_2._wasdqe[3] = 1
        end;
        onReleased = function() -- Line 96, Named "onReleased"
            module_upvr_2._wasdqe[3] = 0
        end;
    }))
    module_upvr_2._maid:GiveTask(UserInputService_upvr.InputChanged:Connect(function(arg1) -- Line 100
        if arg1.UserInputType == Enum.UserInputType.Gamepad1 then
            local KeyCode_3_upvr = arg1.KeyCode
            local var23
            if KeyCode_3_upvr == Enum.KeyCode.Thumbstick1 then
                local X = arg1.Position.X
                local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                    var23 = (-X) ^ 2
                    return var23
                end
                if X >= -0.24 or not decompInlinedCondition() then
                    var23 = 0
                end
                module_upvr_2._wasdqe[2] = var23
                local function decompInlinedCondition_2() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                    var23 = X ^ 2
                    return var23
                end
                if 0.24 >= X or not decompInlinedCondition_2() then
                    var23 = 0
                end
                module_upvr_2._wasdqe[4] = var23
                return
            end
            local var26
            local function decompInlinedCondition_3() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                local var29_upvr = "throttleHeartbeat"..tostring_result1
                local var28_upvr = "throttleWaitForEnd"..tostring_result1
                local tostring_result1 = tostring(KeyCode_3_upvr.Name)
                return module_upvr_2._maid[var28_upvr]
            end
            if KeyCode_3_upvr == Enum.KeyCode.ButtonR2 or KeyCode_3_upvr == Enum.KeyCode.ButtonL2 or not decompInlinedCondition_3() then
                module_upvr_2._maid[var28_upvr] = arg1:GetPropertyChangedSignal("UserInputState"):Connect(function() -- Line 117
                    if arg1.UserInputState == Enum.UserInputState.End then
                        module_upvr_2._maid[var28_upvr] = nil
                        module_upvr_2._maid[var29_upvr] = nil
                        module_upvr_2._wasdqe[tbl_2_upvr[KeyCode_3_upvr]] = 0
                    end
                end)
                local Z = arg1.Position.Z
                var26 = tbl_2_upvr
                local function decompInlinedCondition_5() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                    var26 = Z ^ 0.5
                    return var26
                end
                if 0.05 >= Z or not decompInlinedCondition_5() then
                    var26 = 0
                end
                module_upvr_2._wasdqe[var26[KeyCode_3_upvr]] = var26
                module_upvr_2._maid[var29_upvr] = RunService_upvr.Heartbeat:Connect(function() -- Line 125, Named "update"
                    local Z_2 = arg1.Position.Z
                    local var32
                    local function decompInlinedCondition_4() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                        var32 = Z_2 ^ 0.5
                        return var32
                    end
                    if 0.05 >= Z_2 or not decompInlinedCondition_4() then
                        var32 = 0
                    end
                    module_upvr_2._wasdqe[tbl_2_upvr[KeyCode_3_upvr]] = var32
                end)
            end
        end
    end))
    return module_upvr_2
end
function module_upvr.GetForwardBackward(arg1) -- Line 140
    return arg1._wasdqe[1] - arg1._wasdqe[3]
end
local InputUtils_upvr = require(ReplicatedStorage.Std.InputUtils)
function module_upvr.GetLeftRight(arg1) -- Line 143
    local var35 = arg1._wasdqe[2] - arg1._wasdqe[4]
    if InputUtils_upvr.isTouch() then
        var35 = -math.clamp(GetMoveVector_upvw().X, -1, 1)
    end
    return var35
end
function module_upvr.GetUpDown(arg1) -- Line 152
    return arg1._wasdqe[6] - arg1._wasdqe[5]
end
function module_upvr.Destroy(arg1) -- Line 155
    arg1._maid:Destroy()
    setmetatable(arg1, nil)
end
return module_upvr