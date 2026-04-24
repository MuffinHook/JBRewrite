-- Reviewed by Claude
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local Maid = require(ReplicatedStorage.Std.Maid)
local function f(p1)
	if p1 / 2 % 1 < 0.5 then
		return p1 % 1
	else
		return 1 - p1 % 1
	end
end
return function(p1)
	local v1 = Roact.Component:extend("App")
	local Eyelids = require(script.Parent.Eyelids)
	function v1.init(p1)
		local v1, v2 = Roact.createBinding(1)
		p1.pctClosed = v1
		p1.updatePctClosed = v2
		p1.maid = Maid.new()
	end
	function v1.didMount(p1)
		p1.maid:GiveTask(RunService.Heartbeat:Connect(function()
			local v1 = os.clock()
			p1.updatePctClosed(TweenService:GetValue(if v1 / 2 % 1 < 0.5 then v1 % 1 else 1 - v1 % 1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut))
		end))
	end
	function v1.willUnmount(p1)
		p1.maid:DoCleaning()
	end
	function v1.render(p1)
		return Roact.createElement(Eyelids, {
			pctClosed = p1.pctClosed
		})
	end
	local v2 = Roact.mount(Roact.createElement(v1), p1)
	return function()
		Roact.unmount(v2)
	end
end
