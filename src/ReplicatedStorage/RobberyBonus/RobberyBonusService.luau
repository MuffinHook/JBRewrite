local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RobberyBonusConsts = require(script.Parent.RobberyBonusConsts)
local waitForChild = require(ReplicatedStorage.Std.waitForChild)
return {
	init = function(p1) --[[ Name: init | Line: 6 | Upvalues: waitForChild (copy), ReplicatedStorage (copy), RobberyBonusConsts (copy) ]]
		local em = p1.em
		waitForChild(ReplicatedStorage, RobberyBonusConsts.FIREWORK_FX_REMOTE_NAME):andThen(function(p1) --[[ Line: 8 | Upvalues: em (copy) ]]
			p1.OnClientEvent:Connect(function() --[[ Line: 9 | Upvalues: em (ref) ]]
				em.l2atqdos(10)
			end)
		end)
	end
}