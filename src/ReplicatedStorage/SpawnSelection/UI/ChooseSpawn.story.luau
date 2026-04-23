local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
return function(p1) --[[ Line: 5 | Upvalues: Roact (copy), ReplicatedStorage (copy), RoactRodux (copy) ]]
	local v1 = Roact.Component:extend("App")
	local store = require(ReplicatedStorage.App.store)
	local ChooseSpawn = require(script.Parent.ChooseSpawn)
	function v1.init(p1) --[[ Line: 9 ]] end
	store:dispatch({
		type = "setSpawnSelectionOfferVisible",
		visible = true
	})
	store:dispatch({
		type = "setLastDiedAt",
		lastDiedAt = workspace:GetServerTimeNow()
	})
	function v1.render(p1) --[[ Line: 18 | Upvalues: Roact (ref), RoactRodux (ref), store (copy), ChooseSpawn (copy) ]]
		return Roact.createElement(RoactRodux.StoreProvider, {
			store = store
		}, { Roact.createElement(ChooseSpawn, {}) })
	end
	function v1.willUnmount(p1) --[[ Line: 25 ]] end
	local v2 = Roact.mount(Roact.createElement(v1), p1)
	return function() --[[ Line: 28 | Upvalues: Roact (ref), v2 (copy) ]]
		Roact.unmount(v2)
	end
end