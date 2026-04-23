local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
return function(p1) --[[ Line: 5 | Upvalues: Roact (copy), ReplicatedStorage (copy), RoactRodux (copy) ]]
	local v1 = Roact.Component:extend("App")
	local MansionRobberyApp = require(script.Parent.MansionRobberyApp)
	local mansionRobberyStore = require(ReplicatedStorage.MansionRobbery.mansionRobberyStore)
	function v1.init(p1) --[[ Line: 9 | Upvalues: mansionRobberyStore (copy), Roact (ref) ]]
		mansionRobberyStore:dispatch({
			type = "setDialogueText",
			text = "hello, world!"
		})
		local v1, v2 = Roact.createBinding(0.4)
		p1.pctClosed = v1
		p1.updatePctClosed = v2
	end
	function v1.render(p1) --[[ Line: 16 | Upvalues: Roact (ref), RoactRodux (ref), mansionRobberyStore (copy), MansionRobberyApp (copy) ]]
		return Roact.createElement(RoactRodux.StoreProvider, {
			store = mansionRobberyStore
		}, { Roact.createElement(MansionRobberyApp, {
				pctClosed = p1.pctClosed
			}) })
	end
	local v2 = Roact.mount(Roact.createElement(v1), p1)
	return function() --[[ Line: 27 | Upvalues: Roact (ref), v2 (copy) ]]
		Roact.unmount(v2)
	end
end