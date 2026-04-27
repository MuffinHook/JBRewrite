local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CircularProgressBar = require(script.Parent.CircularProgressBar)
local Roact = require(ReplicatedStorage.Roact)
return function(target)
	local AppComponent = Roact.Component:extend("App")
	function AppComponent.init(self)
		local progressBinding, updateProgress = Roact.createBinding(0.3)
		self.progress = progressBinding
		self.updateProgress = updateProgress
		self.updateProgress(0.1)
	end
	function AppComponent.render(self)
		return Roact.createElement(CircularProgressBar, {
			progressBinding = self.progress
		})
	end
	function AppComponent.willUnmount(self)end
	local mountId = Roact.mount(Roact.createElement(AppComponent), target)
	return function()
		Roact.unmount(mountId)
	end
end