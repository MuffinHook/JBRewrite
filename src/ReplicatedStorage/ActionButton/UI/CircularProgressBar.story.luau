-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CircularProgressBar = require(script.Parent.CircularProgressBar)
local Roact = require(ReplicatedStorage.Roact)
return function(p1)
	local v1 = Roact.Component:extend("App")
	function v1.init(p1)
		local v1, v2 = Roact.createBinding(0.3)
		p1.progress = v1
		p1.updateProgress = v2
		p1.updateProgress(0.1)
	end
	function v1.render(p1)
		return Roact.createElement(CircularProgressBar, {
			progressBinding = p1.progress
		})
	end
	function v1.willUnmount(p1)end
	local v2 = Roact.mount(Roact.createElement(v1), p1)
	return function()
		Roact.unmount(v2)
	end
end