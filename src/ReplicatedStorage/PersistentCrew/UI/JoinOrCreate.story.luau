-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
return function(arg1)
	local local1 = Roact.Component:extend("App")
	local JoinOrCreate = require(script.Parent.JoinOrCreate)
	local persistentCrewStore = require(ReplicatedStorage.PersistentCrew.persistentCrewStore)
	function local1.init(arg1)  end
	function local1.render(arg1)
		return Roact.createElement(RoactRodux.StoreProvider, {
			store = persistentCrewStore
		}, { Roact.createElement(JoinOrCreate, {
				aspectRatio = 1.7777777777777777,
				verticalPaddingRatio = 128
			}, {
				AspectRatioConstraint = Roact.createElement("UIAspectRatioConstraint", {
					AspectRatio = 1.7777777777777777
				})
			}) })
	end
	local local2 = Roact.mount(Roact.createElement(local1), arg1)
	return function()
		Roact.unmount(local2)
	end
end
