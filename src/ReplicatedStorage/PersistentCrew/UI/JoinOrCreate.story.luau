local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
return function(targetContainer)
	local AppComponent = Roact.Component:extend("App")
	local JoinOrCreate = require(script.Parent.JoinOrCreate)
	local persistentCrewStore = require(ReplicatedStorage.PersistentCrew.persistentCrewStore)
	function AppComponent.init(self)  end
	function AppComponent.render(self)
		return Roact.createElement(RoactRodux.StoreProvider, {
			store = persistentCrewStore
		}, { Roact.createElement(JoinOrCreate, {
				aspectRatio = 16/9,
				verticalPaddingRatio = 128
			}, {
				AspectRatioConstraint = Roact.createElement("UIAspectRatioConstraint", {
					AspectRatio = 16/9
				})
			}) })
	end
	local mountedElement = Roact.mount(Roact.createElement(AppComponent), targetContainer)
	return function()
		Roact.unmount(mountedElement)
	end
end
