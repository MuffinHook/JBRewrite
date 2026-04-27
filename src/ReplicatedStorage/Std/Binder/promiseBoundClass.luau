local Promise = require(script.Parent.Parent.Promise)
local Maid = require(script.Parent.Parent.Maid)
return function(binder, instance)
	local tracebackStack = debug.traceback()
	local existingInstance = binder:Get(instance)
	if existingInstance then
		return Promise.resolve(existingInstance)
	else
		local cleanupMaid = Maid.new()
		local instancePromise = Promise.defer(function(resolver)
			local resolvedValue = binder:Get(instance)
			if resolvedValue then
				resolver(resolvedValue)
			else
				cleanupMaid:GiveTask(binder:ObserveInstance(instance, function(observedInstance)
					resolver(observedInstance)
				end))
			end
		end)
		instancePromise:finally(function()
			cleanupMaid:Destroy()
		end)
		task.delay(5, function()
			if instancePromise:getStatus() == Promise.Status.Started then
				warn(("[promiseBoundClass] - Infinite yield possible on %q for binder %q\n"):format(instance:GetFullName(), binder:GetTag()))
				warn(tracebackStack)
			end
		end)
		return instancePromise
	end
end
