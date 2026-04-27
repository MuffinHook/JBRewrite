local Players = game:GetService("Players")
local DuffelBagBinder = require(script.Parent.DuffelBagBinder)
return {
	getBag = function(player)
		assert(player)
		assert(player.Parent == Players)
		for i, bag in ipairs(DuffelBagBinder:GetAll()) do
			if bag:GetOwner() == player then
				return bag
			end
		end
	end
}
