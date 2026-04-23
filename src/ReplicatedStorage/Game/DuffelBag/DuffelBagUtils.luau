local Players = game:GetService("Players")
local DuffelBagBinder = require(script.Parent.DuffelBagBinder)
return {
	getBag = function(p1) --[[ Name: getBag | Line: 6 | Upvalues: Players (copy), DuffelBagBinder (copy) ]]
		assert(p1)
		assert(p1.Parent == Players)
		for i, v in ipairs(DuffelBagBinder:GetAll()) do
			if v:GetOwner() == p1 then
				return v
			end
		end
	end
}