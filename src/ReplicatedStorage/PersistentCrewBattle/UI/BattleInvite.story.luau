-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
return function(arg1)
	local local1 = Roact.Component:extend("App")
	local BattleInvite = require(script.Parent.BattleInvite)
	function local1.init(arg1)  end
	function local1.render(arg1)
		return Roact.createElement(BattleInvite, {
			battleNumPlayersPerTeam = 3,
			ranked = true
		})
	end
	function local1.willUnmount(arg1)  end
	local local2 = Roact.mount(Roact.createElement(local1), arg1)
	return function()
		Roact.unmount(local2)
	end
end
