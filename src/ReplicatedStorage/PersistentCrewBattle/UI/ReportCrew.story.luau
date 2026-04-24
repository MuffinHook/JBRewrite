-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
return function(p1)
	local v1 = Roact.Component:extend("App")
	local ReportCrew = require(script.Parent.ReportCrew)
	function v1.init(p1)  end
	function v1.render(p1)
		return Roact.createElement(ReportCrew, {
			onSubmit = function(p1, p2)
				print(p1)
				print(p2)
			end,
			onClose = function()
				print("wants to close")
			end
		})
	end
	function v1.willUnmount(p1)  end
	local v2 = Roact.mount(Roact.createElement(v1), p1)
	return function()
		Roact.unmount(v2)
	end
end
