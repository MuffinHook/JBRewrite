local Roact_upvr = require(script.Parent.Parent.Roact)
local any_extend_result1 = Roact_upvr.Component:extend("StoreProvider")
function any_extend_result1.validateProps(arg1) -- Line 7
    if arg1.store == nil then
        return false, "Error initializing StoreProvider. Expected a `store` prop to be a Rodux store."
    end
    return true
end
function any_extend_result1.init(arg1, arg2) -- Line 15
    arg1.store = arg2.store
end
local StoreContext_upvr = require(script.Parent.StoreContext)
function any_extend_result1.render(arg1) -- Line 19
    return Roact_upvr.createElement(StoreContext_upvr.Provider, {
        value = arg1.store;
    }, Roact_upvr.oneChild(arg1.props[Roact_upvr.Children]))
end
return any_extend_result1