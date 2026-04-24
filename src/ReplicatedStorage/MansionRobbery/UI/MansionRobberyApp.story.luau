-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
return function(p1)
	local v1 = Roact.Component:extend("App")
	local MansionRobberyApp = require(script.Parent.MansionRobberyApp)
	local mansionRobberyStore = require(ReplicatedStorage.MansionRobbery.mansionRobberyStore)
	function v1.init(p1)
		mansionRobberyStore:dispatch({
			type = "setDialogueText",
			text = "hello, world!"
		})
		local v1, v2 = Roact.createBinding(0.4)
		p1.pctClosed = v1
		p1.updatePctClosed = v2
	end
	function v1.render(p1)
		return Roact.createElement(RoactRodux.StoreProvider, {
			store = mansionRobberyStore
		}, { Roact.createElement(MansionRobberyApp, {
				pctClosed = p1.pctClosed
			}) })
	end
	local v2 = Roact.mount(Roact.createElement(v1), p1)
	return function()
		Roact.unmount(v2)
	end
end
