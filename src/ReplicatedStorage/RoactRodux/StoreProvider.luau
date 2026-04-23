local Roact = require(script.Parent.Parent.Roact)
local StoreContext = require(script.Parent.StoreContext)
local v1 = Roact.Component:extend("StoreProvider")
function v1.validateProps(p1) --[[ Line: 7 ]]
	if p1.store == nil then
		return false, "Error initializing StoreProvider. Expected a `store` prop to be a Rodux store."
	else
		return true
	end
end
function v1.init(p1, p2) --[[ Line: 15 ]]
	p1.store = p2.store
end
function v1.render(p1) --[[ Line: 19 | Upvalues: Roact (copy), StoreContext (copy) ]]
	return Roact.createElement(StoreContext.Provider, {
		value = p1.store
	}, Roact.oneChild(p1.props[Roact.Children]))
end
return v1