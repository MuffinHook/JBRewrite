-- Reviewed by Claude
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Promise = require(ReplicatedStorage.Std.Promise)
local Maid = require(ReplicatedStorage.Std.Maid)
return function(binder, instance)
	local boundClass = binder:Get(instance)
	if boundClass then
		return Promise.resolve(boundClass)
	else
		local cleanupMaid = Maid.new()
		local deferredPromise = Promise.defer(function(resolve)
			local boundClass = binder:Get(instance)
			if boundClass then
				resolve(boundClass)
			else
				cleanupMaid:GiveTask(binder:ObserveInstance(instance, function(boundClass)
					resolve(boundClass)
				end))
			end
		end)
		deferredPromise:finally(function()
			cleanupMaid:Destroy()
		end)
		task.delay(5, function()
			if deferredPromise:getStatus() == Promise.Status.Started then
				warn(("[promiseBoundClass] - Infinite yield possible on %q for binder %q\n"):format(instance:GetFullName(), binder:GetTag()))
			end
		end)
		return deferredPromise
	end
end
