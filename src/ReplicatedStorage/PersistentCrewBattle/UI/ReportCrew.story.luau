-- Reviewed by Claude
-- variables reassigned
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
return function(arg1)
	local local1 = Roact.Component:extend("App")
	local ReportCrew = require(script.Parent.ReportCrew)
	function local1.init(arg1)  end
	function local1.render(arg1)
		return Roact.createElement(ReportCrew, {
			onSubmit = function(arg1, arg2)
				print(arg1)
				print(arg2)
			end,
			onClose = function()
				print("wants to close")
			end
		})
	end
	function local1.willUnmount(arg1)  end
	local local2 = Roact.mount(Roact.createElement(local1), arg1)
	return function()
		Roact.unmount(local2)
	end
end
