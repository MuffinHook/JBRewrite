local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
return function(p1) --[[ Line: 5 | Upvalues: Roact (copy), ReplicatedStorage (copy), RoactRodux (copy) ]]
	local v1 = Roact.Component:extend("App")
	local JoinOrCreate = require(script.Parent.JoinOrCreate)
	local persistentCrewStore = require(ReplicatedStorage.PersistentCrew.persistentCrewStore)
	function v1.init(p1) --[[ Line: 9 ]] end
	function v1.render(p1) --[[ Line: 11 | Upvalues: Roact (ref), RoactRodux (ref), persistentCrewStore (copy), JoinOrCreate (copy) ]]
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
	local v2 = Roact.mount(Roact.createElement(v1), p1)
	return function() --[[ Line: 27 | Upvalues: Roact (ref), v2 (copy) ]]
		Roact.unmount(v2)
	end
end