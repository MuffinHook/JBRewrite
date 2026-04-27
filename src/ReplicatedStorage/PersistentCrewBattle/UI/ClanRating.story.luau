local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
return function(parent)
	local AppComponent = Roact.Component:extend("App")
	local ClanRating = require(script.Parent.ClanRating)
	function AppComponent.init(self)  end
	function AppComponent.render(self)
		return Roact.createElement(ClanRating, {
			aspectRatio = 20,
			paddingRatio = 0.0078125,
			ownerName = "badcc",
			clanName = "Baboyz",
			clanRating = "1565",
			size = UDim2.fromScale(0.8, 0.1)
		})
	end
	function AppComponent.willUnmount(self)  end
	local componentInstance = Roact.mount(Roact.createElement(AppComponent), parent)
	return function()
		Roact.unmount(componentInstance)
	end
end
