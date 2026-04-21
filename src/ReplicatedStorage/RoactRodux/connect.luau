local join = require(script.Parent.join)
local Roact = require(script.Parent.Parent.Roact)
local shallowEqual = require(script.Parent.shallowEqual)
local StoreContext = require(script.Parent.StoreContext)

local function formatMessage(lines, args)
    return string.format(table.concat(lines, "\n"), unpack(args or {}))
end

local function validateMappedState(mappedState)
    if mappedState ~= nil and typeof(mappedState) ~= "table" then
        error(formatMessage({
            "mapStateToProps must either return a table, or return another function that returns a table.",
            "Instead, it returned %q, which is of type %s.",
        }, { tostring(mappedState), typeof(mappedState) }))
    end
    return mappedState or {}
end

local function computeProps(store, mapStateToProps, mappedStoreDispatch, innerProps, providedMappedState)
    local mappedStoreState = providedMappedState
    if mapStateToProps and mappedStoreState == nil then
        mappedStoreState = mapStateToProps(store:getState(), innerProps)
    end
    mappedStoreState = validateMappedState(mappedStoreState)

    return {
        mappedStoreState = mappedStoreState,
        propsForChild = join(innerProps, mappedStoreState, mappedStoreDispatch),
    }
end

return function(mapStateToProps, mapDispatchToProps)
    if mapStateToProps ~= nil then
        assert(typeof(mapStateToProps) == "function", "mapStateToProps must be a function or nil!")
    end

    local mapDispatchType = typeof(mapDispatchToProps)
    if mapDispatchToProps ~= nil then
        assert(mapDispatchType == "function" or mapDispatchType == "table", "mapDispatchToProps must be a function, table, or nil!")
    end

    local callStack = debug.traceback()

    return function(component)
        if component == nil then
            error(formatMessage({
                "connect returns a function that must be passed a component.",
                "Check the connection at:",
                "%s",
            }, { callStack }), 2)
        end

        local name = string.format(("RoduxConnection(%s)"), tostring(component))
        local Connection = Roact.Component:extend(name)

        function Connection.getDerivedStateFromProps(props, state)
            if state.stateUpdater ~= nil then
                return state.stateUpdater(props.innerProps, state)
            end
            return nil
        end

        function Connection:init(props)
            self.store = props.store
            if self.store == nil then
                error(formatMessage({
                    "Cannot initialize Roact-Rodux connection without being a descendent of StoreProvider!",
                    "Tried to wrap component %q",
                    "Make sure there is a StoreProvider above this component in the tree.",
                }, { tostring(component) }))
            end

            local dispatch = function(...)
                return self.store:dispatch(...)
            end

            local mappedDispatch
            if mapDispatchType == "table" then
                mappedDispatch = {}
                for key, actionCreator in pairs(mapDispatchToProps) do
                    assert(typeof(actionCreator) == "function", "mapDispatchToProps must contain function values")
                    mappedDispatch[key] = function(...)
                        return dispatch(actionCreator(...))
                    end
                end
            elseif mapDispatchType == "function" then
                mappedDispatch = mapDispatchToProps(dispatch, props.innerProps)
            end

            local activeMapStateToProps = mapStateToProps
            local firstMappedState
            if activeMapStateToProps then
                firstMappedState = activeMapStateToProps(self.store:getState(), props.innerProps)
                if typeof(firstMappedState) == "function" then
                    activeMapStateToProps = firstMappedState
                    firstMappedState = activeMapStateToProps(self.store:getState(), props.innerProps)
                end
            end

            local initialState = {
                mapStateToProps = activeMapStateToProps,
                mappedStoreDispatch = mappedDispatch,
                store = self.store,
            }

            initialState.stateUpdater = function(innerProps, state, providedMappedState)
                return computeProps(state.store, state.mapStateToProps, state.mappedStoreDispatch, innerProps, providedMappedState)
            end

            for key, value in pairs(computeProps(self.store, activeMapStateToProps, mappedDispatch, props.innerProps, firstMappedState)) do
                initialState[key] = value
            end

            self.state = initialState
        end

        function Connection:didMount()
            if not self.state.mapStateToProps then
                return
            end

            self.storeChangedConnection = self.store.changed:connect(function(newState)
                self:setState(function(state, props)
                    local mappedStoreState = state.mapStateToProps(newState, props.innerProps)
                    mappedStoreState = validateMappedState(mappedStoreState)
                    if shallowEqual(mappedStoreState, state.mappedStoreState) then
                        return nil
                    end
                    return state.stateUpdater(props.innerProps, state, mappedStoreState)
                end)
            end)
        end

        function Connection:willUnmount()
            if self.storeChangedConnection then
                self.storeChangedConnection:disconnect()
                self.storeChangedConnection = nil
            end
        end

        function Connection:render()
            return Roact.createElement(component, self.state.propsForChild)
        end

        local ContextConsumer = Roact.Component:extend(name)

        function ContextConsumer:render()
            return Roact.createElement(StoreContext.Consumer, {
                render = function(store)
                    return Roact.createElement(Connection, {
                        innerProps = self.props,
                        store = store,
                    })
                end,
            })
        end

        return ContextConsumer
    end
end
