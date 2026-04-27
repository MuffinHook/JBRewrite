local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
return function(parentInstance)
	local AppComponent = Roact.Component:extend("App")
	local ReportCrew = require(script.Parent.ReportCrew)
	function AppComponent.init(self)  end
	function AppComponent.render(self)
		return Roact.createElement(ReportCrew, {
			onSubmit = function(submissionData, additionalData)
				print(submissionData)
				print(additionalData)
			end,
			onClose = function()
				print("wants to close")
			end
		})
	end
	function AppComponent.willUnmount(self)  end
	local mountedComponent = Roact.mount(Roact.createElement(AppComponent), parentInstance)
	return function()
		Roact.unmount(mountedComponent)
	end
end
