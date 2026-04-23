local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
return function(p1) --[[ Line: 4 | Upvalues: Roact (copy) ]]
	local v1 = Roact.Component:extend("App")
	local ReportCrew = require(script.Parent.ReportCrew)
	function v1.init(p1) --[[ Line: 7 ]] end
	function v1.render(p1) --[[ Line: 8 | Upvalues: Roact (ref), ReportCrew (copy) ]]
		return Roact.createElement(ReportCrew, {
			onSubmit = function(p1, p2) --[[ Name: onSubmit | Line: 10 ]]
				print(p1)
				print(p2)
			end,
			onClose = function() --[[ Name: onClose | Line: 14 ]]
				print("wants to close")
			end
		})
	end
	function v1.willUnmount(p1) --[[ Line: 19 ]] end
	local v2 = Roact.mount(Roact.createElement(v1), p1)
	return function() --[[ Line: 22 | Upvalues: Roact (ref), v2 (copy) ]]
		Roact.unmount(v2)
	end
end