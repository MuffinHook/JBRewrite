local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
return function(storyRoot)
	local AppStory = Roact.Component:extend("App")
	local HomeApp = require(ReplicatedStorage.Home.UI.HomeApp)
	local homeStore = require(ReplicatedStorage.Home.homeStore)
	function AppStory.init(self)
		homeStore:dispatch({
			type = "setVisible",
			value = true
		})
	end
	function AppStory.render(self)
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
	local mountedInstance = Roact.mount(Roact.createElement(AppStory), storyRoot)
	return function()
		Roact.unmount(mountedInstance)
	end
end
