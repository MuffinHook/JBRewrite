local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local Maid = require(ReplicatedStorage.Std.Maid)
local function triangleWave(progress)
	if progress / 2 % 1 < 0.5 then
		return progress % 1
	else
		return 1 - progress % 1
	end
end
return function(mountingTarget)
	local EyelidsComponent = Roact.Component:extend("App")
	local Eyelids = require(script.Parent.Eyelids)
	function EyelidsComponent.init(instance)
		local pctClosedBinding, updatePctClosedBinding = Roact.createBinding(1)
		instance.pctClosed = pctClosedBinding
		instance.updatePctClosed = updatePctClosedBinding
		instance.maid = Maid.new()
	end
	function EyelidsComponent.didMount(instance)
		instance.maid:GiveTask(RunService.Heartbeat:Connect(function()
			local elapsedTime = os.clock()
			instance.updatePctClosed(TweenService:GetValue(if elapsedTime / 2 % 1 < 0.5 then elapsedTime % 1 else 1 - elapsedTime % 1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut))
		end))
	end
	function EyelidsComponent.willUnmount(instance)
		instance.maid:DoCleaning()
	end
	function EyelidsComponent.render(instance)
		return Roact.createElement(Eyelids, {
			pctClosed = instance.pctClosed
		})
	end
	local mountedEyelids = Roact.mount(Roact.createElement(EyelidsComponent), mountingTarget)
	return function()
		Roact.unmount(mountedEyelids)
	end
end
