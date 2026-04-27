local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
return function(storyTarget)
	local AppComponent = Roact.Component:extend("App")
	local PlacerApp = require(ReplicatedStorage.Home.UI.PlacerApp)
	local homeStore = require(ReplicatedStorage.Home.homeStore)
	function AppComponent.init(self) end
	function AppComponent.render(self)
		return Roact.createElement(RoactRodux.StoreProvider, {
			store = homeStore
		}, { Roact.createElement(PlacerApp, {
				aspectRatio = 5,
				verticalPaddingRatio = 25.6,
				showPlace = true
			}) })
	end
	local mountedInstance = Roact.mount(Roact.createElement(AppComponent), storyTarget)
	return function()
		Roact.unmount(mountedInstance)
	end
end
