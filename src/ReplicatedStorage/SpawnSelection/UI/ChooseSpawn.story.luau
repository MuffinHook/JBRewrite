-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
return function(storyParent)
	local AppComponent = Roact.Component:extend("App")
	local store = require(ReplicatedStorage.App.store)
	local ChooseSpawn = require(script.Parent.ChooseSpawn)
	function AppComponent.init(self)  end
	store:dispatch({
		type = "setSpawnSelectionOfferVisible",
		visible = true
	})
	store:dispatch({
		type = "setLastDiedAt",
		lastDiedAt = workspace:GetServerTimeNow()
	})
	function AppComponent.render(self)
		return Roact.createElement(RoactRodux.StoreProvider, {
			store = store
		}, { Roact.createElement(ChooseSpawn, {}) })
	end
	function AppComponent.willUnmount(self)  end
	local mountedComponent = Roact.mount(Roact.createElement(AppComponent), storyParent)
	return function()
		Roact.unmount(mountedComponent)
	end
end
