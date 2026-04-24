-- Reviewed by Claude
-- variables reassigned
local Promise = require(script.Parent.Promise)
local Maid = require(script.Parent.Maid)
return function(p1, p2, p3)
	local v1 = p1:FindFirstChild(p2)
	if v1 then
		return Promise.resolve(v1)
	else
		local v2 = Maid.new()
		local v3 = Promise.new(function(p12, p22)
			v2:GiveTask(p1.ChildAdded:Connect(function(p1)
				if p1.Name == tostring(p2) then
					p12(p1)
				end
			end))
			if p3 then
				v2:GivePromise(Promise.delay(p3):andThen(function()
					p22(("[waitForChild] Timeout: no child of `%s` with name `%s`"):format(p1.Name, p2))
				end))
			end
		end)
		v3:finally(function()
			v2:Destroy()
		end)
		return v3
	end
end
