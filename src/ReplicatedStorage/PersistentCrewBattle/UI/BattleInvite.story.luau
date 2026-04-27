local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
return function(parentContainer)
	local AppComponent = Roact.Component:extend("App")
	local BattleInvite = require(script.Parent.BattleInvite)
	function AppComponent.init(self)  end
	function AppComponent.render(self)
		return Roact.createElement(BattleInvite, {
			battleNumPlayersPerTeam = 3,
			ranked = true
		})
	end
	function AppComponent.willUnmount(self)  end
	local mountHandle = Roact.mount(Roact.createElement(AppComponent), parentContainer)
	return function()
		Roact.unmount(mountHandle)
	end
end
