local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
return function(targetElement)
	local AppComponent = Roact.Component:extend("App")
	local MansionRobberyApp = require(script.Parent.MansionRobberyApp)
	local mansionRobberyStore = require(ReplicatedStorage.MansionRobbery.mansionRobberyStore)
	function AppComponent.init(props)
		mansionRobberyStore:dispatch({
			type = "setDialogueText",
			text = "hello, world!"
		})
		local pctClosedBinding, updatePctClosed = Roact.createBinding(0.4)
		props.pctClosed = pctClosedBinding
		props.updatePctClosed = updatePctClosed
	end
	function AppComponent.render(props)
		return Roact.createElement(RoactRodux.StoreProvider, {
			store = mansionRobberyStore
		}, { Roact.createElement(MansionRobberyApp, {
				pctClosed = props.pctClosed
			}) })
	end
	local mountedInstance = Roact.mount(Roact.createElement(AppComponent), targetElement)
	return function()
		Roact.unmount(mountedInstance)
	end
end
