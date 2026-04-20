local Signal_upvr = require(game:GetService("ReplicatedStorage").Std.Signal)
local function _(arg1, arg2) -- Line 16, Named "isManifestResolved"
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    local var6 = 0
    for _ in pairs(arg1) do
        var6 += 1
    end
    if var6 > arg2 then
        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    assert(true, var6)
    if var6 ~= arg2 then
    else
    end
    do
        return true
    end
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
end
local function unbindNodeDescend_upvr(arg1, arg2) -- Line 26, Named "unbindNodeDescend"
    if arg1.instance == nil then
    else
        arg1.instance = nil
        local connections = arg1.connections
        if connections then
            for _, v_7 in ipairs(connections) do
                v_7:Disconnect()
            end
            table.clear(connections)
        end
        if arg2 and arg1.alias then
            arg2[arg1.alias] = nil
        end
        local children = arg1.children
        if children then
            for _, v_8 in pairs(children) do
                unbindNodeDescend_upvr(v_8, arg2)
            end
        end
    end
end
local module_upvr = {}
module_upvr.__index = module_upvr
function module_upvr.new(arg1, arg2, arg3) -- Line 56
    local module_2_upvr = {}
    setmetatable(module_2_upvr, module_upvr)
    local var26 = arg1
    if not var26 then
        var26 = error("Bad argument 'tagName', expected string")
    end
    module_2_upvr._tagName = var26
    var26 = arg2
    local var27 = var26
    if not var27 then
        var27 = error("Bad argument `manifest`, expected table")
    end
    module_2_upvr._manifest = var27
    var27 = arg3
    local var28 = var27
    if not var28 then
        var28 = error("Bad argument `constructor`, expected table or function")
    end
    module_2_upvr._constructor = var28
    module_2_upvr._connections = {}
    module_2_upvr._rootInstToClass = {}
    module_2_upvr._rootInstToRootNode = {}
    module_2_upvr._rootInstToManifest = {}
    module_2_upvr._pendingRootInstSet = {}
    module_2_upvr._listeners = {}
    for _ in pairs(arg2) do
        local var32
    end
    module_2_upvr._manifestSizeTarget = var32
    task.delay(5, function() -- Line 77
        if not module_2_upvr._loaded then
            warn("ManifestBinder %q is not loaded. Call :Start() on it!":format(module_2_upvr._tagName))
        end
    end)
    return module_2_upvr
end
local CollectionService_upvr = game:GetService("CollectionService")
function module_upvr.Start(arg1) -- Line 85
    if arg1._loaded then
        warn("ManifestBinder already loaded.")
    else
        arg1._loaded = true
        for _, v_9 in ipairs(CollectionService_upvr:GetTagged(arg1._tagName)) do
            task.spawn(arg1._bindRoot, arg1, v_9)
        end
        table.insert(arg1._connections, CollectionService_upvr:GetInstanceAddedSignal(arg1._tagName):Connect(function(arg1_2) -- Line 98
            arg1:_bindRoot(arg1_2)
        end))
        table.insert(arg1._connections, CollectionService_upvr:GetInstanceRemovedSignal(arg1._tagName):Connect(function(arg1_3) -- Line 104
            arg1:_unbindRoot(arg1_3)
        end))
    end
end
function module_upvr._stopBoundFn(arg1, arg2) -- Line 109
    local var44 = arg1._rootInstToClass[arg2]
    if var44 then
        if arg1._classRemovingSignal then
            arg1._classRemovingSignal:Fire(var44, arg2)
        end
        local var45 = arg1._listeners[arg2]
        if var45 then
            for i_3, _ in pairs(var45) do
                task.spawn(i_3, nil)
            end
        end
        if var44.Destroy then
            var44:Destroy()
        else
            warn("[ManifestBinder._remove] - Class %q no longer has destroy, something destroyed it!":format(tostring(arg1._tagName)))
        end
        arg1._rootInstToClass[arg2] = nil
    end
end
function module_upvr._startBoundFn(arg1, arg2, arg3) -- Line 135
    -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    arg1:_stopBoundFn(arg2)
    local var53
    if var53 == true then
        var53 = warn
        var53("[ManifestBinder._startBoundFn] - Re-entered add. Still loading, probably caused by error in constructor.")
    else
        var53 = arg1._pendingRootInstSet
        var53[arg2] = true
        var53 = nil
        if typeof(arg1._constructor) == "function" then
            var53 = arg1._constructor(arg2, arg3)
            -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        if arg1._constructor.new then
            var53 = arg1._constructor.new(arg2, arg3)
        else
            error("Invalid constructor, expected table or function")
        end
        local var54
        if arg1._pendingRootInstSet[arg2] ~= true then
            local function decompInlinedCondition() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                var54 = var54.ClassName
                var54 = arg1._constructor
                return var54
            end
            if type(arg1._constructor) ~= "table" or not decompInlinedCondition() then
                var54 = arg1._constructor
            end
            warn("[ManifestBinder._startBoundFn] - Failed to load instance %q of %q, removed while loading!":format(arg2:GetFullName(), tostring(var54)))
            return
        end
        arg1._pendingRootInstSet[arg2] = nil
        if typeof(var53) ~= "table" or typeof(var53.Destroy) ~= "function" then
            warn("[ManifestBinder._startBoundFn] - Bad class constructed for tag %q":format(arg1._tagName))
            return
        end
        arg1._rootInstToClass[arg2] = var53
        local var55 = arg1._listeners[arg2]
        if var55 then
            for i_12, _ in pairs(var55) do
                task.spawn(i_12, var53)
            end
        end
        if arg1._classAddedSignal then
            arg1._classAddedSignal:Fire(var53, arg2)
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    end
end
local parsePath_upvr = require(script.parsePath)
function module_upvr._bindRoot(arg1, arg2) -- Line 186
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var76
    if arg1._rootInstToManifest[arg2] ~= nil then
        var76 = false
    else
        var76 = true
    end
    assert(var76)
    local tbl_2_upvr = {}
    var76 = arg1._rootInstToManifest
    var76[arg2] = tbl_2_upvr
    var76 = debug.profilebegin
    var76("initializeBoundTree")
    var76 = {}
    var76.alias = "root"
    var76.instance = arg2
    if next(arg1._manifest) then
        var76.children = {}
        var76.connections = {}
    end
    arg1._rootInstToRootNode[arg2] = var76
    for i_4, v_2 in pairs(arg1._manifest) do
        local parsePath_upvr_result1 = parsePath_upvr(v_2)
        local var82 = var76
        for i_5, v_3 in ipairs(parsePath_upvr_result1) do
            local var86
            if i_5 ~= #parsePath_upvr_result1 then
                var86 = false
            else
                var86 = true
            end
            if not var82.children[v_3] then
                local tbl = {}
                local var88
            end
            if var86 then
                var88 = tbl.alias
                if var88 ~= nil then
                    var88 = error
                    var88("Multiple aliases assigned to one instance")
                end
                tbl.alias = i_4
            else
                var88 = tbl.children
                if not var88 then
                    var88 = {}
                end
                tbl.children = var88
                var88 = tbl.connections
                if not var88 then
                    var88 = {}
                end
                tbl.connections = var88
            end
            var82.children[v_3] = tbl
        end
    end
    debug.profileend()
    local function processNode_upvr(arg1_4) -- Line 232, Named "processNode"
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        local alias = arg1_4.alias
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        tbl_2_upvr[alias] = assert(arg1_4.instance)
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    end
    processNode_upvr(var76)
end
function module_upvr._unbindRoot(arg1, arg2) -- Line 305
    arg1:_stopBoundFn(arg2)
    local var90 = arg1._rootInstToRootNode[arg2]
    if var90 then
        unbindNodeDescend_upvr(var90, assert(arg1._rootInstToManifest[arg2]))
        arg1._rootInstToRootNode[arg2] = nil
    end
    arg1._rootInstToManifest[arg2] = nil
end
function module_upvr.GetAllSet(arg1) -- Line 317
    return arg1._rootInstToClass
end
function module_upvr.GetAll(arg1) -- Line 321
    local module = {}
    for _, v_4 in pairs(arg1._rootInstToClass) do
        module[#module + 1] = v_4
    end
    return module
end
function module_upvr.GetTag(arg1) -- Line 328
    return arg1._tagName
end
function module_upvr.Get(arg1, arg2) -- Line 331
    return arg1._rootInstToClass[arg2]
end
local promiseBoundClass_upvr = require(script.promiseBoundClass)
function module_upvr.Promise(arg1, arg2) -- Line 334
    return promiseBoundClass_upvr(arg1, arg2)
end
function module_upvr.ObserveInstance(arg1, arg2, arg3) -- Line 338
    local var100 = arg1._listeners[arg2]
    if not var100 then
        var100 = {}
    end
    arg1._listeners[arg2] = var100
    arg1._listeners[arg2][arg3] = true
    return function() -- Line 342
        if not arg1._listeners[arg2] then
        else
            arg1._listeners[arg2][arg3] = nil
            if not next(arg1._listeners[arg2]) then
                arg1._listeners[arg2] = nil
            end
        end
    end
end
function module_upvr.GetClassAddedSignal(arg1) -- Line 353
    if arg1._classAddedSignal then
        return arg1._classAddedSignal
    end
    arg1._classAddedSignal = Signal_upvr.new()
    table.insert(arg1._connections, arg1._classAddedSignal)
    return arg1._classAddedSignal
end
function module_upvr.GetClassRemovingSignal(arg1) -- Line 364
    if arg1._classRemovingSignal then
        return arg1._classRemovingSignal
    end
    arg1._classRemovingSignal = Signal_upvr.new()
    table.insert(arg1._connections, arg1._classRemovingSignal)
    return arg1._classRemovingSignal
end
function module_upvr.Destroy(arg1) -- Line 374
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    debug.profilebegin("ManifestBinder:Destroy")
    local next_result1 = next(arg1._rootInstToClass)
    local var119
    while next_result1 ~= nil do
        arg1:_stopBoundFn(next_result1)
        if arg1._rootInstToClass[next_result1] ~= nil then
            var119 = false
        else
            var119 = true
        end
        assert(var119, "Failed to remove")
        var119 = arg1._rootInstToClass
    end
    table.clear(arg1._rootInstToClass)
    for _, v_5 in ipairs(arg1._connections) do
        v_5:Disconnect()
    end
    table.clear(arg1._connections)
    for i_8, v_6 in pairs(arg1._rootInstToRootNode) do
        unbindNodeDescend_upvr(v_6, assert(arg1._rootInstToManifest[i_8]))
        local _
    end
    table.clear(arg1._rootInstToManifest)
    table.clear(arg1._rootInstToRootNode)
    debug.profileend()
end
return module_upvr