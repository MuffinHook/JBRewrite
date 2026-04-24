-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
return function(p1)
	local v1 = Roact.Component:extend("App")
	local BattleInvite = require(script.Parent.BattleInvite)
	function v1.init(p1)  end
	function v1.render(p1)
		return Roact.createElement(BattleInvite, {
			battleNumPlayersPerTeam = 3,
			ranked = true
		})
	end
	function v1.willUnmount(p1)  end
	local v2 = Roact.mount(Roact.createElement(v1), p1)
	return function()
		Roact.unmount(v2)
	end
end
