-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
return function(arg1)
	local local1 = Roact.Component:extend("App")
	local ClanRating = require(script.Parent.ClanRating)
	function local1.init(arg1)  end
	function local1.render(arg1)
		return Roact.createElement(ClanRating, {
			aspectRatio = 20,
			paddingRatio = 0.0078125,
			ownerName = "badcc",
			clanName = "Baboyz",
			clanRating = "1565",
			size = UDim2.fromScale(0.8, 0.1)
		})
	end
	function local1.willUnmount(arg1)  end
	local local2 = Roact.mount(Roact.createElement(local1), arg1)
	return function()
		Roact.unmount(local2)
	end
end
