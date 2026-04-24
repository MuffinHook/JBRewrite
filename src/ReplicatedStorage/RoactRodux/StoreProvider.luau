-- Reviewed by Claude
-- variables reassigned
local Roact = require(script.Parent.Parent.Roact)
local StoreContext = require(script.Parent.StoreContext)
local StoreProviderComponent = Roact.Component:extend("StoreProvider")
function StoreProviderComponent.validateProps(props)
	if props.store == nil then
 return false, "Error initializing StoreProvider. Expected a `store` prop to be a Rodux store."
	else
 return true
	end
end
function StoreProviderComponent.init(self, props)
	self.store = props.store
end
function StoreProviderComponent.render(self)
	return Roact.createElement(StoreContext.Provider, {
 value = self.store
	}, Roact.oneChild(self.props[Roact.Children]))
end
return StoreProviderComponent
