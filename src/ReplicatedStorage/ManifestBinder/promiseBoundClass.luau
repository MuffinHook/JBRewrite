local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Promise = require(ReplicatedStorage.Std.Promise)
local Maid = require(ReplicatedStorage.Std.Maid)
return function(p1, p2) --[[ Line: 6 | Upvalues: Promise (copy), Maid (copy) ]]
	local v1 = p1:Get(p2)
	if v1 then
		return Promise.resolve(v1)
	else
		local v2 = Maid.new()
		local v3 = Promise.defer(function(p12) --[[ Line: 12 | Upvalues: p1 (copy), p2 (copy), v2 (copy) ]]
			local v1 = p1:Get(p2)
			if v1 then
				p12(v1)
			else
				v2:GiveTask(p1:ObserveInstance(p2, function(p1) --[[ Line: 17 | Upvalues: p12 (copy) ]]
					p12(p1)
				end))
			end
		end)
		v3:finally(function() --[[ Line: 22 | Upvalues: v2 (copy) ]]
			v2:Destroy()
		end)
		task.delay(5, function() --[[ Line: 25 | Upvalues: v3 (copy), Promise (ref), p2 (copy), p1 (copy) ]]
			if v3:getStatus() == Promise.Status.Started then
				warn(("[promiseBoundClass] - Infinite yield possible on %q for binder %q\n"):format(p2:GetFullName(), p1:GetTag()))
			end
		end)
		return v3
	end
end