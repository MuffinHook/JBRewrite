local DoorConsts_upvr = require(script.Parent.DoorConsts)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module_upvr = {}
local RunService_upvr = game:GetService("RunService")
local TableUtils_upvr = require(ReplicatedStorage.Std.TableUtils)
local Players_upvr = game:GetService("Players")
local Joint_upvr = require(ReplicatedStorage.Std.Joint)
function module_upvr.setup(arg1, arg2) -- Line 10
    local PrimaryPart = arg1.PrimaryPart
    if not PrimaryPart then
        error("Missing PrimaryPart for door: "..arg1:GetFullName())
    end
    local Part = Instance.new("Part")
    Part.Size = Vector3.new(1, 1, 1)
    Part.Anchored = true
    Part.CFrame = PrimaryPart.CFrame
    Part.CanCollide = false
    Part.Transparency = 1
    local Model = Instance.new("Model")
    Model.PrimaryPart = PrimaryPart
    Model.Name = DoorConsts_upvr.INNER_MODEL_NAME
    for _, v_upvr in ipairs(arg1:GetChildren()) do
        if not v_upvr:IsA("BasePart") and not v_upvr:IsA("Model") then
            task.delay(3, function() -- Line 26
                local var17 = false
                if RunService_upvr:IsServer() then
                    local any_map_result1 = TableUtils_upvr.map(Players_upvr:GetPlayers(), function(arg1_2) -- Line 31
                        return arg1_2.UserId
                    end)
                    if table.find(any_map_result1, 2025110) or table.find(any_map_result1, 25881764) then
                        var17 = true
                        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
                    end
                elseif Players_upvr.LocalPlayer.UserId == 2025110 or Players_upvr.LocalPlayer.UserId == 25881764 then
                    var17 = true
                end
                if var17 then
                    warn("ONLY SHOWN FOR ALEX: [Door2] Not recommended to have non-basepart in Door model: "..v_upvr.ClassName.." @ "..v_upvr:GetFullName())
                end
            end)
        end
        v_upvr.Parent = Model
    end
    Model.Parent = arg1
    Part.Parent = arg1
    arg1.PrimaryPart = Part
    if arg2 then
        Joint_upvr.WeldAllTo(Model, PrimaryPart)
        local any_BlankMotor_result1 = Joint_upvr.BlankMotor(PrimaryPart, Part)
        any_BlankMotor_result1.Name = DoorConsts_upvr.MOTOR_OBJ_NAME
        any_BlankMotor_result1.Parent = Part
    end
    return Model
end
function module_upvr.getOpen(arg1) -- Line 67
    return arg1:GetAttribute(DoorConsts_upvr.OPEN_ATTR_NAME)
end
function module_upvr.setOpen(arg1, arg2) -- Line 70
    if arg2 == nil then
    else
    end
    assert(true)
    arg1:SetAttribute(DoorConsts_upvr.OPEN_ATTR_NAME, arg2)
end
function module_upvr.getPctOpen(arg1) -- Line 74
    return arg1:GetAttribute(DoorConsts_upvr.PCT_OPEN_ATTR_NAME)
end
function module_upvr.setPctOpen(arg1, arg2) -- Line 77
    if arg2 == nil then
    else
    end
    assert(true, "missing pctOpen")
    arg1:SetAttribute(DoorConsts_upvr.PCT_OPEN_ATTR_NAME, arg2)
end
function module_upvr.getDoorOpenChangedSignal(arg1) -- Line 81
    return arg1:GetAttributeChangedSignal(DoorConsts_upvr.OPEN_ATTR_NAME)
end
function module_upvr.getDoorPctOpenChangedSignal(arg1) -- Line 84
    return arg1:GetAttributeChangedSignal(DoorConsts_upvr.PCT_OPEN_ATTR_NAME)
end
function module_upvr.getDuration(arg1) -- Line 87
    return arg1:GetAttribute(DoorConsts_upvr.DURATION_ATTR_NAME)
end
function module_upvr.setDuration(arg1, arg2) -- Line 90
    if arg2 == nil then
    else
    end
    assert(true)
    arg1:SetAttribute(DoorConsts_upvr.DURATION_ATTR_NAME, arg2)
end
function module_upvr.getShouldSwing(arg1) -- Line 94
    return arg1:GetAttribute(DoorConsts_upvr.SHOULD_SWING_ATTR_NAME)
end
function module_upvr.setShouldSwing(arg1, arg2) -- Line 97
    if arg2 == nil then
    else
    end
    assert(true)
    arg1:SetAttribute(DoorConsts_upvr.SHOULD_SWING_ATTR_NAME, arg2)
end
function module_upvr.getMaxAngle(arg1) -- Line 101
    return arg1:GetAttribute(DoorConsts_upvr.MAX_ANGLE_ATTR_NAME)
end
function module_upvr.setMaxAngle(arg1, arg2) -- Line 104
    if arg2 == nil then
    else
    end
    assert(true)
    arg1:SetAttribute(DoorConsts_upvr.MAX_ANGLE_ATTR_NAME, arg2)
end
function module_upvr.getInnerModel(arg1) -- Line 108
    return arg1:FindFirstChild(DoorConsts_upvr.INNER_MODEL_NAME)
end
local waitForChild_upvr = require(ReplicatedStorage.Std.waitForChild)
function module_upvr.promiseInnerModel(arg1) -- Line 111
    return waitForChild_upvr(arg1, DoorConsts_upvr.INNER_MODEL_NAME, 10)
end
function module_upvr.setValueRaw(arg1, arg2, arg3, arg4, arg5) -- Line 114
    local var22
    if arg4 then
        var22 = CFrame.Angles(0, arg5, 0)
    else
        var22 = CFrame.new(arg5, 0, 0)
    end
    if arg3 then
        arg3.C1 = var22
    else
        arg2:PivotTo(arg1.CFrame * var22)
    end
end
function module_upvr.setValue(arg1, arg2) -- Line 127
    local PrimaryPart_2 = arg1.PrimaryPart
    module_upvr.setValueRaw(PrimaryPart_2, arg1:FindFirstChild(DoorConsts_upvr.INNER_MODEL_NAME), PrimaryPart_2:FindFirstChild(DoorConsts_upvr.MOTOR_OBJ_NAME), arg1:GetAttribute(DoorConsts_upvr.SHOULD_SWING_ATTR_NAME), arg2)
end
function module_upvr.setFreezeStateOnServer(arg1, arg2) -- Line 135
    arg1:SetAttribute(DoorConsts_upvr.FREEZE_SERVER_STATE_ATTR_NAME, arg2)
end
function module_upvr.setSnapStateOnServer(arg1, arg2) -- Line 138
    arg1:SetAttribute(DoorConsts_upvr.SNAP_SERVER_STATE_ATTR_NAME, arg2)
end
function module_upvr.setEasingDirection(arg1, arg2) -- Line 141
    if arg1 == nil then
    else
    end
    assert(true)
    if typeof(arg2) ~= "EnumItem" then
    else
    end
    assert(true)
    arg1:SetAttribute(DoorConsts_upvr.EASING_DIRECTION_ATTR_NAME, arg2.Name)
end
function module_upvr.setEasingStyle(arg1, arg2) -- Line 146
    if arg1 == nil then
    else
    end
    assert(true)
    if typeof(arg2) ~= "EnumItem" then
    else
    end
    assert(true)
    arg1:SetAttribute(DoorConsts_upvr.EASING_STYLE_ATTR_NAME, arg2.Name)
end
return module_upvr