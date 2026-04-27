local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
return function(targetParent)
	local AppComponent = Roact.Component:extend("App")
	local TradeInitiation = require(script.Parent.TradeInitiation)
	function AppComponent.init(self)  end
	function AppComponent.render(self)
		return Roact.createElement(TradeInitiation, {
			name = "badcc"
		})
	end
	function AppComponent.willUnmount(self)  end
	local appInstance = Roact.mount(Roact.createElement(AppComponent), targetParent)
	return function()
		Roact.unmount(appInstance)
	end
end
