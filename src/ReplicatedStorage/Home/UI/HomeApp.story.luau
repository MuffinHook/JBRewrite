-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
return function(p1)
	local v1 = Roact.Component:extend("App")
	local HomeApp = require(ReplicatedStorage.Home.UI.HomeApp)
	local homeStore = require(ReplicatedStorage.Home.homeStore)
	function v1.init(p1)
		homeStore:dispatch({
			type = "setVisible",
			value = true
		})
	end
	function v1.render(p1)
		return Roact.createElement(RoactRodux.StoreProvider, {
			store = homeStore
		}, { Roact.createElement(HomeApp, {
				aspectRatio = 3,
				verticalPaddingRatio = 128,
				attemptPlaceItem = function(...)
					print("attemptPlaceItem", ...)
				end,
				attemptPurchaseItem = function(...)
					print("attemptPurchaseItem", ...)
				end
			}) })
	end
	local v2 = Roact.mount(Roact.createElement(v1), p1)
	return function()
		Roact.unmount(v2)
	end
end
