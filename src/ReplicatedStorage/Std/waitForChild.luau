local Promise = require(script.Parent.Promise)
local Maid = require(script.Parent.Maid)
return function(parent, childName, timeout)
	local foundChild = parent:FindFirstChild(childName)
	if foundChild then
		return Promise.resolve(foundChild)
	else
		local maid = Maid.new()
		local promise = Promise.new(function(resolve, reject)
			maid:GiveTask(parent.ChildAdded:Connect(function(addedChild)
				if addedChild.Name == tostring(childName) then
					resolve(addedChild)
				end
			end))
			if timeout then
				maid:GivePromise(Promise.delay(timeout):andThen(function()
					reject(("[waitForChild] Timeout: no child of `%s` with name `%s`"):format(parent.Name, childName))
				end))
			end
		end)
		promise:finally(function()
			maid:Destroy()
		end)
		return promise
	end
end
