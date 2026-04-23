local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
return function(p1) --[[ Line: 5 | Upvalues: Roact (copy), ReplicatedStorage (copy), RoactRodux (copy) ]]
	local v1 = Roact.Component:extend("App")
	local PlacerApp = require(ReplicatedStorage.Home.UI.PlacerApp)
	local homeStore = require(ReplicatedStorage.Home.homeStore)
	function v1.init(p1) --[[ Line: 9 ]] end
	function v1.render(p1) --[[ Line: 11 | Upvalues: Roact (ref), RoactRodux (ref), homeStore (copy), PlacerApp (copy) ]]
		return Roact.createElement(RoactRodux.StoreProvider, {
			store = homeStore
		}, { Roact.createElement(PlacerApp, {
				aspectRatio = 5,
				verticalPaddingRatio = 25.6,
				showPlace = true
			}) })
	end
	local v2 = Roact.mount(Roact.createElement(v1), p1)
	return function() --[[ Line: 25 | Upvalues: Roact (ref), v2 (copy) ]]
		Roact.unmount(v2)
	end
end