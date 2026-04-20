local module_2_upvr = {}
local var2_upvr = require(script.Internal)(module_2_upvr)
module_2_upvr.Disabled = false
module_2_upvr.Args = {}
module_2_upvr.Events = {}
function module_2_upvr.Init(arg1, arg2, arg3) -- Line 73
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var12
    if var2_upvr._shutdown ~= false then
        var12 = false
    else
        var12 = true
    end
    assert(var12, "Iris.Init() cannot be called once shutdown.")
    var12 = true
    if var2_upvr._started ~= false then
        if arg3 ~= true then
            var12 = false
        else
            var12 = true
        end
    end
    assert(var12, "Iris.Init() can only be called once.")
    if var2_upvr._started then
        return module_2_upvr
    end
    if arg1 == nil then
    end
    if arg2 == nil then
    end
    var2_upvr.parentInstance = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    var12 = true
    var2_upvr._started = var12
    var2_upvr._generateRootInstance()
    var2_upvr._generateSelectionImageObject()
    var12 = nil
    for _, v in var2_upvr._initFunctions, var12 do
        v()
    end
    local Heartbeat_upvw = game:GetService("RunService").Heartbeat
    function var12() -- Line 100
        if typeof(Heartbeat_upvw) == "function" then
            if var2_upvr._started then
                var2_upvr._cycle(Heartbeat_upvw())
                -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
            end
        elseif Heartbeat_upvw ~= nil and Heartbeat_upvw ~= false then
            var2_upvr._eventConnection = Heartbeat_upvw:Connect(function(...) -- Line 107
                var2_upvr._cycle(...)
            end)
        end
    end
    task.spawn(var12)
    return module_2_upvr
end
function module_2_upvr.Shutdown() -- Line 122
    var2_upvr._started = false
    var2_upvr._shutdown = true
    if var2_upvr._eventConnection then
        var2_upvr._eventConnection:Disconnect()
    end
    var2_upvr._eventConnection = nil
    if var2_upvr._rootWidget then
        if var2_upvr._rootWidget.Instance then
            var2_upvr._widgets.Root.Discard(var2_upvr._rootWidget)
        end
        var2_upvr._rootInstance = nil
    end
    if var2_upvr.SelectionImageObject then
        var2_upvr.SelectionImageObject:Destroy()
    end
    for _, v_2 in var2_upvr._connections do
        v_2:Disconnect()
    end
end
function module_2_upvr.Connect(arg1, arg2) -- Line 159
    if var2_upvr._started == false then
        warn("Iris:Connect() was called before calling Iris.Init(); always initialise Iris first.")
    end
    local var17_upvr = #var2_upvr._connectedFunctions + 1
    var2_upvr._connectedFunctions[var17_upvr] = arg2
    return function() -- Line 165
        var2_upvr._connectedFunctions[var17_upvr] = nil
    end
end
function module_2_upvr.Append(arg1) -- Line 180
    local any__GetParentWidget_result1 = var2_upvr._GetParentWidget()
    local var20
    if var2_upvr._config.Parent then
        var20 = var2_upvr._config.Parent
    else
        var20 = var2_upvr._widgets[any__GetParentWidget_result1.type].ChildAdded(any__GetParentWidget_result1, {
            type = "userInstance";
        })
    end
    arg1.Parent = var20
end
function module_2_upvr.End() -- Line 218
    if var2_upvr._stackIndex == 1 then
        error("Too many calls to Iris.End().", 2)
    end
    var2_upvr._IDStack[var2_upvr._stackIndex] = nil
    local var22 = var2_upvr
    var22._stackIndex -= 1
end
function module_2_upvr.ForceRefresh() -- Line 243
    var2_upvr._globalRefreshRequested = true
end
function module_2_upvr.UpdateGlobalConfig(arg1) -- Line 265
    for i_3, v_3 in arg1 do
        var2_upvr._rootConfig[i_3] = v_3
    end
    module_2_upvr.ForceRefresh()
end
function module_2_upvr.PushConfig(arg1) -- Line 290
    local any_State_result1 = module_2_upvr.State(-1)
    if any_State_result1.value == -1 then
        any_State_result1:set(arg1)
    elseif var2_upvr._deepCompare(any_State_result1:get(), arg1) == false then
        any_State_result1:set(arg1)
        var2_upvr._refreshStack[var2_upvr._refreshLevel] = true
        local var26 = var2_upvr
        var26._refreshCounter += 1
    end
    local var27 = var2_upvr
    var27._refreshLevel += 1
    var2_upvr._config = setmetatable(arg1, {
        __index = var2_upvr._config;
    })
end
function module_2_upvr.PopConfig() -- Line 318
    local var29 = var2_upvr
    var29._refreshLevel -= 1
    if var2_upvr._refreshStack[var2_upvr._refreshLevel] == true then
        local var30 = var2_upvr
        var30._refreshCounter -= 1
        var2_upvr._refreshStack[var2_upvr._refreshLevel] = nil
    end
    var2_upvr._config = getmetatable(var2_upvr._config).__index
end
module_2_upvr.TemplateConfig = require(script.config)
module_2_upvr.UpdateGlobalConfig(module_2_upvr.TemplateConfig.colorDark)
module_2_upvr.UpdateGlobalConfig(module_2_upvr.TemplateConfig.sizeDefault)
module_2_upvr.UpdateGlobalConfig(module_2_upvr.TemplateConfig.utilityDefault)
var2_upvr._globalRefreshRequested = false
function module_2_upvr.PushId(arg1) -- Line 354
    local var31
    if typeof(arg1) ~= "string" then
        var31 = false
    else
        var31 = true
    end
    assert(var31, "The ID argument to Iris.PushId() to be a string.")
    var31 = true
    var2_upvr._newID = var31
    var31 = var2_upvr
    var31 = var31._pushedIds
    table.insert(var31, arg1)
end
function module_2_upvr.PopId() -- Line 367
    if #var2_upvr._pushedIds == 0 then
    else
        table.remove(var2_upvr._pushedIds)
    end
end
function module_2_upvr.SetNextWidgetID(arg1) -- Line 397
    var2_upvr._nextWidgetId = arg1
end
function module_2_upvr.State(arg1) -- Line 439
    local any__getID_result1_5 = var2_upvr._getID(2)
    if var2_upvr._states[any__getID_result1_5] then
        return var2_upvr._states[any__getID_result1_5]
    end
    local module_6 = {
        ID = any__getID_result1_5;
    }
    module_6.value = arg1
    module_6.lastChangeTick = module_2_upvr.Internal._cycleTick
    module_6.ConnectedWidgets = {}
    module_6.ConnectedFunctions = {}
    setmetatable(module_6, var2_upvr.StateClass)
    var2_upvr._states[any__getID_result1_5] = module_6
    return module_6
end
function module_2_upvr.WeakState(arg1) -- Line 465
    local any__getID_result1 = var2_upvr._getID(2)
    if var2_upvr._states[any__getID_result1] then
        if next(var2_upvr._states[any__getID_result1].ConnectedWidgets) == nil then
            var2_upvr._states[any__getID_result1] = nil
        else
            return var2_upvr._states[any__getID_result1]
        end
    end
    local module = {
        ID = any__getID_result1;
    }
    module.value = arg1
    module.lastChangeTick = module_2_upvr.Internal._cycleTick
    module.ConnectedWidgets = {}
    module.ConnectedFunctions = {}
    setmetatable(module, var2_upvr.StateClass)
    var2_upvr._states[any__getID_result1] = module
    return module
end
function module_2_upvr.VariableState(arg1, arg2) -- Line 524
    local any__getID_result1_4 = var2_upvr._getID(2)
    local var37 = var2_upvr._states[any__getID_result1_4]
    if var37 then
        if arg1 ~= var37.value then
            var37:set(arg1)
        end
        return var37
    end
    local module_4 = {
        ID = any__getID_result1_4;
    }
    module_4.value = arg1
    module_4.lastChangeTick = module_2_upvr.Internal._cycleTick
    module_4.ConnectedWidgets = {}
    module_4.ConnectedFunctions = {}
    setmetatable(module_4, var2_upvr.StateClass)
    var2_upvr._states[any__getID_result1_4] = module_4
    module_4:onChange(arg2)
    return module_4
end
function module_2_upvr.TableState(arg1, arg2, arg3) -- Line 604
    local var39 = arg1[arg2]
    local any__getID_result1_3 = var2_upvr._getID(2)
    local var41 = var2_upvr._states[any__getID_result1_3]
    if var41 then
        if var39 ~= var41.value then
            var41:set(var39)
        end
        return var41
    end
    local module_3_upvr = {
        ID = any__getID_result1_3;
        value = var39;
        lastChangeTick = module_2_upvr.Internal._cycleTick;
        ConnectedWidgets = {};
        ConnectedFunctions = {};
    }
    setmetatable(module_3_upvr, var2_upvr.StateClass)
    var2_upvr._states[any__getID_result1_3] = module_3_upvr
    module_3_upvr:onChange(function() -- Line 628
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        arg1[arg2] = module_3_upvr.value
        do
            return
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        arg1[arg2] = module_3_upvr.value
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    end)
    return module_3_upvr
end
function module_2_upvr.ComputedState(arg1, arg2) -- Line 657
    local any__getID_result1_2 = var2_upvr._getID(2)
    if var2_upvr._states[any__getID_result1_2] then
        return var2_upvr._states[any__getID_result1_2]
    end
    local module_5_upvr = {
        ID = any__getID_result1_2;
        value = arg2(arg1.value);
        lastChangeTick = module_2_upvr.Internal._cycleTick;
        ConnectedWidgets = {};
        ConnectedFunctions = {};
    }
    setmetatable(module_5_upvr, var2_upvr.StateClass)
    var2_upvr._states[any__getID_result1_2] = module_5_upvr
    arg1:onChange(function(arg1_2) -- Line 673
        module_5_upvr:set(arg2(arg1_2))
    end)
    return module_5_upvr
end
module_2_upvr.ShowDemoWindow = require(script.demoWindow)(module_2_upvr)
require(script.widgets)(var2_upvr)
require(script.API)(module_2_upvr)
return module_2_upvr