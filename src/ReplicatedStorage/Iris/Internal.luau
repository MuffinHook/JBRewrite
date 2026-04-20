return function(arg1) -- Line 3
    local module_upvr = {
        _version = " 2.5.0 ";
        _started = false;
        _shutdown = false;
        _cycleTick = 0;
        _deltaTime = 0;
        _globalRefreshRequested = false;
        _refreshCounter = 0;
        _refreshLevel = 1;
        _refreshStack = table.create(16);
        _widgets = {};
        _stackIndex = 1;
        _rootInstance = nil;
        _rootWidget = {
            ID = 'R';
            type = "Root";
            Instance = module_upvr._rootInstance;
            ZIndex = 0;
            ZOffset = 0;
        };
        _lastWidget = module_upvr._rootWidget;
        _rootConfig = {};
        _config = module_upvr._rootConfig;
        _IDStack = {'R'};
        _usedIDs = {};
        _pushedIds = {};
        _newID = false;
        _nextWidgetId = nil;
        _states = {};
        _postCycleCallbacks = {};
        _connectedFunctions = {};
        _connections = {};
        _initFunctions = {};
        _fullErrorTracebacks = game:GetService("RunService"):IsStudio();
        _cycleCoroutine = coroutine.create(function() -- Line 73
            while module_upvr._started do
                for _, v in module_upvr._connectedFunctions do
                    debug.profilebegin("Iris/Connection")
                    local pcall_result1, pcall_result2 = pcall(v)
                    debug.profileend()
                    if not pcall_result1 then
                        module_upvr._stackIndex = 1
                        coroutine.yield(false, pcall_result2)
                    end
                end
                coroutine.yield(true)
            end
        end);
    }
    local tbl = {}
    tbl.__index = tbl
    function tbl.get(arg1_2) -- Line 131
        return arg1_2.value
    end
    function tbl.set(arg1_3, arg2, arg3) -- Line 144
        if arg2 == arg1_3.value and arg3 ~= true then
            return arg1_3.value
        end
        arg1_3.value = arg2
        arg1_3.lastChangeTick = arg1.Internal._cycleTick
        for _, v_2 in arg1_3.ConnectedWidgets do
            if v_2.lastCycleTick ~= -1 then
                module_upvr._widgets[v_2.type].UpdateState(v_2)
            end
        end
        for _, v_3 in arg1_3.ConnectedFunctions do
            v_3(arg2)
        end
        return arg1_3.value
    end
    function tbl.onChange(arg1_4, arg2) -- Line 176
        local var15_upvr = #arg1_4.ConnectedFunctions + 1
        arg1_4.ConnectedFunctions[var15_upvr] = arg2
        return function() -- Line 179
            arg1_4.ConnectedFunctions[var15_upvr] = nil
        end
    end
    function tbl.changed(arg1_5) -- Line 191
        local var17
        if arg1_5.lastChangeTick + 1 ~= module_upvr._cycleTick then
            var17 = false
        else
            var17 = true
        end
        return var17
    end
    module_upvr.StateClass = tbl
    function module_upvr._cycle(arg1_6) -- Line 209
        if arg1.Disabled then
        else
            module_upvr._rootWidget.lastCycleTick = module_upvr._cycleTick
            if module_upvr._rootInstance == nil or module_upvr._rootInstance.Parent == nil then
                arg1.ForceRefresh()
            end
            for _, v_16 in module_upvr._lastVDOM do
                if v_16.lastCycleTick ~= module_upvr._cycleTick and v_16.lastCycleTick ~= -1 then
                    module_upvr._DiscardWidget(v_16)
                end
            end
            setmetatable(module_upvr._lastVDOM, {
                __mode = "kv";
            })
            module_upvr._lastVDOM = module_upvr._VDOM
            module_upvr._VDOM = module_upvr._generateEmptyVDOM()
            task.spawn(function() -- Line 235
                for _, v_17 in module_upvr._postCycleCallbacks do
                    v_17()
                end
            end)
            if module_upvr._globalRefreshRequested then
                module_upvr._generateSelectionImageObject()
                module_upvr._globalRefreshRequested = false
                for _, v_18 in module_upvr._lastVDOM do
                    module_upvr._DiscardWidget(v_18)
                end
                module_upvr._generateRootInstance()
                module_upvr._lastVDOM = module_upvr._generateEmptyVDOM()
            end
            local var34 = module_upvr
            var34._cycleTick += 1
            module_upvr._deltaTime = arg1_6
            table.clear(module_upvr._usedIDs)
            local children = module_upvr.parentInstance:IsA("GuiBase2d")
            if not children then
                children = module_upvr
                children = children.parentInstance:IsA("BasePlayerGui")
            end
            if children == false then
                error("The Iris parent instance will not display any GUIs.")
            end
            if module_upvr._fullErrorTracebacks then
                for _, v_19 in module_upvr._connectedFunctions do
                    v_19()
                end
                -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
            end
            local coroutine_status_result1 = coroutine.status(module_upvr._cycleCoroutine)
            if coroutine_status_result1 == "suspended" then
                local _, coroutine_resume_result2, _ = coroutine.resume(module_upvr._cycleCoroutine)
                if coroutine_resume_result2 == false then
                    error(v_18, 0)
                    -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
                end
            elseif coroutine_status_result1 == "running" then
                error("Iris cycleCoroutine took to long to yield. Connected functions should not yield.")
            else
                error("unrecoverable state")
            end
            if module_upvr._stackIndex ~= 1 then
                module_upvr._stackIndex = 1
                error("Too few calls to Iris.End().", 0)
            end
            if #module_upvr._pushedIds ~= 0 then
                error("Too few calls to Iris.PopId().", 0)
            end
        end
    end
    function module_upvr._NoOp() -- Line 322
    end
    function module_upvr.WidgetConstructor(arg1_7, arg2) -- Line 336
        local tbl_4 = {
            All = {
                Required = {"Generate", "Discard", "Update", "Args", "Events", "hasChildren", "hasState"};
                Optional = {};
            };
            IfState = {
                Required = {"GenerateState", "UpdateState"};
                Optional = {};
            };
            IfChildren = {
                Required = {"ChildAdded"};
                Optional = {"ChildDiscarded"};
            };
        }
        local tbl_5 = {}
        for _, v_4 in tbl_4.All.Required do
            local var81
            if arg2[v_4] == nil then
                var81 = false
            else
                var81 = true
            end
            assert(var81, `field {v_4} is missing from widget {arg1_7}, it is required for all widgets`)
            tbl_5[v_4] = arg2[v_4]
        end
        for _, v_5 in tbl_4.All.Optional do
            if arg2[v_5] == nil then
                tbl_5[v_5] = module_upvr._NoOp
            else
                tbl_5[v_5] = arg2[v_5]
            end
        end
        if arg2.hasState then
            for _, v_6 in tbl_4.IfState.Required do
                if arg2[v_6] == nil then
                    var81 = false
                else
                    var81 = true
                end
                assert(var81, `field {v_6} is missing from widget {arg1_7}, it is required for all widgets with state`)
                tbl_5[v_6] = arg2[v_6]
            end
            for _, v_7 in tbl_4.IfState.Optional do
                if arg2[v_7] == nil then
                    tbl_5[v_7] = module_upvr._NoOp
                else
                    tbl_5[v_7] = arg2[v_7]
                end
            end
        end
        if arg2.hasChildren then
            for _, v_8 in tbl_4.IfChildren.Required do
                if arg2[v_8] == nil then
                    var81 = false
                else
                    var81 = true
                end
                assert(var81, `field {v_8} is missing from widget {arg1_7}, it is required for all widgets with children`)
                tbl_5[v_8] = arg2[v_8]
            end
            for _, v_9 in tbl_4.IfChildren.Optional do
                if arg2[v_9] == nil then
                    tbl_5[v_9] = module_upvr._NoOp
                else
                    tbl_5[v_9] = arg2[v_9]
                end
            end
        end
        module_upvr._widgets[arg1_7] = tbl_5
        arg1.Args[arg1_7] = tbl_5.Args
        for i_10, v_10 in tbl_5.Args do
            ({})[v_10] = i_10
            local var83
        end
        tbl_5.ArgNames = var83
        for i_11_upvr, _ in tbl_5.Events do
            if arg1.Events[i_11_upvr] == nil then
                arg1.Events[i_11_upvr] = function() -- Line 427
                    return module_upvr._EventCall(module_upvr._lastWidget, i_11_upvr)
                end
            end
        end
    end
    function module_upvr._Insert(arg1_8, arg2, arg3) -- Line 445
        -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
        local any__getID_result1 = module_upvr._getID(3)
        local var111 = module_upvr._widgets[arg1_8]
        if module_upvr._VDOM[any__getID_result1] then
            return module_upvr._ContinueWidget(any__getID_result1, arg1_8)
        end
        local tbl_6 = {}
        local var113
        if var113 ~= nil then
            if type(var113) ~= "table" then
                var113 = {var113}
            end
            for i_12, v_12 in var113 do
                local var115
                if 0 >= i_12 then
                    var115 = false
                else
                    var115 = true
                end
                assert(var115, `Widget Arguments must be a positive number, not {i_12} of type {typeof(i_12)} for {v_12}.`)
                var115 = var111.ArgNames
                tbl_6[var115[i_12]] = v_12
            end
        end
        table.freeze(tbl_6)
        local var116 = module_upvr._lastVDOM[any__getID_result1]
        if var116 and arg1_8 == var116.type and 0 < module_upvr._refreshCounter then
            module_upvr._DiscardWidget(var116)
            var116 = nil
        end
        if var116 == nil then
            i_12 = tbl_6
            v_12 = arg3
            local _ = module_upvr._GenNewWidget(arg1_8, i_12, v_12, any__getID_result1)
        else
        end
        local parentWidget = var116.parentWidget
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        i_12 = var116.type
        if i_12 ~= "Window" then
            -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
            i_12 = var116.type
            if i_12 ~= "Tooltip" then
                -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                i_12 = var116.ZIndex
                v_12 = parentWidget.ZOffset
                if i_12 ~= v_12 then
                    i_12 = true
                    parentWidget.ZUpdate = i_12
                end
                i_12 = parentWidget.ZUpdate
                if i_12 then
                    i_12 = parentWidget.ZOffset
                    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                    var116.ZIndex = i_12
                    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                    i_12 = var116.Instance
                    if i_12 then
                        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                        i_12 = var116.Instance
                        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                        v_12 = var116.ZIndex
                        i_12.ZIndex = v_12
                        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                        i_12 = var116.Instance
                        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                        v_12 = var116.ZIndex
                        i_12.LayoutOrder = v_12
                    end
                end
            end
        end
        i_12 = parentWidget.type
        if i_12 == "Table" then
            i_12 = parentWidget._rowCycles
            v_12 = parentWidget._rowIndex
            i_12[v_12] = module_upvr._cycleTick
        end
        i_12 = module_upvr
        i_12 = i_12._deepCompare
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        v_12 = var116.providedArguments
        i_12 = i_12(v_12, tbl_6)
        if i_12 == false then
            i_12 = module_upvr
            i_12 = i_12._deepCopy
            v_12 = tbl_6
            i_12 = i_12(v_12)
            -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
            var116.arguments = i_12
            -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
            var116.providedArguments = tbl_6
            i_12 = var111.Update
            v_12 = var116
            i_12(v_12)
        end
        i_12 = module_upvr
        i_12 = i_12._cycleTick
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        var116.lastCycleTick = i_12
        i_12 = parentWidget.ZOffset
        i_12 += 1
        parentWidget.ZOffset = i_12
        i_12 = var111.hasChildren
        if i_12 then
            i_12 = 0
            -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
            var116.ZOffset = i_12
            i_12 = false
            -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
            var116.ZUpdate = i_12
            i_12 = module_upvr
            v_12 = i_12._stackIndex
            v_12 += 1
            i_12._stackIndex = v_12
            i_12 = module_upvr
            i_12 = i_12._IDStack
            v_12 = module_upvr
            v_12 = v_12._stackIndex
            -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
            i_12[v_12] = var116.ID
        end
        i_12 = module_upvr
        i_12 = i_12._VDOM
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        i_12[any__getID_result1] = var116
        i_12 = module_upvr
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        i_12._lastWidget = var116
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        return var116
    end
    function module_upvr._GenNewWidget(arg1_9, arg2, arg3, arg4) -- Line 546
        -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
        local var135 = module_upvr._VDOM[module_upvr._IDStack[module_upvr._stackIndex]]
        local var136 = module_upvr._widgets[arg1_9]
        local module_2_upvr = {}
        setmetatable(module_2_upvr, module_2_upvr)
        module_2_upvr.ID = arg4
        module_2_upvr.type = arg1_9
        module_2_upvr.parentWidget = var135
        module_2_upvr.trackedEvents = {}
        module_2_upvr.ZIndex = var135.ZOffset
        module_2_upvr.Instance = var136.Generate(module_2_upvr)
        local parentWidget_3 = module_2_upvr.parentWidget
        local var139
        if var139 then
            var139 = module_2_upvr.Instance
            var139.Parent = module_upvr._config.Parent
        else
            var139 = module_2_upvr.Instance
            var139.Parent = module_upvr._widgets[parentWidget_3.type].ChildAdded(parentWidget_3, module_2_upvr)
        end
        module_2_upvr.providedArguments = arg2
        var139 = module_upvr
        var139 = var139._deepCopy(arg2)
        module_2_upvr.arguments = var139
        var139 = var136.Update
        var139(module_2_upvr)
        var139 = nil
        if var136.hasState then
            if arg3 then
                for i_13, v_13 in arg3 do
                    if type(v_13) ~= "table" or getmetatable(v_13) ~= module_upvr.StateClass then
                        arg3[i_13] = module_upvr._widgetState(module_2_upvr, i_13, v_13)
                    end
                    arg3[i_13].lastChangeTick = module_upvr._cycleTick
                end
                module_2_upvr.state = arg3
                for _, v_14 in arg3 do
                    v_14.ConnectedWidgets[module_2_upvr.ID] = module_2_upvr
                end
            else
                module_2_upvr.state = {}
            end
            var136.GenerateState(module_2_upvr)
            var136.UpdateState(module_2_upvr)
            module_2_upvr.stateMT = {}
            setmetatable(module_2_upvr.state, module_2_upvr.stateMT)
            module_2_upvr.__index = module_2_upvr.state
            var139 = module_2_upvr.stateMT
        else
            var139 = module_2_upvr
        end
        function var139.__index(arg1_10, arg2_2) -- Line 612
            return function() -- Line 613
                return module_upvr._EventCall(module_2_upvr, arg2_2)
            end
        end
        return module_2_upvr
    end
    function module_upvr._ContinueWidget(arg1_11, arg2) -- Line 631
        local var142 = module_upvr._VDOM[arg1_11]
        if module_upvr._widgets[arg2].hasChildren then
            local var143 = module_upvr
            var143._stackIndex += 1
            module_upvr._IDStack[module_upvr._stackIndex] = var142.ID
        end
        module_upvr._lastWidget = var142
        return var142
    end
    function module_upvr._DiscardWidget(arg1_12) -- Line 654
        local parentWidget_2 = arg1_12.parentWidget
        if parentWidget_2 then
            module_upvr._widgets[parentWidget_2.type].ChildDiscarded(parentWidget_2, arg1_12)
        end
        module_upvr._widgets[arg1_12.type].Discard(arg1_12)
        arg1_12.lastCycleTick = -1
    end
    function module_upvr._widgetState(arg1_13, arg2, arg3) -- Line 679
        local var145 = arg1_13.ID..arg2
        if module_upvr._states[var145] then
            module_upvr._states[var145].ConnectedWidgets[arg1_13.ID] = arg1_13
            module_upvr._states[var145].lastChangeTick = module_upvr._cycleTick
            return module_upvr._states[var145]
        end
        local module = {
            ID = var145;
        }
        module.value = arg3
        module.lastChangeTick = module_upvr._cycleTick
        local tbl_3 = {}
        tbl_3[arg1_13.ID] = arg1_13
        module.ConnectedWidgets = tbl_3
        module.ConnectedFunctions = {}
        setmetatable(module, module_upvr.StateClass)
        module_upvr._states[var145] = module
        return module
    end
    function module_upvr._EventCall(arg1_14, arg2) -- Line 709
        local var148 = module_upvr._widgets[arg1_14.type].Events[arg2]
        local var149
        if var148 == nil then
            var149 = false
        else
            var149 = true
        end
        assert(var149, `widget {arg1_14.type} has no event of name {arg2}`)
        var149 = arg1_14.trackedEvents
        if var149[arg2] == nil then
            var149 = arg1_14
            var148.Init(var149)
            var149 = true
            arg1_14.trackedEvents[arg2] = var149
        end
        var149 = arg1_14
        return var148.Get(var149)
    end
    function module_upvr._GetParentWidget() -- Line 728
        return module_upvr._VDOM[module_upvr._IDStack[module_upvr._stackIndex]]
    end
    function module_upvr._generateEmptyVDOM() -- Line 742
        return {
            R = module_upvr._rootWidget;
        }
    end
    function module_upvr._generateRootInstance() -- Line 755
        module_upvr._rootInstance = module_upvr._widgets.Root.Generate(module_upvr._widgets.Root)
        module_upvr._rootInstance.Parent = module_upvr.parentInstance
        module_upvr._rootWidget.Instance = module_upvr._rootInstance
    end
    function module_upvr._generateSelectionImageObject() -- Line 769
        if module_upvr.SelectionImageObject then
            module_upvr.SelectionImageObject:Destroy()
        end
        local Frame = Instance.new("Frame")
        Frame.Position = UDim2.fromOffset(-1, -1)
        Frame.Size = UDim2.new(1, 2, 1, 2)
        Frame.BackgroundColor3 = module_upvr._config.SelectionImageObjectColor
        Frame.BackgroundTransparency = module_upvr._config.SelectionImageObjectTransparency
        Frame.BorderSizePixel = 0
        module_upvr._utility.UIStroke(Frame, 1, module_upvr._config.SelectionImageObjectBorderColor, module_upvr._config.SelectionImageObjectBorderTransparency)
        module_upvr._utility.UICorner(Frame, 2)
        module_upvr.SelectionImageObject = Frame
    end
    function module_upvr._getID(arg1_15) -- Line 799
        -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
        local var152
        if module_upvr._nextWidgetId then
            var152 = module_upvr
            var152._nextWidgetId = nil
            return module_upvr._nextWidgetId
        end
        var152 = 1
        var152 = ""
        local line_defined = debug.info(var152 + (arg1_15 or 1), 'l')
        while line_defined ~= -1 and line_defined ~= nil do
            var152 = var152..'+'..line_defined
        end
        if module_upvr._usedIDs[var152] then
            local _usedIDs = module_upvr._usedIDs
            _usedIDs[var152] += 1
            -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        else
            module_upvr._usedIDs[var152] = 1
        end
        if #module_upvr._pushedIds == 0 then
            return var152..':'..1
        end
        if module_upvr._newID then
            module_upvr._newID = false
            return var152.."::"..table.concat(module_upvr._pushedIds, '\\')
        end
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        return var152..':'..1..':'..table.concat(module_upvr._pushedIds, '\\')
    end
    function module_upvr._deepCompare(arg1_16, arg2) -- Line 846
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
        -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [50.8]
        if nil == "table" then
            -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [50.7]
            if nil then
                -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                if nil == "table" then
                    -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                    if nil == false then
                        -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
                    end
                    -- Decomp Logic Error: Konstant emitted a synthetic goto marker; surrounding branch was preserved.
                end
            end
        else
            -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
            -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [50.9]
            local function decompInlinedCondition_2() -- Decomp Logic Error: Konstant emitted an inline condition helper; kept as a local helper.
                -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
                -- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [50.6]
                return nil ~= nil
            end
            if nil ~= nil or decompInlinedCondition_2() then
            end
        end
        -- Decomp Error: Konstant control-flow analysis failed in this block; surrounding logic was preserved for review.
    end
    function module_upvr._deepCopy(arg1_17) -- Line 877
        for i_15, v_15 in arg1_17 do
            if type(v_15) == "table" then
                table.clone(arg1_17)[i_15] = module_upvr._deepCopy(v_15)
            end
        end
        -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
        return table.clone(arg1_17)
    end
    module_upvr._lastVDOM = module_upvr._generateEmptyVDOM()
    module_upvr._VDOM = module_upvr._generateEmptyVDOM()
    arg1.Internal = module_upvr
    arg1._config = module_upvr._config
    return module_upvr
end