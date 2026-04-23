local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
return function(p1) --[[ Line: 5 | Upvalues: Roact (copy), ReplicatedStorage (copy), RoactRodux (copy) ]]
	local v1 = Roact.Component:extend("App")
	local HomeApp = require(ReplicatedStorage.Home.UI.HomeApp)
	local homeStore = require(ReplicatedStorage.Home.homeStore)
	function v1.init(p1) --[[ Line: 9 | Upvalues: homeStore (copy) ]]
		homeStore:dispatch({
			type = "setVisible",
			value = true
		})
	end
	function v1.render(p1) --[[ Line: 21 | Upvalues: Roact (ref), RoactRodux (ref), homeStore (copy), HomeApp (copy) ]]
		return Roact.createElement(RoactRodux.StoreProvider, {
			store = homeStore
		}, { Roact.createElement(HomeApp, {
				aspectRatio = 3,
				verticalPaddingRatio = 128,
				attemptPlaceItem = function(...) --[[ Name: attemptPlaceItem | Line: 29 ]]
					print("attemptPlaceItem", ...)
				end,
				attemptPurchaseItem = function(...) --[[ Name: attemptPurchaseItem | Line: 32 ]]
					print("attemptPurchaseItem", ...)
				end
			}) })
	end
	local v2 = Roact.mount(Roact.createElement(v1), p1)
	return function() --[[ Line: 40 | Upvalues: Roact (ref), v2 (copy) ]]
		Roact.unmount(v2)
	end
end