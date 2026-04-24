-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
return function(p1)
	local v1 = Roact.Component:extend("App")
	local store = require(ReplicatedStorage.App.store)
	local ChooseSpawn = require(script.Parent.ChooseSpawn)
	function v1.init(p1)  end
	store:dispatch({
		type = "setSpawnSelectionOfferVisible",
		visible = true
	})
	store:dispatch({
		type = "setLastDiedAt",
		lastDiedAt = workspace:GetServerTimeNow()
	})
	function v1.render(p1)
		return Roact.createElement(RoactRodux.StoreProvider, {
			store = store
		}, { Roact.createElement(ChooseSpawn, {}) })
	end
	function v1.willUnmount(p1)  end
	local v2 = Roact.mount(Roact.createElement(v1), p1)
	return function()
		Roact.unmount(v2)
	end
end
