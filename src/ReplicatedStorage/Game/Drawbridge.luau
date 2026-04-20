local RunService_upvr = game:GetService("RunService")
local function _(arg1) -- Line 5, Named "Ease_InOutQuad"
    local var2
    local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
        var2 = 2 * arg1 * arg1
        return var2
    end
    if arg1 >= 0.5 or not decompInlinedCondition() then
        var2 = -1 - 2 * (arg1 - 2) * arg1
    end
    return var2
end
local tbl_upvr = {}
tbl_upvr.__index = tbl_upvr
function tbl_upvr.new(arg1, arg2) -- Line 11
    if arg1 == nil then
    else
    end
    assert(true)
    if arg2 == nil then
    else
    end
    assert(true)
    local module = {}
    setmetatable(module, tbl_upvr)
    module.HingeCF = arg2.CFrame
    module.Model = arg1
    module.Model.PrimaryPart = arg2
    module.Event = nil
    module.Angle = 0
    return module
end
function tbl_upvr.AnimateToAngle(arg1, arg2, arg3) -- Line 27
    if arg2 == nil then
    else
    end
    assert(true)
    if arg3 == nil then
    else
    end
    assert(true)
    if arg1.Event ~= nil then
        arg1.Event:Disconnect()
        arg1.Event = nil
    end
    local tick_result1_upvr = tick()
    local Angle_upvr = arg1.Angle
    arg1.Event = RunService_upvr.Heartbeat:Connect(function() -- Line 37
        local var8 = (tick() - tick_result1_upvr) / arg3
        if 1 < var8 then
            var8 = 1
            arg1.Event:Disconnect()
            arg1.Event = nil
        end
        local var9 = var8
        local function decompInlinedCondition_2() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
            var8 = 2 * var9 * var9
            return var8
        end
        if var9 >= 0.5 or not decompInlinedCondition_2() then
            var8 = -1 - 2 * (var9 - 2) * var9
        end
        arg1.Angle = Angle_upvr * (1 - var8) + arg2 * var8
        arg1.Model:PivotTo(arg1.HingeCF * CFrame.Angles(arg1.Angle, 0, 0))
    end)
end
local module_2_upvr = {}
local RunUtils_upvr = require(game:GetService("ReplicatedStorage").App.RunUtils)
function module_2_upvr._initSpawned(arg1) -- Line 53
    arg1.Model = workspace:WaitForChild("Drawbridge", 5)
    if arg1.Model == nil then
        if RunUtils_upvr.isMainWorld() and not RunService_upvr:IsStudio() then
            error("Missing `Drawbridge` in Workspace.")
        else
            return
        end
    end
    arg1.Door0 = tbl_upvr.new(arg1.Model.Model.RoadA.Bridge, arg1.Model.Model.RoadA.Hinge)
end
function module_2_upvr.Init(arg1) -- Line 66
    task.spawn(module_2_upvr._initSpawned, module_2_upvr)
    arg1.em.fehikwrk = function(arg1_2) -- Line 71, Named "fehikwrk"
        if arg1_2 then
            module_2_upvr.Open()
        else
            module_2_upvr.Close()
        end
    end
end
function module_2_upvr.Open() -- Line 79
    module_2_upvr.Door0:AnimateToAngle(0.9424777960769379, 10)
end
function module_2_upvr.Close() -- Line 83
    module_2_upvr.Door0:AnimateToAngle(0, 10)
end
return module_2_upvr