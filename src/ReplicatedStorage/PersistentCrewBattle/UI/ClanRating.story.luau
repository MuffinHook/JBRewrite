-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
return function(p1)
	local v1 = Roact.Component:extend("App")
	local ClanRating = require(script.Parent.ClanRating)
	function v1.init(p1)  end
	function v1.render(p1)
		return Roact.createElement(ClanRating, {
			aspectRatio = 20,
			paddingRatio = 0.0078125,
			ownerName = "badcc",
			clanName = "Baboyz",
			clanRating = "1565",
			size = UDim2.fromScale(0.8, 0.1)
		})
	end
	function v1.willUnmount(p1)  end
	local v2 = Roact.mount(Roact.createElement(v1), p1)
	return function()
		Roact.unmount(v2)
	end
end
