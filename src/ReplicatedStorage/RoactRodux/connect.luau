local join_upvr = require(script.Parent.join)
local function _(arg1, arg2) -- Line 9, Named "formatMessage"
    local var2 = arg2
    if not var2 then
        var2 = {}
    end
    return table.concat(arg1, '\n'):format(unpack(var2))
end
local function noop_upvw() -- Line 13, Named "noop"
    return nil
end
local function _(arg1) -- Line 26, Named "makeStateUpdater"
    return function(arg1_2, arg2, arg3) -- Line 27
        if arg3 == nil then
            local any_mapStateToProps_result1 = arg2.mapStateToProps(arg1:getState(), arg1_2)
        end
        return {
            mappedStoreState = any_mapStateToProps_result1;
            propsForChild = join_upvr(arg1_2, any_mapStateToProps_result1, arg2.mappedStoreDispatch);
        }
    end
end
local Roact_upvr = require(script.Parent.Parent.Roact)
local shallowEqual_upvr = require(script.Parent.shallowEqual)
local StoreContext_upvr = require(script.Parent.StoreContext)
return function(arg1, arg2) -- Line 50, Named "connect"
    -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
    local var9
    if arg1 ~= nil then
        if typeof(arg1) ~= "function" then
            var9 = false
        else
            var9 = true
        end
        assert(var9, "mapStateToProps must be a function or nil!")
    else
    end
    local typeof_result1_upvr = typeof(arg2)
    if arg2 ~= nil then
        local var11 = true
        if typeof_result1_upvr ~= "function" then
            if typeof_result1_upvr ~= "table" then
                var11 = false
            else
                var11 = true
            end
        end
        assert(var11, "mapDispatchToProps must be a function, table, or nil!")
    else
    end
    local call_stack_upvr = debug.traceback()
    return function(arg1_3) -- Line 69
        if arg1_3 == nil then
            local var16 = {call_stack_upvr}
            if not var16 then
                var16 = {}
            end
            error(table.concat({"connect returns a function that must be passed a component.", "Check the connection at:", "%s"}, '\n'):format(unpack(var16)), 2)
        end
        local formatted = "RoduxConnection(%s)":format(tostring(arg1_3))
        local any_extend_result1_2_upvr = Roact_upvr.Component:extend(formatted)
        function any_extend_result1_2_upvr.getDerivedStateFromProps(arg1_4, arg2_2) -- Line 86
            if arg2_2.stateUpdater ~= nil then
                return arg2_2.stateUpdater(arg1_4.innerProps, arg2_2)
            end
        end
        function any_extend_result1_2_upvr.init(arg1_5, arg2_3) -- Line 92
            -- Decomp Logic Error: Konstant variable analysis failed; temporary assignments in this block were preserved for review.
            arg1_5.store = arg2_3.store
            local var35
            if arg1_5.store == nil then
                local tbl = {}
                var35 = "Cannot initialize Roact-Rodux connection without being a descendent of StoreProvider!"
                tbl[1] = var35
                tbl[2] = "Tried to wrap component %q"
                tbl[3] = "Make sure there is a StoreProvider above this component in the tree."
                var35 = {}
                var35[1] = tostring(arg1_3)
                local var37 = var35
                if not var37 then
                    var37 = {}
                end
                var35 = table.concat(tbl, '\n'):format(unpack(var37))
                error(var35)
            end
            local any_getState_result1 = arg1_5.store:getState()
            var35 = noop_upvw(any_getState_result1, arg1_5.props.innerProps)
            if typeof(var35) == "function" then
                var35 = var35(any_getState_result1, arg1_5.props.innerProps)
            end
            if var35 ~= nil and typeof(var35) ~= "table" then
                local var41 = {tostring(var35), typeof(var35)}
                if not var41 then
                    var41 = {}
                end
                error(table.concat({"mapStateToProps must either return a table, or return another function that returns a table.", "Instead, it returned %q, which is of type %s."}, '\n'):format(unpack(var41)))
            end
            local function dispatch_upvr(...) -- Line 133, Named "dispatch"
                return arg1_5.store:dispatch(...)
            end
            local var42
            if typeof_result1_upvr == "table" then
                var42 = {}
                for i, v_upvr in pairs(noop_upvw) do
                    local var46
                    if typeof(v_upvr) ~= "function" then
                        var46 = false
                    else
                        var46 = true
                    end
                    assert(var46, "mapDispatchToProps must contain function values")
                    var42[i] = function(...) -- Line 144
                        dispatch_upvr(v_upvr(...))
                    end
                end
            elseif typeof_result1_upvr == "function" then
                var42 = noop_upvw(dispatch_upvr)
            end
            local store_upvr = arg1_5.store
            store_upvr = {}
            local var52 = store_upvr
            function var52.stateUpdater(arg1_6, arg2_4, arg3) -- Line 27
                if arg3 == nil then
                    local any_mapStateToProps_result1_3 = arg2_4.mapStateToProps(store_upvr:getState(), arg1_6)
                end
                return {
                    mappedStoreState = any_mapStateToProps_result1_3;
                    propsForChild = join_upvr(arg1_6, any_mapStateToProps_result1_3, arg2_4.mappedStoreDispatch);
                }
            end
            -- Decomp Logic Error: Konstant reused an expression here; surrounding logic was preserved for review.
            var52.mapStateToProps = var35
            var52.mappedStoreDispatch = var42
            var52.propsForChild = nil
            arg1_5.state = var52
            var52 = (function(arg1_6, arg2_4, arg3) -- Line 27
                if arg3 == nil then
                    local any_mapStateToProps_result1_3 = arg2_4.mapStateToProps(store_upvr:getState(), arg1_6)
                end
                return {
                    mappedStoreState = any_mapStateToProps_result1_3;
                    propsForChild = join_upvr(arg1_6, any_mapStateToProps_result1_3, arg2_4.mappedStoreDispatch);
                }
            end)(arg1_5.props.innerProps, arg1_5.state, var35)
            for i_2, v_2 in pairs(var52) do
                arg1_5.state[i_2] = v_2
            end
        end
        function any_extend_result1_2_upvr.didMount(arg1_7) -- Line 179
            local any_getState_result1_upvr = arg1_7.store:getState()
            arg1_7:setState(function(arg1_10, arg2_6) -- Line 181
                local any_mapStateToProps_result1_4 = arg1_10.mapStateToProps(any_getState_result1_upvr, arg2_6.innerProps)
                if shallowEqual_upvr(any_mapStateToProps_result1_4, arg1_10.mappedStoreState) then
                    return nil
                end
                return arg1_10.stateUpdater(arg2_6.innerProps, arg1_10, any_mapStateToProps_result1_4)
            end)
            any_getState_result1_upvr = arg1_7.store
            any_getState_result1_upvr = any_getState_result1_upvr.changed:connect(function(arg1_8) -- Line 180
                arg1_7:setState(function(arg1_9, arg2_5) -- Line 181
                    local any_mapStateToProps_result1_2 = arg1_9.mapStateToProps(arg1_8, arg2_5.innerProps)
                    if shallowEqual_upvr(any_mapStateToProps_result1_2, arg1_9.mappedStoreState) then
                        return nil
                    end
                    return arg1_9.stateUpdater(arg2_5.innerProps, arg1_9, any_mapStateToProps_result1_2)
                end)
            end)
            arg1_7.storeChangedConnection = any_getState_result1_upvr
        end
        function any_extend_result1_2_upvr.willUnmount(arg1_11) -- Line 203
            if arg1_11.storeChangedConnection then
                arg1_11.storeChangedConnection:disconnect()
                arg1_11.storeChangedConnection = nil
            end
        end
        local function render(arg1_12) -- Line 210
            return Roact_upvr.createElement(arg1_3, arg1_12.state.propsForChild)
        end
        any_extend_result1_2_upvr.render = render
        local any_extend_result1 = Roact_upvr.Component:extend(formatted)
        local function render(arg1_13) -- Line 216
            return Roact_upvr.createElement(StoreContext_upvr.Consumer, {
                render = function(arg1_14) -- Line 218, Named "render"
                    local module = {
                        innerProps = arg1_13.props;
                    }
                    module.store = arg1_14
                    return Roact_upvr.createElement(any_extend_result1_2_upvr, module)
                end;
            })
        end
        any_extend_result1.render = render
        return any_extend_result1
    end
end