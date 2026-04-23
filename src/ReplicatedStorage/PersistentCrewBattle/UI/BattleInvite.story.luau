local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
return function(p1) --[[ Line: 4 | Upvalues: Roact (copy) ]]
	local v1 = Roact.Component:extend("App")
	local BattleInvite = require(script.Parent.BattleInvite)
	function v1.init(p1) --[[ Line: 7 ]] end
	function v1.render(p1) --[[ Line: 8 | Upvalues: Roact (ref), BattleInvite (copy) ]]
		return Roact.createElement(BattleInvite, {
			battleNumPlayersPerTeam = 3,
			ranked = true
		})
	end
	function v1.willUnmount(p1) --[[ Line: 17 ]] end
	local v2 = Roact.mount(Roact.createElement(v1), p1)
	return function() --[[ Line: 20 | Upvalues: Roact (ref), v2 (copy) ]]
		Roact.unmount(v2)
	end
end